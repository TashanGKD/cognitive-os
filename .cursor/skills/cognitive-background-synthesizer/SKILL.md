---
name: cognitive-background-synthesizer
description: 后台认知合成器（DMN等效，Headless）。不被用户直接触发，由后台调度脚本每3天执行一次。跨碎片关联分析：找到不同时间捕捉的碎片之间的隐性关联，生成合成报告写入L3，等待daily-briefing展示给用户。触发词（人工触发时）：「执行后台合成」「cognitive-background-synthesizer」。
---

# cognitive-background-synthesizer（后台认知合成 / DMN等效）

> **对应认知活动**：默认模式网络（DMN）——大脑空闲时自发做的跨话题后台合成、远距联想、洞见生成。人类的很多「灵光一闪」发生在非专注状态，这个Skill模拟这个过程。
>
> **认知五维坐标（COG-TAX）**：
> - 意识程度：隐性（用户不参与，后台自动）
> - 脑网络：DMN（默认模式网络，后台合成主导）
> - 记忆系统：情节记忆（L2/L3）跨时间的模式提取
> - 执行功能：无（自动化关联分析）
> - 双系统：系统1（自动模式匹配）→ 结果供用户用系统2评估
>
> **理论依据**：Buckner et al. (2008) DMN综述；Christoff et al. (2016) 心智游走与创造性思维；Kounios & Beeman (2014) 顿悟神经机制
>
> **调用方式**：后台脚本，每3天执行一次（headless模式）
> **人工触发**（可选）：「执行后台合成」「cognitive-background-synthesizer」

---

## 知识导航表

| 层级 | 文档 | 用途 |
|------|------|------|
| D0 碎片索引 | `cognitive/L2_fragments/fragment_index.md` | 获取最近14天新增碎片的ID和标题 |
| D0 任务日志 | `cognitive/L3_logs/task_log.md` | 获取最近14天任务摘要（「完成的工作」字段）|
| D0 知识图谱 | `cognitive/knowledge_graph.md` | 了解L1文档间关系（判断同话题簇）|

---

## 激活后立即执行（Headless 模式）

```
Step 0  输入充分性检查（安全退出点）
        Read: cognitive/L2_fragments/fragment_index.md
        → 统计最近14天内「待整合」碎片数量
        → 若 < 3条 → 静默退出，在系统日志写一行「条件未满足：碎片不足3条，跳过」
        → 若 ≥ 3条 → 继续

Step 1  读取输入材料
        Read: cognitive/L2_fragments/fragment_index.md
        → 提取最近14天新增的「待整合」碎片：{碎片ID, 标题, 关键词, capture_date, 归属维度}

        Read: cognitive/L3_logs/task_log.md
        → 提取最近14天的任务记录，仅读「完成的工作」字段（每条取前200字）
        → 若任务日志过大（>50条），只取最近20条

        Read: cognitive/knowledge_graph.md（若存在）
        → 获取L1文档节点列表和主要关系边
        → 若文件不存在：跳过图谱参考，仅基于碎片关键词做分析

Step 2  跨碎片关联分析（核心步骤）
        对 Step 1 收集到的全部碎片内容，寻找以下三类模式：

        模式A：「相同底层结构」
          条件：两个或多个碎片，讨论了不同现象，但底层逻辑相同
          判断方法：碎片的核心动词/因果关系是否高度相似？
          输出：「碎片[A] 和碎片[B] 都在说：[共同底层结构，一句话]」

        模式B：「碎片解释任务困难」
          条件：某个碎片的核心洞见，可以解释任务日志中提到的某个困难/失败
          判断方法：碎片关键词与任务摘要中的「问题/困难/没想到」部分是否高度相关？
          输出：「任务「[任务名]」遇到的困难，可能与碎片「[碎片标题]」的洞见有关」

        模式C：「候选重复/合并」
          条件：相隔 > 7天捕捉的两个碎片，实质上在说同一件事
          判断方法：碎片标题/核心词高度重叠（>60%语义相似）
          输出：「碎片[A]（[日期A]）与碎片[B]（[日期B]）实质相同，建议合并」

Step 3  生成合成报告
        Write: cognitive/L3_logs/synthesis_report_YYYYMMDD.md（新建）
        格式：
        ---
        ## 后台合成报告（YYYY-MM-DD）
        
        ### 发现的跨碎片连接（模式A）
        [若无发现：「本次未发现跨碎片连接」]
        - 连接1：碎片「[A标题]」× 碎片「[B标题]」
          共同底层结构：[一句话]
          建议行动：[整合到同一L1章节 / 提炼为新原则候选 / 暂时观察]
        
        ### 碎片-任务关联（模式B）
        [若无发现：「本次未发现碎片-任务关联」]
        - 任务「[任务名]」中的困难 → 可能与碎片「[碎片标题]」相关
          关联说明：[一句话]
        
        ### 候选重复/合并建议（模式C）
        [若无发现：「本次未发现候选重复」]
        - 碎片「[A]」（[日期]）≈ 碎片「[B]」（[日期]），建议合并处理
        ---

Step 4  追加到待完成清单
        Write: cognitive/L3_logs/todo.md（追加）
        □ [synth-YYYYMMDD] 后台合成报告已生成，建议查看
          路径：cognitive/L3_logs/synthesis_report_YYYYMMDD.md
          发现：[连接X条，关联Y条，重复Z条]

Step 5  追加系统日志
        Write: cognitive/L3_logs/system_log.md（追加）
        格式：[LOG-YYYYMMDD-NN] cognitive-background-synthesizer | 合成完成：发现连接X条，关联Y条，重复Z条 | synthesis_report_YYYYMMDD.md
```

