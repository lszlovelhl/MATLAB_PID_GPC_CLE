#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
test_verify.py — GY-750#202230421 工程 GPC/PID 重构等价性验证（numpy 移植版）

因本机 MATLAB R2025a 许可过期无法运行 .m，故将【本工程原版】gpc_clac / pid_calc
与【本工程重构版】gpc_clac_v2 / pid_calc_v2 的算法逐行翻译为 numpy，用相同输入
对比输出，断言：
  * 不传 opts 时，重构版默认输出与原版逐位一致（容差 1e-9）；
  * ±3000 饱和限幅行为一致（含触发限幅的极端用例）；
  * 本工程无 RLS 在线辨识段、输出系数=1.0（u=u(2)+deltaU(1)）。

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


# ================= GPC 预测矩阵（原版内联逻辑逐行移植，GPC 原版与 v2 共用） =================

def gpc_matrices(A, B, N, Nu):
    """Diophantine 递推 + G/F/H 组装，与原版 gpc_clac.m 函数体内联段一致。"""
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
        H.append(EB[0:L - j])            # EB(1:length(EB)-j+1)
        G.append(EB[L - j - 1:L])        # EB(length(EB)-j+1:length(EB))

    # 第三步：fliplr 翻转
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


# ================= 本工程原版 gpc_clac.m 逐行移植 =================

def gpc_orig(A, B, P, y, u, yr, a, lmd1):
    """原版逻辑：N=120, Nu=20；无 RLS；u=u(2)+deltaU(1)；deltaU(1) 先 ±3000 限幅。"""
    N, Nu = 120, 20
    # —— 本工程原版 THETA/P 递推辨识段已整段注释，此处不做任何在线辨识 ——
    F_, H_, G_ = gpc_matrices(A, B, N, Nu)

    # 现场索引：olddeltaU=u(2)-u(1)；oldY=[y(3:-1:2)]'
    olddeltaU = u[1] - u[0]
    oldY = np.array([y[2], y[1]]).reshape(-1, 1)
    Y0 = F_ @ oldY + H_ * olddeltaU

    # 参考轨迹：yd(1)=y(length(y))，Yd=yd'
    yd = np.zeros(N)
    yd[0] = y[-1]
    for j in range(1, N):
        yd[j] = a * yd[j - 1] + (1 - a) * yr
    Yd = yd.reshape(-1, 1)

    # 现场 lmd 自适应：ye=abs(yr-y(3))
    ye = abs(yr - y[2])
    lmd = lmd1 / 15 * ye + 2 / 3 * lmd1

    K = np.linalg.solve(G_.T @ G_ + lmd * np.eye(Nu), G_.T)
    deltaU = K @ (Yd - Y0)

    # 现场顺序：先 ±3000 限幅，后 u=u(2)+deltaU(1)（输出系数=1.0）
    du1 = float(deltaU[0, 0])
    if du1 >= 3000:
        du1 = 3000.0
    if du1 <= -3000:
        du1 = -3000.0
    return u[1] + du1


# ================= 重构版 gpc_clac_v2.m 移植 =================

def gpc_v2(A, B, P, y, u, yr, a, lmd1, opts=None):
    """重构版：参数化 N/Nu/control_gain/deltaU_lim；默认与原版逐位一致。"""
    opts = opts or {}
    N = opts.get('N', 120)
    Nu = opts.get('Nu', 20)
    ctrl_g = opts.get('control_gain', 1.0)
    dU_lim = opts.get('deltaU_lim', 3000)
    N = max(int(N), 1)
    Nu = max(int(Nu), 1)
    Nu = min(Nu, N)
    if not (0 < a < 1):
        a = 0.8

    F_, H_, G_ = gpc_matrices(A, B, N, Nu)

    olddeltaU = u[1] - u[0]
    oldY = np.array([y[2], y[1]]).reshape(-1, 1)
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

    # 先限幅（±deltaU_lim），后乘输出系数并叠加
    du1 = float(deltaU[0, 0])
    if du1 >= dU_lim:
        du1 = float(dU_lim)
    if du1 <= -dU_lim:
        du1 = -float(dU_lim)
    return u[1] + ctrl_g * du1


# ================= PID（与宝马原版逐字相同；v2 复用宝马 pid_calc_v2） =================

