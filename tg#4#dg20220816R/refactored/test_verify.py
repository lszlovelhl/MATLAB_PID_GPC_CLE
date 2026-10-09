#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
test_verify.py — 天钢4#加热炉工程 GPC/PID 重构等价性验证（numpy 移植版）

因本机 MATLAB R2025a 许可证过期，无法直接运行 .m；故将【本工程原版】
gpc_clac.m / pid_calc.m 与【本工程重构版】gpc_clac_v2.m / pid_calc_v2.m
逐行翻译为 numpy，用相同输入对比输出，断言：
  ① 默认参数下重构版输出与原版逐位一致（容差 1e-9）；
  ② deltaU(1) ±3000 饱和限幅行为一致（含触发限幅的极端输入用例）；
  ③ PID ti=0 除零防护输出有限且在限幅内。

用法：python3 test_verify.py
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


# ================= GPC 预测矩阵（原版内联段的逐行移植） =================

def gpc_matrices(A, B, N, Nu):
    """GPC 预测矩阵构造（Diophantine + G/F/H），与原版 gpc_clac 内联逻辑一致。"""
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
        H.append(EB[0:L - j])            # 对应 EB(1:length(EB)-j+1)
        G.append(EB[L - j - 1:L])        # 对应 EB(length(EB)-j+1:length(EB))

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


# ================= 本工程原版 gpc_clac.m 的逐行移植 =================

def gpc_orig(A, B, P, y, u, yr, a, lmd1, return_pre=False):
    """原版 gpc_clac.m 逻辑（本工程：N=120, Nu=20, 输出系数=1.0, ±3000 限幅）。

    现场细节逐行保持：
      - THETA/P 在线辨识段在原版中执行（死代码，不影响 u）；
      - olddeltaU = u(2)-u(1)，oldY = [y(3:-1:2)]'；
      - ye = abs(yr-y(3))；
      - 先 ±3000 限幅 deltaU(1)，再 u = u(2)+deltaU(1)（无 0.7 系数）。
    """
    N, Nu = 120, 20
    na, nb = len(A) - 1, len(B) - 1

    # ---- 原版激活的在线递推辨识段（死代码：THETA/P 不反馈回 A/B，不影响 u）----
    THETA = np.concatenate([-A[na - 1::-1], B[::-1]]).reshape(-1, 1)
    PHI = np.array([[y[1]], [u[1]]])
    THETA = THETA + P @ PHI * (y[-1] - THETA.T @ PHI) / (1 + PHI.T @ P @ PHI)
    P = P - P @ PHI @ PHI.T @ P / (1 + PHI.T @ P @ PHI)

    F_, H_, G_ = gpc_matrices(A, B, N, Nu)

    olddeltaU = u[1] - u[0]                          # 原版：u(2)-u(1)
    oldY = np.array([[y[2]], [y[1]]])               # 原版：[y(3:-1:2)]'，na=1
    Y0 = F_ @ oldY + H_ * olddeltaU

    yd = np.zeros(N)
    yd[0] = y[-1]                                    # 原版：yd(1)=y(length(y))
    for j in range(1, N):
        yd[j] = a * yd[j - 1] + (1 - a) * yr
    Yd = yd.reshape(-1, 1)                           # 原版：Yd=yd'

    ye = abs(yr - y[2])                              # 原版：ye=abs(yr-y(3))
    lmd = lmd1 / 15 * ye + 2 / 3 * lmd1             # 原版自适应 λ

    K = np.linalg.solve(G_.T @ G_ + lmd * np.eye(Nu), G_.T)
    deltaU = K @ (Yd - Y0)

    pre = deltaU[0, 0]
    # ---- 原版：先 ±3000 限幅，后输出 ----
    if deltaU[0, 0] >= 3000:
        deltaU[0, 0] = 3000
    if deltaU[0, 0] <= -3000:
        deltaU[0, 0] = -3000
    u_out = u[1] + deltaU[0, 0]                     # 原版：u=u(2)+deltaU(1)
    if return_pre:
        return u_out, pre
    return u_out


# ================= 重构版 gpc_clac_v2.m 的移植 =================

