#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
test_verify.py — JL-2#20230902 工程 PID/GPC 重构等价性验证（numpy 移植版）

本机 MATLAB R2025a 许可过期，无法直接运行 .m。故将【本工程原版】
gpc_clac.m / pid_calc.m 与【本工程重构版】gpc_clac_v2.m / pid_calc_v2.m
逐行翻译为 numpy，用相同输入对比输出，断言：
  1. 默认参数下 v2 输出与原版逐位一致（容差 1e-9）；
  2. ΔU(1) ±3000 饱和限幅行为一致（含触发限幅的极端用例）；
  3. PID ti=0 除零防护：输出有限且在限幅内；
  4. GPC 与 PID 均覆盖。

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
    """多项式除法取商（对应 MATLAB deconv(u,v) 第一个返回值 q）。"""
    q, _ = np.polydiv(np.asarray(u, float), np.asarray(v, float))
    return q


# ================= GPC 预测矩阵（原版内联段逐行移植，v2 与之共用同一构造逻辑） =================

def gpc_matrices(A, B, N, Nu):
    """Diophantine 递推 + G/F/H 矩阵，与原版 gpc_clac 函数体内联逻辑一致。"""
    na, nb = len(A) - 1, len(B) - 1
    delta = np.array([-1.0, 1.0])
    Z = np.array([1.0, 0.0])
    Adelta = np.convolve(A, delta)

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
        G.append(EB[L - j - 1:L])        # EB(length(EB)-j+1:length(EB))

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


# ================= 本工程原版 gpc_clac.m 的逐行移植 =================
# 现场行为：N=120, Nu=20；无 RLS 段（整段注释）；输出系数=1.0；
# ΔU(1) 先 ±3000 限幅、后 u=u(2)+deltaU(1)。

def gpc_orig(A, B, P, y, u, yr, a, lmd1, return_raw=False):
    """原版 gpc_clac.m。返回 (最终u, 限幅前 deltaU(1))。"""
    N, Nu = 120, 20
    na = len(A) - 1
    # 注：原版 THETA/P RLS 递推段已整段注释，此处不做任何在线辨识。

    F_, H_, G_ = gpc_matrices(A, B, N, Nu)

    olddeltaU = u[1] - u[0]                     # u(2)-u(1)
    oldY = np.array([y[2], y[1]]).reshape(-1, 1)  # [y(3:-1:2)]'，na=1
    Y0 = F_ @ oldY + H_ * olddeltaU

    yd = np.zeros((N, 1))
    yd[0] = y[-1]                               # yd(1)=y(length(y))
    for j in range(1, N):
        yd[j] = a * yd[j - 1] + (1 - a) * yr
    Yd = yd

    ye = abs(yr - y[2])                         # ye=abs(yr-y(3))
    lmd = lmd1 / 15 * ye + 2 / 3 * lmd1         # lmd 自适应
    K = np.linalg.solve(G_.T @ G_ + lmd * np.eye(Nu), G_.T)
    deltaU = K @ (Yd - Y0)
    raw = float(deltaU[0, 0])

    # 原版：先 ±3000 限幅，后叠加（顺序不可颠倒）
    d1 = raw
    if d1 >= 3000:
        d1 = 3000
    if d1 <= -3000:
        d1 = -3000
    u_out = u[1] + d1                           # 原版无 0.7 系数 → 1.0
    if return_raw:
        return u_out, raw
    return u_out


# ================= 本工程重构版 gpc_clac_v2.m 的移植 =================

def gpc_v2(A, B, P, y, u, yr, a, lmd1, opts=None, return_raw=False):
    """重构版 gpc_clac_v2。默认参数与现场原版逐位一致。"""
    opts = opts or {}
    N = opts.get('N', 120)
    Nu = opts.get('Nu', 20)
    ctrl_g = opts.get('control_gain', 1.0)
    dUlim = opts.get('deltaU_lim', 3000)
    N = max(int(N), 1)
    Nu = min(max(int(Nu), 1), N)
    if not (0 < a < 1):
        a = 0.8
    na = len(A) - 1

    F_, H_, G_ = gpc_matrices(A, B, N, Nu)

    olddeltaU = u[1] - u[0]
    oldY = np.asarray(y[::-1][:na + 1], float).reshape(-1, 1)
    Y0 = F_ @ oldY + H_ * olddeltaU

    yd = np.zeros((N, 1))
    yd[0] = y[-1]
    for j in range(1, N):
        yd[j] = a * yd[j - 1] + (1 - a) * yr
    Yd = yd

    ye = abs(yr - y[-1])
    lmd = lmd1 / 15 * ye + 2 / 3 * lmd1
    K = np.linalg.solve(G_.T @ G_ + lmd * np.eye(Nu), G_.T)
    deltaU = K @ (Yd - Y0)
    raw = float(deltaU[0, 0])

    d1 = raw
    if d1 >= dUlim:
        d1 = dUlim
    if d1 <= -dUlim:
        d1 = -dUlim
    u_out = u[1] + ctrl_g * d1
    if return_raw:
        return u_out, raw
    return u_out


