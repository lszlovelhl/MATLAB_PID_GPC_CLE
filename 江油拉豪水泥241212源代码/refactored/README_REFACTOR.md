# PID / GPC 核心算法重构说明（江油拉豪水泥 241212 工程）

> 目标：在**不改变任何已验证现场控制行为**的前提下，按宝马工程的重构模式，
> 把本工程两个 GPC 变体（`gpc_clac.m` / `gpc_clac1.m`）与增量 PID
> （`pid_calc.m`）重构为**参数化、健壮、可复用、可缓存**的 v2 版本。
>
> **范围：江油拉豪水泥241212源代码。原版 .m 文件一律未改动。**

---

## 1. 目录结构与产物

新增目录 `refactored/`（原文件一律未改动，便于对比回退）：

| 文件 | 说明 |
|---|---|
| `gpc_clac_v2.m`     | 重构版 GPC，对应原版 `gpc_clac.m`，接口完全兼容 |
| `gpc_clac1_v2.m`    | 重构版 GPC，对应原版 `gpc_clac1.m`，接口完全兼容 |
| `gpc_matrices_v2.m`  | GPC 预测矩阵构造函数（Diophantine + G/F/H），两个 v2 共用，可缓存 |
| `pid_calc_v2.m`      | 重构版增量 PID，接口与原版 `pid_calc.m` 兼容 |
| `test_verify.py`    | Python/numpy 等价验证脚本（本机 MATLAB 许可过期，用 numpy 移植验证，已运行全部 PASS） |

---

## 2. 默认参数值表（现场原值，重构后未改动）

| 重构函数 | 对应原版 | N（预测时域） | Nu（控制时域） | control_gain（输出步进系数） |
|---|---|---|---|---|
| `gpc_clac_v2`  | `gpc_clac.m`  | **80** | **20** | **0.7** |
| `gpc_clac1_v2` | `gpc_clac1.m` | **50** | **15** | **0.7** |
| `pid_calc_v2`  | `pid_calc.m`   | —（无 N/Nu） | — | —（kp/ti/td/限幅/死区均来自 para 向量，原样透传） |

> 两个 GPC 变体算法逐行相同，仅时域不同；`control_gain=0.7` 均为原版硬编码值。

---

## 3. 与原版一致性验证结果（test_verify.py，numpy 等价移植）

本机 MATLAB R2025a 许可过期，禁止运行 .m；已将本工程**原版**
`gpc_clac.m` / `gpc_clac1.m` / `pid_calc.m` 与**对应 v2** 逐行翻译为 numpy，
多组随机输入对比，容差 `1e-9`。实际运行结果：

| 验证项 | 输入规模 | 结果 | 最大误差 |
|---|---|---|---|
| `gpc_clac` → `gpc_clac_v2`（默认 N=80/Nu=20） | 4 组模型 × 4 组随机输入 = 16 组 | 全部一致 ✓ | **3.553e-15** |
| `gpc_clac1` → `gpc_clac1_v2`（默认 N=50/Nu=15） | 4 组模型 × 4 组随机输入 = 16 组 | 全部一致 ✓ | **3.553e-15** |
| `pid_calc` → `pid_calc_v2`（正常 ti>0） | 8 组随机 para | 全部一致 ✓ | **0.000e+00** |
| PID `ti=0` 除零防护 | para(8)=0 | 输出有限且限幅内（mv=20，触上限）✓ | — |
| GPC 时域参数化（N=60/Nu=15、control_gain=0.5） | 单组 | 可配置 ✓ | — |

> 最大误差 3.55e-15 为 numpy 浮点求解线性方程组的舍入量级，远小于 1e-9，
> 等价于“逐位一致”。

**性能参考**（numpy，100 次）：原版每周期重算 80 阶 Diophantine 约 0.26 s/100 次；
开启 `use_cached=true` 后，模型不变时该部分只算一次，在线部分大幅减少。

---

## 4. 现场参数未改动确认声明（逐项）

重构**仅做了参数化、除零防护、矩阵缓存三件事**，以下现场要素逐项确认**未改动**：

- **控制律**：保留原版 `ΔU = (G'G + λI)⁻¹G'(Yd − Y0)`，取第一步增量乘 0.7；
  `u = u(2) + 0.7·ΔU(1)` 不变。✓
