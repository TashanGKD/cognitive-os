---
name: cognitive-associate
description: 联想激活（启动效应等效）。不被用户直接触发，作为「能力层工具函数」由其他Skill调用。给定一个概念，在知识图谱中激活语义相邻的概念网络，返回Top-5邻居摘要给调用方。被 cognitive-ask Step 2c 和 cognitive-capture-fragment Step 2.5 调用。
---

# cognitive-associate（联想 / 启动效应等效）

> **对应认知活动**：启动效应（Priming）——给定一个概念，自动激活语义相邻的概念网络，找到你可能没想到的关联
>
> **认知五维坐标（COG-TAX）**：
> - 意识程度：前意识→显性（启动是无意识的，结果呈现是显性的）
> - 脑网络：DMN（自由联想）+ SN（相关性检测）
> - 记忆系统：语义记忆（L1）的扩散激活
> - 执行功能：转换（在不同概念节点之间跳转）
> - 双系统：系统1（模式匹配，快速）
>
> **理论依据**：Collins & Loftus (1975) 扩散激活理论；Meyer & Schvaneveldt (1971) 启动效应实验
>
> **实现定位**：能力层工具函数（不是对话层Skill）
> **触发条件**：不接受用户直接触发词；只被其他Skill内部调用

---

## 知识导航表

| 层级 | 文档 | 用途 |
|------|------|------|
| D0 运行时数据 | `cognitive/knowledge_graph.md`| 概念关系边（depends/extends/cross_ref/references）|
| D0 上游输入 | 由调用方 Skill 传入「概念X」| 激活起点 |

**知识图谱说明**：
- 维护者：cognitive-update-knowledge（新增L1文档时可选更新）/ cognitive-integrate-fragments（新增关系边时可选更新）
- 建立方式：初始建立需运行一次「建立知识图谱」任务（手动），后续随L1文档变更逐步更新
- 若不存在：本Skill降级为「仅返回L0地图中的维度关系」（功能大幅受限但不报错）

---

## 接口规格

**输入（由调用方传入）**：
```
concept_x: str  # 需要激活邻域的概念名称（通常是 L1 文档节点名或碎片标题）
hop_limit: int  # 最大跳数（默认=2，不超过3）
```

**输出（返回给调用方）**：
```
neighbors: list[{
  name: str,           # 邻居节点名称
  relation: str,       # 关系类型（depends/extends/cross_ref/references）
  summary: str,        # 邻居文档首段或100字摘要
  relevance_score: float  # 关系强度评分（depends=1.0 > extends=0.8 > cross_ref=0.6 > references=0.4）
}]
```

---

## 激活后立即执行

```
Step 1  接收输入
        从调用方获取：concept_x（概念名）、hop_limit（默认=2）

Step 2  第一跳：直接邻居
        Read: 知识图谱文件
        → 找 concept_x 对应节点的全部关系边
        → 提取所有直接邻居（第1跳）：{邻居名, 关系类型}

Step 3  关系强度排序
        按以下优先级排序：
        depends（依赖）> extends（扩展/继承）> cross_ref（交叉引用）> references（提及）
        → 选取前5个作为「优先邻居」
        → 若邻居 < 3个，且 hop_limit ≥ 2：对排名前3的邻居继续做第2跳（Step 4）

Step 4  第二跳（可选，若第一跳邻居 < 3 且 hop_limit ≥ 2）
        对第一跳前3个邻居，重复 Step 2，获取其邻居
        → 合并去重（排除 concept_x 自身）
        → 与第一跳邻居合并，仍按关系强度排序，取Top-5

Step 5  读取邻居摘要
        对 Top-5 优先邻居，每个读取：
        - 若存在 L0 地图中的 core_claim 字段 → 直接使用（< 80字）
        - 若不存在 → 读取对应 L1 文档的首段（最多100字）

Step 6  组装并返回结果
        返回格式（传给调用方，不输出到对话）：
        ```
        发现的关联概念（Top-5）：
        1. [邻居名]（关系：depends）— [摘要]
        2. [邻居名]（关系：extends）— [摘要]
        ...
        ```

        ⚠️ 若知识图谱文件不存在或 concept_x 不在图谱中：
        → 返回「知识图谱未建立或无对应节点，联想激活跳过」
        → 不中断调用方的执行流程
```

---

## 调用示例

```
# 在 cognitive-ask 中的调用（Step 2c）
「用户询问关于「产品闭环」的问题」
→ cognitive-associate(concept_x="产品闭环", hop_limit=2)
→ 返回：AI时代产品问题全景框架 / 马斯洛新瓶颈分析 / 闭环递进法 / ...
→ cognitive-ask 把这些相关概念纳入回答范围

# 在 cognitive-capture-fragment 中的调用（Step 2.5，可选）
「捕捉新碎片「压力下跳过验证步骤」」
→ cognitive-associate(concept_x="验证步骤", hop_limit=1)
→ 返回：P1验证优先原则 / 认知一致性检测 / ...
→ 提示：「这个碎片与以下已有概念相关，整合时可考虑关联」
```

---

## 边界约束

- ❌ 不独立写入任何文件（联想是过渡性操作，只传递结果）
- ❌ 不被用户直接触发（是能力层工具函数）
- ❌ 不在 hop_limit=0 时执行任何读取
- ❌ 不在知识图谱为空时报错（静默返回空结果）
- 单次调用最多读取 5 个邻居文档，每个最多 100 字（控制 token 消耗）

---

## D5 说明（工具函数豁免）

> 本Skill为**能力层工具函数**，不产生独立D5信号。
> 
> **豁免理由**：cognitive-associate 是过渡性操作（联想结果传递给调用方），本身不写入任何文件，不产生独立的认知操作记录。由调用方（cognitive-ask / cognitive-capture-fragment）的D5机制统一处理联想结果的Loop路由。
>
> **调用链中的Loop位置**：
> - 当 cognitive-ask 调用 cognitive-associate 后，cognitive-ask 的D5负责声明本次查询产生了什么信号
> - 当 cognitive-capture-fragment 调用 cognitive-associate（Step 2.5）后，capture-fragment 的D5负责声明

---

## 变更记录

### v0.1 — 2026-03-23 — 从全量认知Skill规范.md Skill 7 + 完善规划.md N2 复现

**来源**：会话 a55a4e9e（认知体系完善规划），全量规范 §Skill 7 + 完善规划 §N2
**状态**：🟡 待审核（Gate A/B/C 尚未通过）
**存放位置**：pending-skills/（非正式部署区）