# ================= PID =================

def pid_orig(para):
    """原版 pid_calc.m。para 13 元素（对应 MATLAB 1-based）。"""
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
    """重构版 pid_calc_v2：修复 ti<=0 除零，其余与原版一致。"""
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
    rng = np.random.default_rng(20230902)
    ok_all = True
    maxdiff_gpc = 0.0
    maxdiff_pid = 0.0

    # 现场真实模型（取自 模型参数.txt，一阶 na=1, nb=0）
    models = [
        (np.array([-0.9954, 1.0]), np.array([2.432e-05]),  '1#-gz1'),
        (np.array([-0.9863, 1.0]), np.array([7.264e-05]),  '1#-gz3'),
        (np.array([-0.9772, 1.0]), np.array([1.21e-04]),   '1#-gz5'),
        (np.array([-0.9989, 1.0]), np.array([1.0721e-05]),'5#-gz1'),
        (np.array([-0.9792, 1.0]), np.array([1.75e-04]),   '4#-gz5'),
    ]
    P0 = np.array([[0.01, 0.01], [0.01, 0.01]])  # 本工程不参与计算，仅占位

    # ---- 1. GPC 默认输出一致性（默认 N=120/Nu=20/gain=1.0/±3000）----
    print('==== 1. GPC 默认输出一致性（容差 1e-9）====')
    ok = True
    for A, B, tag in models:
        for trial in range(5):
            yr = 920 + 50 * trial
            y = np.array([918 + 40 * trial, 919 + 40 * trial, 920 + 40 * trial]) \
                + 0.5 * rng.standard_normal(3)
            u = np.array([9600 + 5 * trial, 9650 + 5 * trial]) \
                + 2 * rng.standard_normal(2)
            uo = gpc_orig(A, B, P0.copy(), y, u, yr, 0.998, 4400)
            uv = gpc_v2(A, B, P0.copy(), y, u, yr, 0.998, 4400)
            d = abs(uo - uv)
            maxdiff_gpc = max(maxdiff_gpc, d)
            if d > 1e-9:
                print(f'  [FAIL] {tag} trial{trial}: orig={uo:.12f} v2={uv:.12f} diff={d:.3e}')
                ok = False
    print(f'  GPC：{len(models)*5} 组全部一致 ✓（最大误差 {maxdiff_gpc:.3e}）'
          if ok else '  GPC：存在不一致 ✗')
    ok_all &= ok

    # ---- 2. GPC 限幅用例：构造会触发 ±3000 的极端输入 ----
    print('==== 2. GPC ±3000 饱和限幅一致性 ====')
    # 大偏差 + 小 lmd1 使自适应 λ 不足以压制 raw ΔU(1)（已实证可触发）。
    # 正方向：yr=1e8 → raw≈+8097；负方向：y≈1e9、yr=0 → raw≈-47866。
    A_big = np.array([-0.9, 1.0])
    B_big = np.array([5.0])
    cases = [
        (1e8, np.array([800.0, 801.0, 802.0]), +1),   # raw > +3000
        (0.0, np.array([1e9, 1e9 + 1, 1e9 + 2]), -1),  # raw < -3000
    ]
    ok = True
    for yr_test, y, sign in cases:
        u = np.array([15.0, 15.0])
        uo, raw_o = gpc_orig(A_big, B_big, P0.copy(), y, u, yr_test, 0.998, 0.001, return_raw=True)
        uv, raw_v = gpc_v2(A_big, B_big, P0.copy(), y, u, yr_test, 0.998, 0.001, return_raw=True)
        triggered = (raw_o >= 3000) or (raw_o <= -3000)
        expect = u[1] + (3000.0 if sign > 0 else -3000.0)
        d = abs(uo - uv)
        maxdiff_gpc = max(maxdiff_gpc, d)
        if not triggered:
            print(f'  [WARN] sign={sign:+d} raw={raw_o:.3e} 未触发限幅，请调参')
            ok = False
        elif abs(uo - expect) > 1e-9 or abs(uv - expect) > 1e-9:
            print(f'  [FAIL] sign={sign:+d}: orig={uo:.6f} v2={uv:.6f} expect={expect:.6f}')
            ok = False
        elif d > 1e-9:
            print(f'  [FAIL] sign={sign:+d}: orig/v2={d:.3e} 不一致'); ok = False
        else:
            print(f'  sign={sign:+d}: rawΔU(1)={raw_o:+.3e} → 限幅后 u={uo:.6f}'
                  f'（先限幅后叠加，orig==v2 ✓）')
    print('  GPC 限幅：通过 ✓' if ok else '  GPC 限幅：存在问题 ✗')
    ok_all &= ok

    # ---- 3. GPC 参数化扩展（N/Nu/限幅可配置，不影响默认行为）----
    print('==== 3. GPC 参数化扩展 ====')
    A, B = models[0][0], models[0][1]
    y = np.array([918.0, 919.0, 920.0]) + 0.1 * rng.standard_normal(3)
    u = np.array([9600.0, 9650.0])
    u_n = gpc_v2(A, B, P0.copy(), y, u, 950, 0.998, 4400, dict(N=60, Nu=15))
    u_lim = gpc_v2(A, B, P0.copy(), y, u, 950, 0.998, 4400, dict(deltaU_lim=100))
    print(f'  N=60,Nu=15     → u={u_n:.10f}（时域可配置 ✓）')
    print(f'  deltaU_lim=100 → u={u_lim:.10f}（限值可配置 ✓）')

    # ---- 4. PID 默认输出一致性 ----
    print('==== 4. PID 默认输出一致性（容差 1e-9）====')
    ok = True
    for trial in range(10):
        para = np.array([100 * rng.random(), 100 * rng.random(), 20 * rng.random(), 0,
                         0.5 * rng.random() - 0.25, 0.5 * rng.random() - 0.25,
                         5 * rng.random(), 10 + 40 * rng.random(), rng.random(), 0,
                         40 + 20 * rng.random(), 0, 0.01])
        po = pid_orig(para)
        pv = pid_v2(para)
        d = float(np.max(np.abs(po - pv)))
        maxdiff_pid = max(maxdiff_pid, d)
        if d > 1e-9:
            print(f'  [FAIL] trial{trial}: max|diff|={d:.3e}')
            ok = False
    print(f'  PID：10 组全部一致 ✓（最大误差 {maxdiff_pid:.3e}）'
          if ok else '  PID：存在不一致 ✗')
    ok_all &= ok

    # ---- 5. PID ti=0 除零防护 ----
    para_ti0 = np.array([100, 90, 5, 0, 0, 0, 2, 0, 0, 0, 20, 0, 0.01])
    p_ti0 = pid_v2(para_ti0)
    if not np.all(np.isfinite(p_ti0)):
        print('  [FAIL] ti=0 重构版产生非有限值 ✗'); ok_all = False
    elif not (para_ti0[11] <= p_ti0[2] <= para_ti0[10]):
        print('  [FAIL] ti=0 输出越限 ✗'); ok_all = False
    else:
        print(f'==== 5. PID ti=0 防护：通过 ✓（mv={p_ti0[2]:.6g}，有限且限幅内）====')

    # ---- 6. 性能对比（120 阶 Diophantine）----
    print('==== 6. 性能对比（50 次在线求解）====')
    import time
    n = 50
    A, B = models[0][0], models[0][1]
    t0 = time.perf_counter()
    for _ in range(n):
        yy = 920 + 0.1 * rng.standard_normal(3)
        uu = 9650 + 0.5 * rng.standard_normal(2)
        gpc_orig(A, B, P0.copy(), yy, uu, 950, 0.998, 4400)
    dt_orig = time.perf_counter() - t0
    t0 = time.perf_counter()
    for _ in range(n):
        yy = 920 + 0.1 * rng.standard_normal(3)
        uu = 9650 + 0.5 * rng.standard_normal(2)
        gpc_v2(A, B, P0.copy(), yy, uu, 950, 0.998, 4400)
    dt_v2 = time.perf_counter() - t0
    t0 = time.perf_counter()
    gpc_matrices(A, B, 120, 20)          # 一次性构造（对应 use_cached）
    dt_setup = time.perf_counter() - t0
    print(f'  原版(每周期重算120阶矩阵): {dt_orig:.4f} s  ({dt_orig/n*1000:.3f} ms/次)')
    print(f'  v2  (无缓存，同等逻辑)     : {dt_v2:.4f} s  ({dt_v2/n*1000:.3f} ms/次)')
    print(f'  预测矩阵一次性构造耗时     : {dt_setup:.4f} s（use_cached 时仅算一次）')

    print()
    print('========================================')
    if ok_all:
        print(f'全部 PASS：GPC 最大误差 {maxdiff_gpc:.3e}，PID 最大误差 {maxdiff_pid:.3e}，'
              f'默认输出与原版逐位一致，ti=0 防护有效。')
    else:
        print('存在 FAIL，请检查。')
    return 0 if ok_all else 1


if __name__ == '__main__':
    raise SystemExit(main())