def pid_orig(para):
    """原版 pid_calc.m 逻辑。para 为 13 元素数组（0-based 对应 MATLAB 1-based）。"""
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
    """重构版 pid_calc_v2：修复 ti<=0 除零，其余与原版逐位一致。"""
    para = np.asarray(para, float)
    if para.size < 13:
        raise ValueError('para 不足 13 元素')
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
    rng = np.random.default_rng(202230421)
    ok_all = True
    max_gpc_diff = 0.0
    max_pid_diff = 0.0

    # 现场模型（na=1 一阶、nb=0 纯比例；A/B 行向量）
    models = [
        (np.array([-0.9769, 1.0]), np.array([0.8642]), '回路1'),
        (np.array([-0.9931, 1.0]), np.array([-0.001244]), '回路2'),
        (np.array([-0.95, 1.0]), np.array([1.2]), '回路3'),
        (np.array([-0.88, 1.0]), np.array([-2.5]), '回路4(负增益)'),
    ]
    P0 = np.array([[0.01, 0.01], [0.01, 0.01]])   # 本工程未使用，仅占位兼容接口

    # ---- 1. GPC 默认输出一致性（多模型 × 多随机输入）----
    print('==== 1. GPC 默认输出一致性（N=120/Nu=20/系数1.0/±3000）====')
    ok = True
    ngpc = 0
    for A, B, tag in models:
        for trial in range(5):
            yr = 100 + 20 * trial
            y = 105 + 15 * trial + 2 * rng.standard_normal(3)
            u = 5 + 1.5 * trial + 0.3 * rng.standard_normal(2)
            u_orig = gpc_orig(A, B, P0.copy(), y, u, yr, 0.998, 4400)
            u_v2 = gpc_v2(A, B, P0.copy(), y, u, yr, 0.998, 4400)
            d = abs(u_orig - u_v2)
            max_gpc_diff = max(max_gpc_diff, d)
            ngpc += 1
            if d > 1e-9:
                print(f'  [FAIL] {tag} trial{trial}: orig={u_orig:.12f} v2={u_v2:.12f} diff={d:.3e}')
                ok = False
    print(f'  GPC：{ngpc} 组全部一致，最大误差={max_gpc_diff:.3e}（<1e-9）✓' if ok else '  GPC：存在不一致')
    ok_all &= ok

    # ---- 1b. GPC 限幅触发用例：构造 raw deltaU(1) 真实超出 ±3000 的输入 ----
    # 说明：现场自适应 lmd=lmd1/15*ye+2/3*lmd1 会随偏差阻尼，正常工况 deltaU
    # 远小于 3000。此处取一个自由响应发散较快的模型(A=[-1.5,1])，令 y(2) 大幅
    # 偏移而 ye=|yr-y(3)|=0（lmd 不阻尼），使 raw deltaU 真正越过 ±3000，
    # 从而走到原版“先限幅、后叠加”的分支。
    print('==== 1b. GPC ±3000 限幅触发一致性 ====')
    ok = True
    A_un = np.array([-1.5, 1.0])
    B_un = np.array([0.8642])
    for y1, tag in [(-4000.0, '正向爆量 raw>3000'), (4000.0, '负向爆量 raw<-3000')]:
        y = np.array([100.0, y1, 100.0])      # y(3)=100=yr -> ye=0, lmd 不阻尼
        u = np.array([5.0, 5.0])
        u_orig = gpc_orig(A_un, B_un, P0.copy(), y, u, 100.0, 0.998, 1.0)
        u_v2 = gpc_v2(A_un, B_un, P0.copy(), y, u, 100.0, 0.998, 1.0)
        d = abs(u_orig - u_v2)
        max_gpc_diff = max(max_gpc_diff, d)
        # 限幅后输出应正好 = u(2) ± 3000（符号与爆量方向一致）
        expect = u[1] + (3000.0 if y1 < 0 else -3000.0)
        clip_ok = abs(u_orig - expect) < 1e-9
        if d > 1e-9 or not clip_ok:
            print(f'  [FAIL] {tag}: orig={u_orig:.6f} v2={u_v2:.6f} expect={expect:.6f} diff={d:.3e}')
            ok = False
        else:
            print(f'  {tag}: orig=v2={u_orig:.6f}，已限幅至 u(2)±3000 ✓')
    ok_all &= ok

    # ---- 2. PID 默认输出一致性 ----
    print('==== 2. PID 默认输出一致性 ====')
    ok = True
    npid = 0
    for trial in range(10):
        para = np.array([100 * rng.random(), 100 * rng.random(), 20 * rng.random(), 0,
                         0.5 * rng.random() - 0.25, 0.5 * rng.random() - 0.25,
                         5 * rng.random(), 10 + 40 * rng.random(), rng.random(), 0,
                         40 + 20 * rng.random(), 0, 0.01])
        p_orig = pid_orig(para)
        p_v2 = pid_v2(para)
        d = float(np.max(np.abs(p_orig - p_v2)))
        max_pid_diff = max(max_pid_diff, d)
        npid += 1
        if d > 1e-9:
            print(f'  [FAIL] trial{trial}: max|diff|={d:.3e}')
            ok = False
    print(f'  PID：{npid} 组全部一致，最大误差={max_pid_diff:.3e}（<1e-9）✓' if ok else '  PID：存在不一致')
    ok_all &= ok

    # ---- 2b. PID ti=0 除零防护 ----
    para_ti0 = np.array([100, 90, 5, 0, 0, 0, 2, 0, 0, 0, 20, 0, 0.01])
    p_ti0 = pid_v2(para_ti0)
    if not np.all(np.isfinite(p_ti0)):
        print('  [FAIL] ti=0 重构版产生非有限值'); ok_all = False
    elif not (para_ti0[11] <= p_ti0[2] <= para_ti0[10]):
        print('  [FAIL] ti=0 输出越限'); ok_all = False
    else:
        print(f'  PID：ti=0 除零防护通过（mv={p_ti0[2]:.6g}，有限且限幅内）✓')

    # ---- 3. GPC 参数化扩展（默认不变，仅验证可配置）----
    print('==== 3. GPC 参数化扩展 ====')
    y = np.array([101.0, 102.0, 100.0])
    u = np.array([5.0, 5.2])
    u_n60 = gpc_v2(A, B, P0.copy(), y, u, 130, 0.998, 4400, dict(N=60, Nu=15))
    u_g05 = gpc_v2(A, B, P0.copy(), y, u, 130, 0.998, 4400, dict(control_gain=0.5))
    print(f'  N=60,Nu=15 输出: {u_n60:.12f}（时域可配置 ✓）')
    print(f'  control_gain=0.5 输出: {u_g05:.12f}（输出系数可配置；默认=1.0 已证一致 ✓）')

    # ---- 4. 性能对比 ----
    print('==== 4. 性能对比（200 次）====')
    import time
    n = 200
    t0 = time.perf_counter()
    for _ in range(n):
        y = 101 + 2 * rng.standard_normal(3); u_ = 5 + 0.3 * rng.standard_normal(2)
        gpc_orig(A, B, P0.copy(), y, u_, 130, 0.998, 4400)
    dt_orig = time.perf_counter() - t0
    t0 = time.perf_counter()
    for _ in range(n):
        y = 101 + 2 * rng.standard_normal(3); u_ = 5 + 0.3 * rng.standard_normal(2)
        gpc_v2(A, B, P0.copy(), y, u_, 130, 0.998, 4400)
    dt_v2 = time.perf_counter() - t0
    print(f'  原版(N=120 每周期重算矩阵): {dt_orig:.4f} s')
    print(f'  重构版(无缓存)            : {dt_v2:.4f} s')
    t0 = time.perf_counter()
    gpc_matrices(A, B, 120, 20)
    dt_setup = time.perf_counter() - t0
    print(f'  预测矩阵一次性构造耗时     : {dt_setup:.6f} s（use_cached=true 时每个周期省去这部分）')

    print()
    print('================================')
    if ok_all:
        print(f'全部 PASS：重构版默认输出与原版逐位一致（GPC 最大误差={max_gpc_diff:.3e}，'
              f'PID 最大误差={max_pid_diff:.3e}，均<1e-9），限幅与 ti=0 防护有效。')
    else:
        print('存在 FAIL，请检查。')
    return 0 if ok_all else 1


if __name__ == '__main__':
    raise SystemExit(main())
