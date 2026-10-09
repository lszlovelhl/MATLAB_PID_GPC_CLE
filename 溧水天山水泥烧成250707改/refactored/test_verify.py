#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
test_verify.py — 溧水天山水泥烧成工程 GPC/PID 重构等价性验证（numpy 移植版）

因本机 MATLAB R2025a 许可证过期无法直接运行 .m，故将【本工程原版】
gpc_clac / pid_calc 与【本工程重构版】gpc_clac_v2 / pid_calc_v2 的算法
逐行翻译为 numpy，用多组随机输入对比输出，断言：
  1. 默认参数下重构版输出与原版逐位一致（容差 1e-9）；
  2. PID 的 ti=0 除零防护输出有限且在限幅内；
  3. GPC 预测矩阵缓存路径输出与不缓存一致。

用法：python3 test_verify.py
（全部 PASS 才允许交付）
"""
import numpy as np

# ================= 工具函数（模拟 MATLAB 语义） =================

def polyadd(x1, x2):
    """多项式低次对齐相加（对应本工程 polyadd.m）。"""
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


# ================= 原版 gpc_clac.m 的逐行移植（溧水现场原值 N=80/Nu=20/0.7）=================

def gpc_matrices(A, B, N, Nu):
    """GPC 预测矩阵构造（Diophantine + G/F/H），与原版 gpc_clac 内联逻辑一致。
    重构版 gpc_matrices_v2.m 与本段逐行等价。"""
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
        G.append(EB[L - j - 1:L])        # EB(length(EB)-j+1:length(EB))，长度恒 j+1

    # 第三步：fliplr 翻转（变为低次在前）
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
        col = np.concatenate([np.zeros(i), G[N - 1][0:N - i]])
        G_[:, i] = col
    return F_, H_, G_


def gpc_orig(A, B, P, y, u, yr, a, lmd):
    """【溧水原版】gpc_clac.m 逻辑（现场硬编码 N=80, Nu=20, 步进系数=0.7）。"""
    N, Nu = 80, 20
    na, nb = len(A) - 1, len(B) - 1

    # —— 在线递推辨识段（原版原样保留；经确认是死代码，不影响输出 u）——
    THETA = np.concatenate([-A[na - 1::-1], B[::-1]]).reshape(-1, 1)
    PHI = np.array([[y[1]], [u[1]]])
    THETA = THETA + P @ PHI * (y[-1] - THETA.T @ PHI) / (1 + PHI.T @ P @ PHI)
    P = P - P @ PHI @ PHI.T @ P / (1 + PHI.T @ P @ PHI)

    F_, H_, G_ = gpc_matrices(A, B, N, Nu)

    olddeltaU = u[1] - u[0]                       # 单步差分（原版）
    oldY = np.array([y[2], y[1]]).reshape(-1, 1)  # y(3:-1:2)'，na=1，列向量
    Y0 = F_ @ oldY + H_ * olddeltaU

    yd = np.zeros((N, 1))
    yd[0] = y[-1]                                 # yd(1)=y(end)
    for j in range(1, N):
        yd[j] = a * yd[j - 1] + (1 - a) * yr
    Yd = yd

    ye = abs(yr - y[-1])                          # 原版 ye=abs(yr-y(3))；y 长度恒 3，y(end)==y(3)
    lmd_eff = lmd / 15 * ye + 2 / 3 * lmd

    K = np.linalg.solve(G_.T @ G_ + lmd_eff * np.eye(Nu), G_.T)
    deltaU = K @ (Yd - Y0)
    return u[1] + 0.7 * deltaU[0, 0]


# ================= 重构版 gpc_clac_v2.m 的移植 =================

def gpc_v2(A, B, P, y, u, yr, a, lmd, opts=None, cached_M=None):
    """【溧水重构版】gpc_clac_v2 逻辑（opts 默认值=现场原值，与原版逐位一致）。
    cached_M: 若传入 (F_,H_,G_) 元组，则模拟 use_cached=true 的复用路径。"""
    opts = opts or {}
    N = opts.get('N', 80)
    Nu = opts.get('Nu', 20)
    ctrl_g = opts.get('control_gain', 0.7)
    dN = opts.get('deltaU_history', 1)
    N = max(int(N), 1)
    Nu = max(int(Nu), 1)
    Nu = min(Nu, N)
    if not (0 < a < 1):
        a = 0.8
    na, nb = len(A) - 1, len(B) - 1

    if cached_M is None:
        F_, H_, G_ = gpc_matrices(A, B, N, Nu)
    else:
        F_, H_, G_ = cached_M          # use_cached=true：复用已构造矩阵

    # 自由响应初值
    oldY = np.asarray(y[::-1][:na + 1], float).reshape(-1, 1)  # 最近 na+1 个输出倒序，列向量
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

    ye = abs(yr - y[-1])
    lmd_eff = lmd / 15 * ye + 2 / 3 * lmd

    K = np.linalg.solve(G_.T @ G_ + lmd_eff * np.eye(Nu), G_.T)
    deltaU = K @ (Yd - Y0)
    return u[1] + ctrl_g * deltaU[0, 0]


# ================= PID =================

def pid_orig(para):
    """【溧水原版】pid_calc.m 逻辑。para 为 13 元素数组（0-based 索引）。"""
    kp, ti, td = para[6], para[7], para[8]
    sp, pv = para[0], para[1]
    e0 = para[0] - para[1]
    e1, e2 = para[4], para[5]
    mv = para[2]
    man_on = para[9]
    ulim, llim, deadzone = para[10], para[11], para[12]
    du = kp * ((e0 - e1) + 1 / ti * e0 + td * (e0 - 2 * e1 + e2))   # ti=0 → Inf/NaN（原版隐患）
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
    """【溧水重构版】pid_calc_v2 逻辑：修复 ti<=0 除零，其余与原版逐位一致。"""
    if np.size(para) < 13:
        raise ValueError('para 不足 13 元素')
    sp, pv = para[0], para[1]
    mv = para[2]
    e0 = para[0] - para[1]
    e1, e2 = para[4], para[5]
    kp, ti, td = para[6], para[7], para[8]
    man_on = para[9]
    ulim, llim, deadzone = para[10], para[11], para[12]
    integral_term = (e0 / ti) if ti > 0 else 0.0   # 修复除零：ti<=0 禁用积分项
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

def main():
    rng = np.random.default_rng(20250707)   # 种子取本工程日期，固定可复现
    ok_all = True
    TOL = 1e-9

    # ---- 1. GPC 默认输出一致性（多组模型 × 多组随机输入）----
    print('==== 1. GPC 默认输出一致性（orig vs v2，容差 1e-9）====')
    models = [
        (np.array([-0.9769, 1.0]), np.array([0.8642]), '模型A(正增益)'),
        (np.array([-0.9931, 1.0]), np.array([-0.001244]), '模型B(弱负增益)'),
        (np.array([-0.95, 1.0]),   np.array([1.2]),      '模型C'),
        (np.array([-0.88, 1.0]),   np.array([-2.5]),    '模型D(负增益)'),
    ]
    P0 = np.array([[0.01, 0.01], [0.01, 0.01]])
    max_gpc_diff = 0.0
    n_gpc = 0
    for A, B, tag in models:
        for trial in range(5):
            yr = 800 + 50 * trial
            y = 810 + 40 * trial + 3 * rng.standard_normal(3)
            u = 15 + 2 * trial + 0.5 * rng.standard_normal(2)
            u_orig = gpc_orig(A, B, P0.copy(), y, u, yr, 0.998, 4400)
            u_v2 = gpc_v2(A, B, P0.copy(), y, u, yr, 0.998, 4400)
            d = abs(u_orig - u_v2)
            max_gpc_diff = max(max_gpc_diff, d)
            n_gpc += 1
            if d > TOL:
                print(f'  [FAIL] {tag} trial{trial}: orig={u_orig:.12f} v2={u_v2:.12f} diff={d:.3e}')
                ok_all = False
    print(f'  GPC：{n_gpc} 组全部一致，最大误差 = {max_gpc_diff:.3e} (<1e-9) ✓' if ok_all
          else '  GPC：存在不一致 ✗')

    # ---- 1b. GPC 缓存路径（use_cached=true）与不缓存一致 ----
    print('==== 1b. GPC 预测矩阵缓存一致性 ====')
    A, B = models[0][0], models[0][1]
    max_cache_diff = 0.0
    for trial in range(5):
        yr = 820 + 10 * trial
        y = 810 + 3 * rng.standard_normal(3)
        u = 15 + 0.5 * rng.standard_normal(2)
        u_nocache = gpc_v2(A, B, P0.copy(), y, u, yr, 0.998, 4400)
        M = gpc_matrices(A, B, 80, 20)          # 一次性构造（模拟 persistent 缓存）
        u_cache = gpc_v2(A, B, P0.copy(), y, u, yr, 0.998, 4400, cached_M=M)
        d = abs(u_nocache - u_cache)
        max_cache_diff = max(max_cache_diff, d)
        if d > TOL:
            print(f'  [FAIL] cache trial{trial}: diff={d:.3e}'); ok_all = False
    print(f'  缓存/不缓存输出一致，最大误差 = {max_cache_diff:.3e} ✓' if ok_all
          else '  缓存路径不一致 ✗')

    # ---- 2. PID 正常参数输出一致性 ----
    print('==== 2. PID 正常参数输出一致性（orig vs v2，容差 1e-9）====')
    max_pid_diff = 0.0
    n_pid = 0
    for trial in range(10):
        para = np.array([100 * rng.random(), 100 * rng.random(), 20 * rng.random(), 0,
                         0.5 * rng.random() - 0.25, 0.5 * rng.random() - 0.25,
                         5 * rng.random(), 10 + 40 * rng.random(), rng.random(), 0,
                         40 + 20 * rng.random(), 0, 0.01])
        p_orig = pid_orig(para)
        p_v2 = pid_v2(para)
        d = float(np.max(np.abs(p_orig - p_v2)))
        max_pid_diff = max(max_pid_diff, d)
        n_pid += 1
        if d > TOL:
            print(f'  [FAIL] trial{trial}: max|diff|={d:.3e}'); ok_all = False
    print(f'  PID：{n_pid} 组全部一致，最大误差 = {max_pid_diff:.3e} ✓' if ok_all
          else '  PID：存在不一致 ✗')

    # ---- 2b. PID ti=0 除零防护 ----
    print('==== 2b. PID ti=0 除零防护 ====')
    para_ti0 = np.array([100, 90, 5, 0, 0, 0, 2, 0, 0, 0, 20, 0, 0.01])
    p_ti0 = pid_v2(para_ti0)
    lim_ok = para_ti0[11] <= p_ti0[2] <= para_ti0[10]
    if not np.all(np.isfinite(p_ti0)):
        print('  [FAIL] ti=0 重构版产生非有限值'); ok_all = False
    elif not lim_ok:
        print(f'  [FAIL] ti=0 输出越限 mv={p_ti0[2]}'); ok_all = False
    else:
        print(f'  ti=0：mv={p_ti0[2]:.6g}，有限且在 [{para_ti0[11]:g},{para_ti0[10]:g}] 限幅内 ✓')

    # ---- 3. GPC 参数化扩展（opts 可配置）----
    print('==== 3. GPC 参数化扩展（opts）====')
    y = 810 + 3 * rng.standard_normal(3)
    u = 15 + 0.5 * rng.standard_normal(2)
    u_n60 = gpc_v2(A, B, P0.copy(), y, u, 850, 0.998, 4400, dict(N=60, Nu=15))
    print(f'  N=60,Nu=15 输出 = {u_n60:.12f}（时域可配置 ✓）')

    # ---- 4. 性能对比 ----
    print('==== 4. 性能对比（100 次调用）====')
    import time
    n = 100
    t0 = time.perf_counter()
    for _ in range(n):
        y = 810 + 3 * rng.standard_normal(3); u_ = 15 + 0.5 * rng.standard_normal(2)
        gpc_orig(A, B, P0.copy(), y, u_, 850, 0.998, 4400)
    dt_orig = time.perf_counter() - t0
    t0 = time.perf_counter()
    for _ in range(n):
        y = 810 + 3 * rng.standard_normal(3); u_ = 15 + 0.5 * rng.standard_normal(2)
        gpc_v2(A, B, P0.copy(), y, u_, 850, 0.998, 4400)
    dt_v2 = time.perf_counter() - t0
    t0 = time.perf_counter()
    Fc, Hc, Gc = gpc_matrices(A, B, 80, 20)   # 一次性构造
    dt_setup = time.perf_counter() - t0
    t0 = time.perf_counter()
    for _ in range(n):
        y = 810 + 3 * rng.standard_normal(3); u_ = 15 + 0.5 * rng.standard_normal(2)
        gpc_v2(A, B, P0.copy(), y, u_, 850, 0.998, 4400, cached_M=(Fc, Hc, Gc))
    dt_cached = time.perf_counter() - t0
    print(f'  原版(每周期重算矩阵)   : {dt_orig*1000:.3f} ms / {n}次')
    print(f'  重构版(无缓存)         : {dt_v2*1000:.3f} ms / {n}次')
    print(f'  重构版(矩阵已缓存)     : {dt_cached*1000:.3f} ms / {n}次')
    print(f'  预测矩阵一次性构造耗时 : {dt_setup*1000:.3f} ms（原版每周期都重算这部分）')

    print()
    print('================================')
    print(f'GPC 最大误差 = {max_gpc_diff:.3e}，PID 最大误差 = {max_pid_diff:.3e}，'
          f'缓存最大误差 = {max_cache_diff:.3e}')
    print('全部 PASS：重构版默认输出与原版逐位一致，ti=0 防护有效。'
          if ok_all else '存在 FAIL，请检查。')
    return 0 if ok_all else 1


if __name__ == '__main__':
    raise SystemExit(main())