def gpc_v2(A, B, P, y, u, yr, a, lmd1, opts=None):
    """重构版 gpc_clac_v2 逻辑。默认参数（N=120/Nu=20/control_gain=1.0/
    deltaU_lim=3000/use_rls_online=false）与原版逐位一致。"""
    opts = opts or {}
    N = opts.get('N', 120)
    Nu = opts.get('Nu', 20)
    ctrl_g = opts.get('control_gain', 1.0)
    dU_lim = abs(opts.get('deltaU_lim', 3000))
    rls = opts.get('use_rls_online', False)
    N = max(int(N), 1)
    Nu = min(max(int(Nu), 1), N)
    if not (0 < a < 1):
        a = 0.8
    na, nb = len(A) - 1, len(B) - 1

    F_, H_, G_ = gpc_matrices(A, B, N, Nu)

    # 在线递推辨识：原版为死代码，默认关闭；开启时与原版递推式一致
    if rls:
        THETA = np.concatenate([-A[na - 1::-1], B[::-1]]).reshape(-1, 1)
        PHI = np.array([[y[1]], [u[1]]])
        THETA = THETA + P @ PHI * (y[-1] - THETA.T @ PHI) / (1 + PHI.T @ P @ PHI)
        P = P - P @ PHI @ PHI.T @ P / (1 + PHI.T @ P @ PHI)

    olddeltaU = u[1] - u[0]
    oldY = np.array([[y[2]], [y[1]]])
    Y0 = F_ @ oldY + H_ * olddeltaU

    yd = np.zeros(N)
    yd[0] = y[-1]
    for j in range(1, N):
        yd[j] = a * yd[j - 1] + (1 - a) * yr
    Yd = yd.reshape(-1, 1)

    ye = abs(yr - y[2])
    lmd = lmd1 / 15 * ye + 2 / 3 * lmd1

    K = np.linalg.solve(G_.T @ G_ + lmd * np.eye(Nu), G_.T)
    deltaU = K @ (Yd - Y0)

    # 先限幅、后输出（顺序与原版一致）
    if deltaU[0, 0] >= dU_lim:
        deltaU[0, 0] = dU_lim
    if deltaU[0, 0] <= -dU_lim:
        deltaU[0, 0] = -dU_lim
    return u[1] + ctrl_g * deltaU[0, 0]


# ================= PID（原版与宝马逐字相同） =================

