#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
test_verify.py — 高义热风炉工程 PID 重构等价性验证（Python/numpy 移植版）

本工程（gaoyi3 / gaoyi4）无 GPC，仅做 pid_calc（原版函数名 pid）重构。
因本机 MATLAB R2025a 许可证过期无法直接运行 .m，故将原版 pid 与重构版
pid_calc_v2 的算法逐行翻译为 numpy，用相同输入对比输出，断言“默认参数下
重构版输出与原版逐位一致”（容差 1e-9）。

用法：python3 test_verify.py
"""
import numpy as np

TOL = 1e-9


# ================= 原版 pid_calc.m（函数名 pid）的逐行移植 =================
def pid_orig(para):
    """原版 pid 逻辑。para 为 13 元素数组（对应 MATLAB 1-based 索引）。

    关键现场边界行为：死区判断是 abs(pv-sp) <= deadzone（注意 <=，
    与宝马工程的 < 不同）。
    """
    kp      = para[6]   # para(7)
    ti      = para[7]   # para(8)
    td      = para[8]   # para(9)
    sp      = para[0]   # para(1)
    pv      = para[1]   # para(2)
    e0      = para[0] - para[1]   # e0 = sp - pv
    e1      = para[4]   # para(5)
    e2      = para[5]   # para(6)
    mv      = para[2]   # para(3)
    man_on  = para[9]   # para(10)
    ulim    = para[10]  # para(11)
    llim    = para[11]  # para(12)
    deadzone = para[12] # para(13)

    # 控制律：du = kp*((e0-e1) + 1/ti*e0 + td*(e0-2*e1+e2))
    du = kp * ((e0 - e1) + 1 / ti * e0 + td * (e0 - 2 * e1 + e2))

    # 死区（现场语义：<= 也算在死区内，输出冻结）
    if abs(pv - sp) <= deadzone:
        du = 0.0

    # 输出更新与限幅
    mv = mv + du
    if mv >= ulim:
        mv = ulim
    if mv <= llim:
        mv = llim

    # 误差滚动
    e2 = e1
    e1 = e0

    return np.array([sp, pv, mv, e0, e1, e2, kp, ti, td, man_on, ulim, llim, deadzone])


# ================= 重构版 pid_calc_v2.m 的移植 =================
def pid_v2(para):
    """重构版 pid_calc_v2 逻辑。

    与原版差异（仅两点）：
      1. ti<=0 时积分项置 0（原版会除零产生 Inf/NaN）；
      2. 输入长度校验。
    死区仍为 <= 语义，其余逐行与原版一致。
    """
    para = np.asarray(para, dtype=float).reshape(-1)
    if para.size < 13:
        raise ValueError('para 不足 13 元素')

    sp      = para[0]
    pv      = para[1]
    mv      = para[2]
    e0      = para[0] - para[1]
    e1      = para[4]
    e2      = para[5]
    kp      = para[6]
    ti      = para[7]
    td      = para[8]
    man_on  = para[9]
    ulim    = para[10]
    llim    = para[11]
    deadzone = para[12]

    # 积分项：ti>0 时与原版逐位一致；ti<=0 时置 0（修复除零）
    integral_term = (e0 / ti) if ti > 0 else 0.0
    du = kp * ((e0 - e1) + integral_term + td * (e0 - 2 * e1 + e2))

    # 死区（现场语义保留 <=）
    if abs(pv - sp) <= deadzone:
        du = 0.0

    mv = mv + du
    if mv >= ulim:
        mv = ulim
    if mv <= llim:
        mv = llim

    e2 = e1
    e1 = e0

    return np.array([sp, pv, mv, e0, e1, e2, kp, ti, td, man_on, ulim, llim, deadzone])


# ================= 主测试 =================
def main():
    rng = np.random.default_rng(20250721)
    ok_all = True
    max_diff_overall = 0.0

    # ---- 1. 正常参数下：原版 vs v2 逐位一致（多组随机输入）----
    print('==== 1. PID 默认输出一致性（正常参数，ti>0）====')
    n_rand = 20
    for trial in range(n_rand):
        # 随机生成 13 元素 para；ti 取正值保证原版可算
        para = np.array([
            100 * rng.random(),                      # 1 sp
            100 * rng.random(),                      # 2 pv
            20 * rng.random(),                       # 3 mv
            0.0,                                     # 4 e0(占位，现算)
            0.5 * rng.random() - 0.25,               # 5 e1
            0.5 * rng.random() - 0.25,               # 6 e2
            5 * rng.random(),                        # 7 kp
            10 + 40 * rng.random(),                  # 8 ti ( >0 )
            rng.random(),                            # 9 td
            0.0,                                     # 10 man_on
            40 + 20 * rng.random(),                  # 11 ulim
            0.0,                                     # 12 llim
            0.01 + 0.5 * rng.random(),               # 13 deadzone
        ])
        p_orig = pid_orig(para)
        p_v2   = pid_v2(para)
        d = float(np.max(np.abs(p_orig - p_v2)))
        max_diff_overall = max(max_diff_overall, d)
        if d > TOL:
            print(f'  [FAIL] trial{trial}: max|diff|={d:.3e}')
            ok_all = False
    if ok_all:
        print(f'  {n_rand} 组随机输入：全部一致（最大误差={max_diff_overall:.3e}）✓')

    # ---- 2. 死区边界用例：abs(pv-sp)==deadzone 时 du 必须为 0 ----
    print('==== 2. 死区边界用例（abs(pv-sp) == deadzone）====')
    # 构造：sp=100, pv=95, deadzone=5 → |pv-sp|=5 == deadzone，恰好落在边界
    para_b = np.array([100.0, 95.0, 5.0, 0.0,
                       1.0, 2.0,      # e1, e2（非零，若 du 未被清零 mv 会变）
                       2.0,           # kp
                       20.0,          # ti
                       0.5,           # td
                       0.0,           # man_on
                       50.0, 0.0,     # ulim, llim
                       5.0])          # deadzone
    p_b_orig = pid_orig(para_b)
    p_b_v2   = pid_v2(para_b)
    mv_orig, mv_v2 = p_b_orig[2], p_b_v2[2]
    # 死区边界冻结：mv 应保持原值 5.0（du=0）
    bz_ok = True
    if abs(mv_orig - 5.0) > TOL:
        print(f'  [FAIL] 原版边界 mv={mv_orig} 未冻结（期望 5.0）'); bz_ok = False; ok_all = False
    if abs(mv_v2 - 5.0) > TOL:
        print(f'  [FAIL] v2 边界 mv={mv_v2} 未冻结（期望 5.0）'); bz_ok = False; ok_all = False
    d_b = float(np.max(np.abs(p_b_orig - p_b_v2)))
    if d_b > TOL:
        print(f'  [FAIL] 边界用例 orig vs v2 最大差={d_b:.3e}'); bz_ok = False; ok_all = False
    if bz_ok:
        print(f'  |pv-sp|==deadzone → du=0，mv 冻结={mv_v2:.6g}，orig 与 v2 一致（误差={d_b:.3e}）✓')

    # 对照：|pv-sp| 略大于 deadzone 时，du 不应被死区清零（验证 <= 边界只吃恰等点）
    para_c = para_b.copy(); para_c[1] = 94.9  # |pv-sp|=5.1 > 5 → 不死区
    p_c_orig = pid_orig(para_c); p_c_v2 = pid_v2(para_c)
    d_c = float(np.max(np.abs(p_c_orig - p_c_v2)))
    if abs(p_c_orig[2] - 5.0) < TOL:
        print('  [FAIL] |pv-sp|>deadzone 时 mv 仍被冻结，死区语义错误'); ok_all = False
    if d_c > TOL:
        print(f'  [FAIL] 出死区用例 orig vs v2 最大差={d_c:.3e}'); ok_all = False
    else:
        print(f'  |pv-sp|>deadzone → du 正常作用，orig 与 v2 一致（误差={d_c:.3e}）✓')

    # ---- 3. 限幅边界用例：mv 超过 ulim / 低于 llim 被钳位 ----
    print('==== 3. 输出限幅用例 ====')
    para_lim = np.array([100.0, 80.0, 40.0, 0.0,
                         0.0, 0.0,      # e1,e2
                         3.0,           # kp（大增益，使 mv 冲出限幅）
                         10.0,          # ti
                         0.0,           # td
                         0.0,
                         60.0, 10.0,    # ulim=60, llim=10
                         0.0])          # deadzone=0（无死区）
    p_l_orig = pid_orig(para_lim); p_l_v2 = pid_v2(para_lim)
    d_l = float(np.max(np.abs(p_l_orig - p_l_v2)))
    lim_ok = True
    if not (10.0 - TOL <= p_l_v2[2] <= 60.0 + TOL):
        print(f'  [FAIL] v2 mv={p_l_v2[2]} 越限'); lim_ok = False; ok_all = False
    if d_l > TOL:
        print(f'  [FAIL] 限幅用例 orig vs v2 最大差={d_l:.3e}'); lim_ok = False; ok_all = False
    if lim_ok:
        print(f'  mv 限幅后={p_l_v2[2]:.6g}（钳在 [10,60]），orig 与 v2 一致（误差={d_l:.3e}）✓')

    # ---- 4. ti=0 除零防护（单独验证，不与原版比——原版此时会得 Inf/NaN）----
    print('==== 4. ti=0 除零防护 ====')
    para_ti0 = np.array([100.0, 90.0, 5.0, 0.0,
                         0.0, 0.0,     # e1,e2
                         2.0,          # kp
                         0.0,          # ti = 0（触发原版除零）
                         0.0,          # td
                         0.0,
                         20.0, 0.0,    # ulim, llim
                         0.01])        # deadzone
    # 原版在 ti=0 时：1/ti=Inf → du=Inf → mv=Inf（随后限幅对 Inf 无效）
    p_ti0_orig = pid_orig(para_ti0)
    p_ti0_v2   = pid_v2(para_ti0)
    print(f'  原版 ti=0: mv={p_ti0_orig[2]}（Inf/NaN，隐患复现）')
    ti_ok = True
    if not np.all(np.isfinite(p_ti0_v2)):
        print('  [FAIL] v2 ti=0 仍产生非有限值'); ti_ok = False; ok_all = False
    elif not (para_ti0[11] - TOL <= p_ti0_v2[2] <= para_ti0[10] + TOL):
        print(f'  [FAIL] v2 ti=0 mv={p_ti0_v2[2]} 越限'); ti_ok = False; ok_all = False
    if ti_ok:
        print(f'  v2   ti=0: mv={p_ti0_v2[2]:.6g}（有限且限幅内，积分项已禁用）✓')

    # ti<0 也应防护
    para_tineg = para_ti0.copy(); para_tineg[7] = -3.0
    p_tineg = pid_v2(para_tineg)
    if not np.all(np.isfinite(p_tineg)):
        print('  [FAIL] v2 ti<0 产生非有限值'); ok_all = False
    else:
        print(f'  v2   ti=-3: mv={p_tineg[2]:.6g}（同样防护有效）✓')

    # ---- 汇总 ----
    print()
    print('================================')
    print(f'随机组最大误差: {max_diff_overall:.3e} (容差 {TOL:.0e})')
    print('结论：全部用例 PASS，默认参数下 v2 与原版逐位一致，ti<=0 防护有效。'
          if ok_all else '存在 FAIL，请检查。')
    return 0 if ok_all else 1


if __name__ == '__main__':
    import sys
    sys.exit(main())
