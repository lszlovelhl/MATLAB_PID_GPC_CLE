#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
test_verify.py — 江油拉豪水泥 GPC/PID 重构等价性验证（Python/numpy 移植版）

因本机 MATLAB R2025a 许可过期无法直接运行 .m，故将本工程原版
gpc_clac.m / gpc_clac1.m / pid_calc.m 与重构版 gpc_clac_v2 /
gpc_clac1_v2 / pid_calc_v2 的算法逐行翻译为 numpy，用相同输入对比输出，
断言“默认参数下重构版输出与原版逐位一致”（容差 1e-9）。

两个 GPC 变体分别验证：
  - gpc_clac  → gpc_clac_v2   （现场默认 N=80, Nu=20, control_gain=0.7）
  - gpc_clac1 → gpc_clac1_v2  （现场默认 N=50, Nu=15, control_gain=0.7）

用法：python3 test_verify.py
"""
import time
import numpy as np

# ================= 工具函数（模拟 MATLAB 语义） =================

def polyadd(x1, x2):
    """多项式低次对齐相加（对应原工程 polyadd.m）。"""
    x1 = np.asarray(x1, float)
    x2 = np.asarray(x2, float)
    n1, n2 = len(x1), len(x2)
    if n1 > n2:
        x2 = np.concatenate([np.zeros(n1 - n2), x2])
    elif n1 < n2:
        x1 = np.concatenate([np.zeros(n2 - n1), x1])
    return x1 + x2


def deconv_q(u, v):
    """多项式除法取商（对应 MATLAB deconv(u,v) 的第一个返回值 q）。"""
    q, _ = np.polydiv(np.asarray(u, float), np.asarray(v, float))
    return q


# ================= GPC 预测矩阵（两版共用，与原版内联逻辑一致） =================

def gpc_matrices(A, B, N, Nu):
    """GPC 预测矩阵构造（Diophantine + G/F/H）。
    与原版 gpc_clac.m / gpc_clac1.m 内联段逐行一致，gpc_matrices_v2.m 同构。"""
    na, nb = len(A) - 1, len(B) - 1
    delta = np.array([-1.0, 1.0])
    Z = np.array([1.0, 0.0])
    Adelta = np.convolve(A, delta)

    # Zj{j} 表示 z^{-j}，长度 j+1：首项 1，余 0
    Zj = []
    for j in range(N - 1):
        zj = np.zeros(j + 2)
        zj[0] = 1.0
        Zj.append(zj)

    # 第一步：Diophantine 递推求 E_j、F_j
    E = [np.array([1.0])]
    F = [deconv_q(polyadd([1.0], -Adelta), Z)]
    for j in range(N - 1):
        E.append(polyadd(E[j], F[j][na] * Zj[j]))
        F.append(deconv_q(polyadd(F[j], -(F[j][na] * Adelta)), Z))

    # 第二步：由 E_j、B 构造 G_j、H_j
    G, H = [], []
    for j in range(N):
        EB = np.convolve(E[j], B)
        L = len(EB)
        H.append(EB[0:L - j])            # EB(1:length(EB)-j+1)，长度恒 nb+1
        G.append(EB[L - j - 1:L])       # EB(length(EB)-j+1:length(EB))，长度恒 j+1

    # 第三步：fliplr 翻转（低次在前）
    E = [np.flip(e) for e in E]
    F = [np.flip(f) for f in F]
    G = [np.flip(g) for g in G]
    H = [np.flip(h) for h in H]

    # 第四步：组装 F_、H_、G_
    F_ = np.zeros((N, na + 1))
    H_ = np.zeros((N, nb + 1))
    for j in range(N):
        F_[j, 0:na + 1] = F[j]
        H_[j, 0:nb + 1] = H[j]
    G_ = np.zeros((N, Nu))
    for i in range(Nu):
        G_[:, i] = np.concatenate([np.zeros(i), G[N - 1][0:N - i]])
    return F_, H_, G_


# ================= 原版 gpc_clac.m / gpc_clac1.m 的逐行移植 =================

def gpc_orig(A, B, P, y, u, yr, a, lmd, N, Nu):
    """原版 GPC 逻辑（N/Nu 由调用方给定：gpc_clac=80/20，gpc_clac1=50/15）。
    逐行对应江油原版：ye=abs(yr-y(3))，oldY=[y(3);y(2)]，u=u(2)+0.7*deltaU(1)。"""
    na, nb = len(A) - 1, len(B) - 1

    # 在线递推辨识段（原版死代码：结果不反馈 A/B，也不影响输出 u；此处照写以保真）
    THETA = np.concatenate([-A[na - 1::-1], B[::-1]]).reshape(-1, 1)
    PHI = np.array([[y[1]], [u[1]]])
    THETA = THETA + P @ PHI * (y[-1] - THETA.T @ PHI) / (1 + PHI.T @ P @ PHI)
    P = P - P @ PHI @ PHI.T @ P / (1 + PHI.T @ P @ PHI)

    F_, H_, G_ = gpc_matrices(A, B, N, Nu)

    olddeltaU = u[1] - u[0]                          # 单步差分
    oldY = np.array([y[2], y[1]]).reshape(-1, 1)     # y(3:-1:2)'（na=1）
    Y0 = F_ @ oldY + H_ * olddeltaU

    yd = np.zeros((N, 1))
    yd[0] = y[-1]
    for j in range(1, N):
        yd[j] = a * yd[j - 1] + (1 - a) * yr
    Yd = yd

    ye = abs(yr - y[2])                               # 原版 ye=abs(yr-y(3))
    lmd_eff = lmd / 15 * ye + 2 / 3 * lmd

    K = np.linalg.solve(G_.T @ G_ + lmd_eff * np.eye(Nu), G_.T)
    deltaU = K @ (Yd - Y0)
    return u[1] + 0.7 * deltaU[0, 0]


# ================= 重构版 gpc_clac_v2 / gpc_clac1_v2 的移植 =================

def gpc_v2(A, B, P, y, u, yr, a, lmd, N_default, Nu_default, opts=None):
    """重构版 GPC 逻辑。opts 不传时 N/Nu/control_gain 取现场默认，与原版一致。
    v2 用 y(end) 表示当前输出（y 长度为 3 时 y(end)==y(3)，与原版逐位一致）。"""
    opts = opts or {}
    N = opts.get('N', N_default)
    Nu = opts.get('Nu', Nu_default)
    ctrl_g = opts.get('control_gain', 0.7)
    dN = opts.get('deltaU_history', 1)
    N = max(int(N), 1)
    Nu = max(int(Nu), 1)
    Nu = min(Nu, N)
    if not (0 < a < 1):
        a = 0.8
    na, nb = len(A) - 1, len(B) - 1

    F_, H_, G_ = gpc_matrices(A, B, N, Nu)

    # 自由响应初值（v2：取最近 na+1 个输出倒序）
    oldY = np.asarray(y[::-1][:na + 1], float).reshape(-1, 1)
    if dN <= 1:
        olddeltaU = u[1] - u[0]
    else:
        if len(u) >= dN + 1 and dN == nb + 1:
            uk = np.asarray(u[-dN - 1:], float)
            olddeltaU = np.diff(uk).reshape(-1, 1)
        else:
            olddeltaU = u[1] - u[0]
    Y0 = F_ @ oldY + (H_ * olddeltaU if np.isscalar(olddeltaU) else H_ @ olddeltaU)

    yd = np.zeros((N, 1))
    yd[0] = y[-1]
    for j in range(1, N):
        yd[j] = a * yd[j - 1] + (1 - a) * yr
    Yd = yd

    ye = abs(yr - y[-1])                              # v2：当前输出 y(end)
    lmd_eff = lmd / 15 * ye + 2 / 3 * lmd

    K = np.linalg.solve(G_.T @ G_ + lmd_eff * np.eye(Nu), G_.T)
    deltaU = K @ (Yd - Y0)
    return u[1] + ctrl_g * deltaU[0, 0]


# ================= PID =================

def pid_orig(para):
    """原版 pid_calc.m 逻辑（13 元素数组）。"""
    kp, ti, td = para[6], para[7], para[8]
    sp, pv = para[0], para[1]
    e0 = para[0] - para[1]
    e1, e2 = para[4], para[5]
    mv = para[2]
    man_on = para[9]
    ulim, llim, deadzone = para[10], para[11], para[12]
    du = kp * ((e0 - e1) + 1 / ti * e0 + td * (e0 - 2 * e1 + e2))
    if abs(pv - sp) < deadzone:
        du = 0.0
    mv = mv + du
    if mv >= ulim:
        mv = ulim
    if mv <= llim:
        mv = llim
    e2, e1 = e1, e0
    return np.array([sp, pv, mv, e0, e1, e2, kp, ti, td, man_on, ulim, llim, deadzone])


def pid_v2(para):
    """重构版 pid_calc_v2：ti<=0 除零防护，其余与原版一致。"""
    sp, pv = para[0], para[1]
    mv = para[2]
    e0 = para[0] - para[1]
    e1, e2 = para[4], para[5]
    kp, ti, td = para[6], para[7], para[8]
    man_on = para[9]
    ulim, llim, deadzone = para[10], para[11], para[12]
    integral_term = (e0 / ti) if ti > 0 else 0.0    # 修复除零
    du = kp * ((e0 - e1) + integral_term + td * (e0 - 2 * e1 + e2))
    if abs(pv - sp) < deadzone:
        du = 0.0
    mv = mv + du
    if mv >= ulim:
        mv = ulim
    if mv <= llim:
        mv = llim
    e2, e1 = e1, e0
    return np.array([sp, pv, mv, e0, e1, e2, kp, ti, td, man_on, ulim, llim, deadzone])


# ================= 主测试 =================

def check_gpc_variant(tag, N_def, Nu_def, rng, models):
    """验证某一 GPC 变体：原版 vs 重构版默认输出逐位一致。返回 (ok, max_diff)。"""
    P0 = np.array([[0.01, 0.01], [0.01, 0.01]])
    ok = True
    max_diff = 0.0
    for A, B, mtag in models:
        for trial in range(4):
            yr = 800 + 50 * trial
            y = 810 + 40 * trial + 3 * rng.standard_normal(3)
            u = 15 + 2 * trial + 0.5 * rng.standard_normal(2)
            u_orig = gpc_orig(A, B, P0.copy(), y, u, yr, 0.998, 4400, N_def, Nu_def)
            u_v2 = gpc_v2(A, B, P0.copy(), y, u, yr, 0.998, 4400, N_def, Nu_def)
            diff = abs(u_orig - u_v2)
            max_diff = max(max_diff, diff)
            if diff > 1e-9:
                print(f'  [FAIL] {tag}/{mtag} trial{trial}: orig={u_orig:.12f} '
                      f'v2={u_v2:.12f} diff={diff:.3e}')
                ok = False
    return ok, max_diff


def main():
    rng = np.random.default_rng(42)
    ok_all = True
    TOL = 1e-9

    models = [
        (np.array([-0.9769, 1.0]), np.array([0.8642]), '模型1'),
        (np.array([-0.9931, 1.0]), np.array([-0.001244]), '模型2'),
        (np.array([-0.95, 1.0]), np.array([1.2]), '测试1'),
        (np.array([-0.88, 1.0]), np.array([-2.5]), '测试2(负增益)'),
    ]

    # ---- 1a. gpc_clac → gpc_clac_v2（N=80, Nu=20）----
    print('==== 1a. gpc_clac → gpc_clac_v2 默认输出一致性 (N=80, Nu=20) ====')
    ok, md = check_gpc_variant('gpc_clac', 80, 20, rng, models)
    print(f'  4 组模型 × 4 组随机输入：全部一致 ✓（最大 |Δ|={md:.3e}）'
          if ok else '  存在不一致')
    ok_all &= ok

    # ---- 1b. gpc_clac1 → gpc_clac1_v2（N=50, Nu=15）----
    print('==== 1b. gpc_clac1 → gpc_clac1_v2 默认输出一致性 (N=50, Nu=15) ====')
    ok, md = check_gpc_variant('gpc_clac1', 50, 15, rng, models)
    print(f'  4 组模型 × 4 组随机输入：全部一致 ✓（最大 |Δ|={md:.3e}）'
          if ok else '  存在不一致')
    ok_all &= ok

    # ---- 2. PID 正常参数输出一致性 ----
    print('==== 2. pid_calc → pid_calc_v2 正常参数一致性 ====')
    ok = True
    md = 0.0
    for trial in range(8):
        para = np.array([100 * rng.random(), 100 * rng.random(), 20 * rng.random(), 0,
                         0.5 * rng.random() - 0.25, 0.5 * rng.random() - 0.25,
                         5 * rng.random(), 10 + 40 * rng.random(), rng.random(), 0,
                         40 + 20 * rng.random(), 0, 0.01])
        p_orig = pid_orig(para)
        p_v2 = pid_v2(para)
        d = np.max(np.abs(p_orig - p_v2))
        md = max(md, d)
        if d > TOL:
            print(f'  [FAIL] trial{trial}: max|diff|={d:.3e}')
            ok = False
    print(f'  8 组随机输入：全部一致 ✓（最大 |Δ|={md:.3e}）' if ok else '  存在不一致')
    ok_all &= ok

    # ---- 2b. ti=0 除零防护 ----
    para_ti0 = np.array([100, 90, 5, 0, 0, 0, 2, 0, 0, 0, 20, 0, 0.01])
    p_ti0 = pid_v2(para_ti0)
    if not np.all(np.isfinite(p_ti0)):
        print('  [FAIL] ti=0 重构版产生非有限值'); ok_all = False
    elif not (para_ti0[11] <= p_ti0[2] <= para_ti0[10]):
        print('  [FAIL] ti=0 输出越限'); ok_all = False
    else:
        print(f'  PID ti=0 除零防护通过（mv={p_ti0[2]:.6g}，有限且限幅内）✓')

    # ---- 3. GPC 参数化（时域可配置）----
    print('==== 3. GPC 时域参数化 ====')
    A, B = models[0][0], models[0][1]
    P0 = np.array([[0.01, 0.01], [0.01, 0.01]])
    y = 810 + 3 * rng.standard_normal(3)
    u = 15 + 0.5 * rng.standard_normal(2)
    u_n60 = gpc_v2(A, B, P0.copy(), y, u, 850, 0.998, 4400, 80, 20,
                   dict(N=60, Nu=15))
    print(f'  gpc_clac_v2 改 N=60,Nu=15 输出: {u_n60:.12f}（时域可配置 ✓）')
    u_cg = gpc_v2(A, B, P0.copy(), y, u, 850, 0.998, 4400, 50, 15,
                  dict(control_gain=0.5))
    print(f'  gpc_clac1_v2 改 control_gain=0.5 输出: {u_cg:.12f}（步进系数可配置 ✓）')

    # ---- 4. 性能对比 ----
    print('==== 4. 性能对比（100 次，gpc_clac N=80/Nu=20）====')
    n = 100
    t0 = time.perf_counter()
    for _ in range(n):
        yy = 810 + 3 * rng.standard_normal(3); uu = 15 + 0.5 * rng.standard_normal(2)
        gpc_orig(A, B, P0.copy(), yy, uu, 850, 0.998, 4400, 80, 20)
    dt_orig = time.perf_counter() - t0
    t0 = time.perf_counter()
    for _ in range(n):
        yy = 810 + 3 * rng.standard_normal(3); uu = 15 + 0.5 * rng.standard_normal(2)
        gpc_v2(A, B, P0.copy(), yy, uu, 850, 0.998, 4400, 80, 20)
    dt_v2 = time.perf_counter() - t0
    print(f'  原版(含死代码辨识) : {dt_orig:.4f} s')
    print(f'  重构版(无缓存)     : {dt_v2:.4f} s')
    t0 = time.perf_counter()
    for _ in range(n):
        gpc_matrices(A, B, 80, 20)
    dt_m = time.perf_counter() - t0
    print(f'  预测矩阵一次性构造 : {dt_m:.4f} s/{n} 次（use_cached 开启后在线部分可省去这块）')

    print()
    print('================================')
    if ok_all:
        print('全部 PASS：两个 GPC 变体默认输出均与原版逐位一致，ti=0 防护有效。')
    else:
        print('存在 FAIL，请检查。')
    return 0 if ok_all else 1


if __name__ == '__main__':
    raise SystemExit(main())