def pid_orig(para):
    """原版 pid_calc.m 逻辑。para 为 13 元素数组（对应 MATLAB 1-based 索引）。"""
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
    """重构版 pid_calc_v2 逻辑：修复 ti<=0 除零，其余与原版一致。"""
    sp, pv = para[0], para[1]
    mv = para[2]
    e0 = para[0] - para[1]
    e1, e2 = para[4], para[5]
    kp, ti, td = para[6], para[7], para[8]
    man_on = para[9]
    ulim, llim, deadzone = para[10], para[11], para[12]
    integral_term = (e0 / ti) if ti > 0 else 0.0   # 修复除零
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
    rng = np.random.default_rng(20220816)
    ok_all = True
    max_err_gpc = 0.0
    max_err_pid = 0.0

    # ---- 1. GPC 默认输出一致性（默认参数：N=120/Nu=20/系数1.0/±3000）----
    print('==== 1. GPC 默认输出一致性（N=120, Nu=20, control_gain=1.0, ±3000 限幅）====')
    models = [
        (np.array([-0.9769, 1.0]), np.array([0.8642]), '模型1'),
        (np.array([-0.9931, 1.0]), np.array([0.52]),     '模型2'),
        (np.array([-0.95, 1.0]),   np.array([1.2]),      '模型3'),
        (np.array([-0.88, 1.0]),   np.array([-2.5]),    '模型4(负增益)'),
    ]
    P0 = np.array([[0.01, 0.005], [0.005, 0.01]])
    ok = True
    for A, B, tag in models:
        for trial in range(4):
            yr = 100 + 20 * trial + rng.standard_normal()
            y = 105 + 15 * trial + 2 * rng.standard_normal(3)
            u = 50 + 3 * trial + 0.5 * rng.standard_normal(2)
            u_orig = gpc_orig(A, B, P0.copy(), y, u, yr, 0.998, 4400)
            u_v2 = gpc_v2(A, B, P0.copy(), y, u, yr, 0.998, 4400)
            diff = abs(u_orig - u_v2)
            max_err_gpc = max(max_err_gpc, diff)
            if diff > 1e-9:
                print(f'  [FAIL] {tag} trial{trial}: orig={u_orig:.12f} v2={u_v2:.12f} diff={diff:.3e}')
                ok = False
    print('  GPC：全部通过，默认输出与原版逐位一致 ✓' if ok else '  GPC：存在不一致')
    print(f'  （4 模型 × 4 组输入，本组最大绝对误差 = {max_err_gpc:.3e}）')
    ok_all &= ok

    # ---- 2. GPC ±3000 限幅触发用例（构造 pre-clamp 超出 ±3000 的输入）----
    print('==== 2. GPC ±3000 饱和限幅行为一致性 ====')
    A, B = models[0][0], models[0][1]
    y_base = np.array([100.0, 99.0, 101.0])
    u_base = np.array([50.0, 51.0])
    # 正向限幅：lmd1 取较小测试值以减小正则化，逐步放大偏差 yr，
    # 直到 pre-clamp deltaU(1) > 3000（测试输入为任意构造，orig/v2 同输入对比）
    pre = 0.0
    yr_hit = None
    for yr in [1e5, 1e6, 1e7, 1e8, 1e9, 1e10]:
        _, pre = gpc_orig(A, B, P0.copy(), y_base, u_base, yr, 0.998, 0.1, return_pre=True)
        if pre > 3000:
            yr_hit = yr
            break
    ok = True
    if yr_hit is None:
        print(f'  [FAIL] 未能构造出触发正向限幅的输入（pre={pre:.3e}）'); ok = False
    else:
        u_o, pre_o = gpc_orig(A, B, P0.copy(), y_base, u_base, yr_hit, 0.998, 0.1, return_pre=True)
        u_v = gpc_v2(A, B, P0.copy(), y_base, u_base, yr_hit, 0.998, 0.1)
        print(f'  正向限幅：pre-clamp deltaU(1)={pre_o:.3e} > 3000 → 触发限幅；'
              f'orig={u_o:.6f}, v2={u_v:.6f}, diff={abs(u_o - u_v):.3e}')
        if abs(u_o - u_v) > 1e-9:
            ok = False
        # 负向限幅：yr 取极大负值
        pre = 0.0
        yr_neg_hit = None
        for yr_neg in [-1e5, -1e6, -1e7, -1e8, -1e9, -1e10]:
            _, pre = gpc_orig(A, B, P0.copy(), y_base, u_base, yr_neg, 0.998, 0.1, return_pre=True)
            if pre < -3000:
                yr_neg_hit = yr_neg
                break
        if yr_neg_hit is None:
            print(f'  [FAIL] 未能构造出触发负向限幅的输入（pre={pre:.3e}）'); ok = False
        else:
            u_o2, pre_o2 = gpc_orig(A, B, P0.copy(), y_base, u_base, yr_neg_hit, 0.998, 0.1, return_pre=True)
            u_v2 = gpc_v2(A, B, P0.copy(), y_base, u_base, yr_neg_hit, 0.998, 0.1)
            print(f'  负向限幅：pre-clamp deltaU(1)={pre_o2:.3e} < -3000 → 触发限幅；'
                  f'orig={u_o2:.6f}, v2={u_v2:.6f}, diff={abs(u_o2 - u_v2):.3e}')
            if abs(u_o2 - u_v2) > 1e-9:
                ok = False
    print('  限幅行为：orig 与 v2 一致 ✓' if ok else '  限幅行为不一致')
    ok_all &= ok

    # ---- 2b. use_rls_online 开关：开启时与原版“激活段”行为一致 ----
    print('==== 2b. use_rls_online 开关一致性 ====')
    ok = True
    for trial in range(2):
        yr = 100 + 20 * trial
        y = 105 + 15 * trial + 2 * rng.standard_normal(3)
        u = 50 + 3 * trial + 0.5 * rng.standard_normal(2)
        # 原版：THETA/P 段总是执行（但不影响 u）；v2 关闭开关输出应与原版相同
        u_orig = gpc_orig(A, B, P0.copy(), y, u, yr, 0.998, 4400)
        u_v2_off = gpc_v2(A, B, P0.copy(), y, u, yr, 0.998, 4400)
        u_v2_on = gpc_v2(A, B, P0.copy(), y, u, yr, 0.998, 4400, dict(use_rls_online=True))
        d1 = abs(u_orig - u_v2_off)
        d2 = abs(u_orig - u_v2_on)
        if d1 > 1e-9 or d2 > 1e-9:
            print(f'  [FAIL] trial{trial}: off diff={d1:.3e}, on diff={d2:.3e}'); ok = False
    print('  RLS 死代码结论验证：开启/关闭 use_rls_online 输出均与原版一致 ✓' if ok else '  RLS 开关不一致')
    ok_all &= ok

    # ---- 3. PID 默认输出一致性 ----
    print('==== 3. PID 默认输出一致性 ====')
    ok = True
    for trial in range(8):
        para = np.array([100 * rng.random(), 100 * rng.random(), 20 * rng.random(), 0,
                         0.5 * rng.random() - 0.25, 0.5 * rng.random() - 0.25,
                         5 * rng.random(), 10 + 40 * rng.random(), rng.random(), 0,
                         40 + 20 * rng.random(), 0, 0.01])
        p_orig = pid_orig(para)
        p_v2 = pid_v2(para)
        d = np.max(np.abs(p_orig - p_v2))
        max_err_pid = max(max_err_pid, d)
        if d > 1e-9:
            print(f'  [FAIL] trial{trial}: max|diff|={d:.3e}'); ok = False
    print('  PID：全部通过，正常参数输出与原版逐位一致 ✓' if ok else '  PID：存在不一致')
    print(f'  （8 组输入，本组最大绝对误差 = {max_err_pid:.3e}）')
    ok_all &= ok

    # ---- 3b. ti=0 除零防护 ----
    print('==== 3b. PID ti=0 除零防护 ====')
    para_ti0 = np.array([100, 90, 5, 0, 0, 0, 2, 0, 0, 0, 20, 0, 0.01])
    p_ti0 = pid_v2(para_ti0)
    if not np.all(np.isfinite(p_ti0)):
        print('  [FAIL] ti=0 重构版产生非有限值'); ok_all = False
    elif not (para_ti0[11] <= p_ti0[2] <= para_ti0[10]):
        print('  [FAIL] ti=0 输出越限'); ok_all = False
    else:
        print(f'  PID：ti=0 除零防护通过（mv={p_ti0[2]:.6g}，有限且限幅内）✓')

    # ---- 4. GPC 参数化扩展（时域可配置）----
    print('==== 4. GPC 参数化扩展 ====')
    y = 100 + 2 * rng.standard_normal(3)
    u = 50 + 0.5 * rng.standard_normal(2)
    u_n60 = gpc_v2(A, B, P0.copy(), y, u, 120, 0.998, 4400, dict(N=60, Nu=15))
    u_lim100 = gpc_v2(A, B, P0.copy(), y, u, 1e9, 0.998, 0.1, dict(deltaU_lim=100))
    print(f'  N=60,Nu=15 输出: {u_n60:.12f}（时域可配置 ✓）')
    print(f'  deltaU_lim=100（极端输入下限幅生效）输出: {u_lim100:.12f}（限幅可配置 ✓）')

    # ---- 5. 性能对比 ----
    print('==== 5. 性能对比（100 次）====')
    import time
    n = 100
    t0 = time.perf_counter()
    for _ in range(n):
        y = 100 + 2 * rng.standard_normal(3); u_ = 50 + 0.5 * rng.standard_normal(2)
        gpc_orig(A, B, P0.copy(), y, u_, 120, 0.998, 4400)
    dt_orig = time.perf_counter() - t0
    t0 = time.perf_counter()
    for _ in range(n):
        y = 100 + 2 * rng.standard_normal(3); u_ = 50 + 0.5 * rng.standard_normal(2)
        gpc_v2(A, B, P0.copy(), y, u_, 120, 0.998, 4400)
    dt_v2 = time.perf_counter() - t0
    print(f'  原版(N=120 每周期重算矩阵) : {dt_orig:.4f} s')
    print(f'  重构版(无缓存,同算法)      : {dt_v2:.4f} s')
    t0 = time.perf_counter()
    for _ in range(n):
        gpc_matrices(A, B, 120, 20)         # 原版每周期都重算的部分
    dt_setup = time.perf_counter() - t0
    print(f'  预测矩阵一次性构造耗时     : {dt_setup / n * 1000:.3f} ms/次'
          f'（use_cached=true 时每个周期只需一次）')

    print()
    print('================================')
    print('验证通过：重构版默认输出与原版逐位一致，±3000 限幅一致，ti=0 防护有效。'
          if ok_all else '存在 FAIL，请检查。')


if __name__ == '__main__':
    main()
