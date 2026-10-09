# MATLAB_PID_GPC_CLE

2022–2025 第一份工作期间，为多家水泥厂部署的**水泥烧成系统先进过程控制（APC）**程序，基于 MATLAB + DCS/OPC 开发。

**完整项目档案（GitHub Pages）**：<https://lszlovelhl.github.io/MATLAB_PID_GPC_CLE/>

---

## 核心算法

| 算法 | 文件 | 说明 |
|---|---|---|
| **GPC** 广义预测控制 | `gpc_clac.m` | Diophantine 求解 + 预测矩阵 + 自适应 λ；用于分解炉温度、篦冷机等慢回路 |
| **PID** 增量式 | `pid_calc.m` | 13 元素参数向量（sp/pv/mv/误差/pid/限幅/死区），多回路共用 |
| **CLE** 趋势前馈（自研） | 内联于 on_timer | 10s 窗口趋势识别 + 补偿叠加，外部扰动大时用 |
| **Fuzzy** 模糊控制 | `FuzzyControl.m` | 二维 Mamdani（Et/ECt→ΔF），点火升温等非线性阶段 |

## 现场工程（10 个）

| 工程 | 时间 | 技术特点 |
|---|---|---|
| GY-750 | 2022-03 | 4 通道并行 GPC + CLE |
| tg#4 | 2022-08 | 3 通道 GPC + 模糊控制 + 风/气停机联锁 |
| 宝马水泥 | 2022-08 | 6 回路 PID + 分解炉 GPC（**已重构：`refactored/`**） |
| JL-2 | 2023-09 | 5 通道并行 GPC + CLE |
| 含山南方 | 2024-04 | 分解炉 GPC + 篦冷机 GPC + CLE |
| 金塬 | 2024-08 | 多回路 GPC + CLE 趋势前馈 |
| 江油拉豪 | 2024-12 | **分解炉串级**（GPC 外环 + PID 内环）+ 篦冷机联动 + CLE |
| 溧水天山 | 2025-07 | 分解炉串级 + GPC |
| gaoyi3 / gaoyi4 | 2025-07 | 模糊 PID + 常规 PID |

## 代码导航

- 每个工程的入口均为定时器回调 `on_timer.m` / `onTimer_io_4duan.m`（部分为 `control_code.m`），从 OPC/DCS 读数据、按周期调度各回路。
- **宝马工程 `refactored/`**：对核心 GPC/PID 的参数化重构版——修复 `ti=0` 除零、矩阵可缓存提速、默认输出与现场逐位一致。详见 `refactored/README_REFACTOR.md`。

> 提示：多数 `.m` 为 GBK 编码，中文注释在 UTF-8 编辑器下会显示乱码，阅读时可用文本工具转码。
