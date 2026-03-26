---
name: cognitive-consolidate
description: 记忆巩固（Headless，睡眠期巩固等效）。不被用户直接触发，由后台调度脚本每7天执行一次。将积压的成熟L2碎片批量整合进L1，conflict类碎片记录到待完成清单由用户决策。触发词（人工触发时）：「执行记忆巩固」「批量整合积压碎片」「cognitive-consolidate」。
---

# cognitive-consolidate（记忆巩固 / 睡眠期巩固等效）

> **对应认知活动**：睡眠期记忆巩固（海马体→皮层长期存储）——定期将积压的L2碎片批量整合进L1，完成情节记忆→语义记忆的转化
>
> **认知五维坐标（COG-TAX）**：
> - 意识程度：隐性（用户不参与，后台自动）
> - 脑网络：DMN（离线加工，记忆重激活）
> - 记忆系统：情节记忆→语义记忆的转化（海马体→皮层）
> - 执行功能：无（自动化批处理）
> - 双系统：系统1（自动批处理，不需要有意识的决策）
>
> **理论依据**：Stickgold (2005) 睡眠依赖性记忆巩固；Wilson & McNaughton (1994) 海马体重激活；McClelland et al. (1995) 互补学习系统理论
>
> **调用方式**：后台脚本，每7天执行一次（headless模式）
> **人工触发**（可选）：「执行记忆巩固」「批量整合积压碎片」

---

## 知识导航表

| 层级 | 文档 | 用途 |
|------|------|------|
| D0 碎片索引 | `cognitive/L2_fragments/fragment_index.md` | 找到所有「待整合且已成熟」的碎片 |
| D0 L1 目标 | `cognitive/L1_knowledge/[各维度文档]` | 整合的目标文档 |
| D0 L0 地图 | `cognitive/L0_brain_map.md` | 了解文档间依赖关系 |

---

## 激活后立即执行（Headless 模式，所有决策使用默认策略）

```
Step 0  成熟度检查（安全退出点）
        Read: cognitive/L2_fragments/fragment_index.md
        → 筛选条件：状态=🔲待整合 AND capture_time < 今天-7天
        → 若成熟碎片 < 3条 → 静默退出（输出「巩固条件未满足，退出」到系统日志后结束）
        → 若 ≥ 3条 → 继续 Step 1

Step 1  读取成熟碎片
        对每个成熟碎片 ID：
        Read: cognitive/L2_fragments/[对应碎片文件]
        → 提取：碎片标题、核心内容、归属维度、capture_time、归因类型

Step 2  按关联 L1 分组
        根据碎片的「归属维度」字段，将碎片分组：
        组1: 归属 [维度A] 的碎片 → 目标 L1 文档 = [维度A对应文档]
        组2: 归属 [维度B] 的碎片 → 目标 L1 文档 = [维度B对应文档]
        ...
        若碎片无明确归属维度 → 归入「待分类」组，追加到待完成清单（不自动处理）

Step 3  逐组执行整合（supplement路径优先，conflict路径不自动执行）
        对每个分组：
        Read: cognitive/L1_knowledge/[目标文档] 全文
        
        对每个碎片，判断整合路径：
        
        supplement（补充）路径 ← 默认执行：
          条件：碎片内容与L1现有内容兼容，可直接添加
          动作：在L1文档对应章节末尾追加碎片内容（StrReplace）
                追加格式：「— （来自L2碎片 [碎片ID]，[capture_date]）」
        
        conflict（冲突）路径 ← 不自动执行，转入人工决策：
          条件：碎片内容与L1现有核心论点存在实质矛盾
          动作：追加到待完成清单（Step 4），不修改L1
        
        covered（已覆盖）路径 ← 静默归档：
          条件：碎片内容已被L1现有内容完整覆盖
          动作：更新碎片状态为「📦已归档（被L1覆盖）」

Step 4  conflict 类碎片追加到待完成清单
        Write: cognitive/L3_logs/todo.md（追加）
        格式：
        □ [巩固-YYYYMMDD] 碎片[ID]「[标题]」与[L1文档名]存在冲突，需人工决策
          碎片内容摘要：[前100字]
          冲突点：[一句话描述]

Step 5  更新碎片整合索引
        Write: cognitive/L2_fragments/fragment_index.md
        → 已supplement碎片：状态改为「✅已整合（巩固批次 YYYYMMDD）」
        → 已covered碎片：状态改为「📦已归档」
        → conflict碎片：状态改为「⏸️冲突待决策」

Step 6  写入巩固报告
        Write: cognitive/L3_logs/consolidation_report_YYYYMMDD.md（新建）
        内容：
        ---
        ## 记忆巩固报告（YYYY-MM-DD）
        - 处理碎片总数：N条
        - supplement（已整合）：X条 → [列出碎片ID和目标文档]
        - covered（已归档）：Y条
        - conflict（待人工决策）：Z条 → [列出碎片ID]
        - 静默退出原因：无（或：成熟碎片不足3条）
        ---

Step 7  追加系统日志
        Write: cognitive/L3_logs/system_log.md（追加）
        格式：[LOG-YYYYMMDD-NN] cognitive-consolidate | 巩固完成：整合X条，归档Y条，冲突Z条待决策 | fragment_index.md
```

---

## Headless 模式规范

| 规范 | 说明 |
|------|------|
| 无交互点 | 执行过程中不出现等待用户选择的步骤 |
| 默认策略 | supplement优先；conflict转清单；covered静默归档 |
| 只写文档 | 不向对话输出；不返回用户可见内容 |
| 安全退出 | 成熟碎片 < 3条时静默退出 |
| 错误处理 | 遇到无法判断的碎片 → 追加到待完成清单，不中断执行 |

---

## D5：任务完成后的 Loop 反馈

**本次执行产出**：
- K-object 更新：L1 文档批量更新（supplement类碎片）
- S-object 追加：碎片整合索引状态更新 + 巩固报告 + 系统日志 + 待完成清单（conflict类）

**Loop 路由**：
- **通路A（Loop 2 内部）**：L2 碎片成功转化为 L1 语义记忆，情节→语义转化完成
- **通路B（待完成清单）**：conflict 类碎片进入 todo.md，等待用户决策（通路B的延迟执行）

**信号类型（A-G框架）**：
- supplement整合成功多次（>5条）→ **A信号**（Skill改进：整合效率/碎片归属策略可能有优化空间）
- conflict类碎片积累 ≥ 3条 → **G信号**（结构性根因：L1文档结构或碎片归因机制存在系统性问题）
- 执行完成无异常 → 无独立信号（通路A内部完成，不额外产生信号）

---

## 变更记录

### v0.1 — 2026-03-23 — 从全量认知Skill规范.md Skill 10 复现

**来源**：会话 a55a4e9e（认知体系完善规划），全量规范 §Skill 10
**路径映射**：原 _内部总控/ 路径已替换为 cognitive/ 通用路径
**状态**：🟡 待审核（Gate A/B/C 尚未通过）
**存放位置**：pending-skills/（非正式部署区）