---

## Headless 模式规范

| 规范 | 说明 |
|------|------|
| 无交互点 | 不出现等待用户输入的步骤 |
| 只写文档 | 所有输出写到 L3_logs/，不向对话输出 |
| 安全退出 | 碎片 < 3条时静默退出，记录日志 |
| 不修改L1 | 只生成建议，让用户或 integrate-fragments 决策 |
| 不发通知 | 结果放入 todo.md，等待 daily-briefing 展示 |

---

## D5：任务完成后的 Loop 反馈

**本次执行产出**：
- S-object 新建：`cognitive/L3_logs/synthesis_report_YYYYMMDD.md`（合成报告）
- S-object 追加：系统日志 + 待完成清单

**Loop 路由**：
- **通路B（Loop 3 → Loop 2）**：
  → 合成报告中的「建议整合」→ 用户查看后可触发 cognitive-integrate-fragments（通路B延迟完成）
  → 合成报告中的「建议提炼原则」→ 可触发 cognitive-extract-principle

**信号类型（A-G框架）**：
- 发现模式A（相同底层结构）≥ 2条 → **D信号**（洞见：可能有新原则候选，路由给 cognitive-extract-principle 评估）
- 发现模式C（候选重复/合并）→ **A信号**（Skill改进：capture-fragment步骤可能需要补充「重复检测」机制）
- 连续3次执行均无发现（空报告）→ **A信号**（Skill改进：14天时间窗口或分析策略需要调整）
- todo.md已追加 → S-object更新完成，无额外信号

**对 cognitive-daily-briefing 的依赖声明**：
⚠️ 合成报告通过 todo.md 等待 cognitive-daily-briefing 展示给用户。
若 cognitive-daily-briefing Skill 未实现对 todo.md 的扫描读取，合成报告将不会主动展示。
请在部署前确认 cognitive-daily-briefing 的 Step 1 包含读取 todo.md 的逻辑。

---

## 变更记录

### v0.1 — 2026-03-23 — 从全量认知Skill规范.md Skill 16 + 完善规划.md N1 复现

**来源**：会话 a55a4e9e（认知体系完善规划），全量规范 §Skill 16 + 完善规划 §N1（详细设计）
**路径映射**：原 _内部总控/ 路径已替换为 cognitive/ 通用路径
**状态**：🟡 待审核（Gate A/B/C 尚未通过）
**存放位置**：pending-skills/（非正式部署区）