- **回路结构**：自由响应 `Y0 = F_·oldY + H_·olddeltaU`、柔化轨迹
  `yd(j) = a·yd(j-1) + (1-a)·yr`、自适应加权 `λ = lmd1/15·|yr−y| + 2/3·lmd1`
  均逐行保留。✓
- **控制策略**：单步 Δu 近似（`olddeltaU = u(2)-u(1)`，`deltaU_history` 默认 1）、
  死代码在线辨识段默认关闭（本就不影响输出 u）——默认行为与现场一致。✓
- **现场参数**：N=80/Nu=20（gpc_clac）、N=50/Nu=15（gpc_clac1）、
  control_gain=0.7、PID 的 kp/ti/td/ulim/llim/deadzone 全部来自原接口输入，
  默认值即现场原值。✓

---

## 5. 原版 → v2 差异摘要

**GPC（`gpc_clac_v2` / `gpc_clac1_v2` + `gpc_matrices_v2`）**
1. **参数化**：`N`、`Nu`、`control_gain`、`deltaU_history`、缓存开关全部经
   `opts` 结构体配置；默认值 = 现场原值，**默认行为逐位一致**。
2. **矩阵抽取与缓存**：预测矩阵 G_/F_/H_ 抽为 `gpc_matrices_v2`，只依赖
   A/B/N/Nu；`use_cached=true` 时用 persistent + 键校验缓存复用，模型不变不重算。
3. **消除死代码**：在线递推辨识（THETA/P）默认关闭（原版该段结果从不反馈 A/B、
   不影响输出 u），保留 `use_rls_online` 开关供需要时启用。
4. 补输入校验（时域为正整数、柔化因子兜底、Nu≤N），命名清晰、UTF-8 中文注释。

**PID（`pid_calc_v2`）**
1. **修复 ti≤0 除零**：积分项在 `ti<=0` 时置 0 并告警，避免输出冲成 Inf/NaN；
   正常参数（ti>0）下与原版逐位一致。
2. 13 元素输入校验、变量命名 + 每行语义注释、统一列向量；
   控制律、死区、限幅、误差滚动逻辑与原版完全一致。
3. 本工程原版 `pid_calc.m` 与宝马工程逐字相同，故 `pid_calc_v2.m` 直接复用
   宝马版，默认行为与本工程原版一致。

---

## 6. 如何接入现场（替换方式）

在 `on_timer.m` 等调用处，用重构版替换原版即可（默认行为一致）：

```matlab
% 原版 gpc_clac（N=80/Nu=20）
u = gpc_clac(A, B, P, yout1, Up1, sp, gpc_a, gpc_lmd);
% 重构版（默认行为与原版一致）
u = gpc_clac_v2(A, B, P, yout1, Up1, sp, gpc_a, gpc_lmd);
% 若模型参数固定，可进一步缓存矩阵提速：
u = gpc_clac_v2(A, B, P, yout1, Up1, sp, gpc_a, gpc_lmd, struct('use_cached', true));
```

```matlab
% 原版 gpc_clac1（N=50/Nu=15）—— 注意原函数名是 gpc_clac1
u = gpc_clac1(A, B, P, yout1, Up1, sp, gpc_a, gpc_lmd);
% 重构版（调用 gpc_clac1 的位置改用 gpc_clac1_v2）
u = gpc_clac1_v2(A, B, P, yout1, Up1, sp, gpc_a, gpc_lmd);
u = gpc_clac1_v2(A, B, P, yout1, Up1, sp, gpc_a, gpc_lmd, struct('use_cached', true));
```

```matlab
% 原版 PID
pidloop(:,8) = pid_calc(pidloop(:,8)');
% 重构版（正常参数行为一致，ti=0 不再崩）
pidloop(:,8) = pid_calc_v2(pidloop(:,8)');
```

---

## 7. 备注

- 本机 MATLAB R2025a 许可过期，未运行任何 .m；一致性由 `test_verify.py`
  的 numpy 等价移植完成（运行 `python3 test_verify.py` 须全部 PASS，已验证）。
- 原版 `gpc_clac.m`、`gpc_clac1.m`、`pid_calc.m` 一个字节都未改动；
  本次仅新增 `refactored/` 目录，未改动仓库其他任何文件，未做 git push。
