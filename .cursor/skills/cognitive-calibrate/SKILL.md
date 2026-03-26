---
name: cognitive-calibrate
description: 置信度校准（元认知监控）。追踪L1文档和L2碎片中「AI生成/推断」的内容是否事后得到了验证，定期向用户提问「这段内容当时是AI推断，现在有没有实际证据？」。触发词：「验证历史内容」「校准知识置信度」「哪些内容还没验证」「cognitive-calibrate」。也被 cognitive-consistency-check 内部调用（月度维护）。
---

# cognitive-calibrate（置信度校准 / 元认知置信度监控）

> **对应认知活动**：元认知的置信度校准——追踪🟡AI生成内容是否事后得到验证，防止「自我确认偏误」导致未验证的推断长期被当作事实
>
> **认知五维坐标（COG-TAX）**：
> - 意识程度：显性（需要用户参与确认）
> - 脑网络：CEN（目标导向的检索与判断）+ SN（不确定性检测）
> - 记忆系统：语义记忆的准确性评估
> - 执行功能：监控（Monitoring），是元认知的核心成分
> - 双系统：系统2（需要主动评估，不能自动化）
>
> **理论依据**：Flavell (1979) 元认知监控；Dunning & Kruger (1999) 元认知准确性；Nelson & Narens (1990) 置信度监控框架
>
> **调用时机**：
> 1. 被 cognitive-consistency-check 内部调用（月度维护，Step 8）
> 2. 用户主动触发（「验证历史内容」「校准知识置信度」）
>
> **Headless调用说明**（被 cognitive-consistency-check Step 8 调用时）：
> - 调用方传入默认范围参数：scope="ALL_90_DAYS"（跳过Step 0的交互选择）
> - 跳过 Step 0：不询问用户，直接使用 scope="ALL_90_DAYS" 执行 Step 1
> - 若筛选结果 > 10条：Headless模式下只处理前10条（避免过长执行）
> - 所有 Step 4 的结果写入 todo.md，等待下次 daily-briefing 展示给用户
> - 不向对话输出 Step 4 的摘要（Headless模式静默执行）

---

## 知识导航表

| 层级 | 文档 | 用途 |
|------|------|------|
| D0 碎片索引 | `cognitive/L2_fragments/fragment_index.md` | 找到所有「归因=🟡AI生成/推断，验证状态=未验证」的条目 |
| D0 L1 文档 | `cognitive/L1_knowledge/[各维度文档]`（含🟡标注的段落）| 找到需要验证的具体内容 |

---

## 激活后立即执行

```
Step 0  确认检查范围
        Ask: 本次校准的范围？
        选项 A：90天以上未验证的🟡内容（全量，可能较多）
        选项 B：指定某个L1文档（精准，快速）
        选项 C：从上次校准以来的所有🟡内容

Step 1  读取待验证条目
        Read: cognitive/L2_fragments/fragment_index.md
        → 筛选：归因类型=🟡AI生成/推断 AND 验证状态=🔲未验证 AND capture_time < 今天-[范围天数]
        → 提取：碎片ID、标题、capture_time

        Read: cognitive/L1_knowledge/[目标文档]
        → 扫描🟡归因标注的段落
        → 提取：段落位置、内容摘要（前150字）、标注时间

        → 若筛选结果为0条 → 告知用户「选定范围内无需校准的内容（🟡内容已全部处理，或该范围内无🟡归因内容）」
           然后退出，不继续执行 Step 2 以后的步骤

Step 2  逐条向用户展示并询问

        对每个待验证条目，展示：
        ---
        📋 [内容编号/N]
        **来源**：[L1文档名 §章节] / [L2碎片ID「标题」]
        **当时的归因**：🟡 AI生成/推断（[capture_date]，距今[N]天）
        **内容摘要**：[前150字]

        **问题**：这段内容当时是AI的推断。现在：
        A. ✅ 已有实际证据支持（标记为「已验证」）
        B. ❌ 事后发现是错的（标记为「已否定」，需要修订L1/L2）
        C. ⏸️ 还不确定，继续观察
        D. ⏭️ 跳过这条（稍后处理）
        ---

Step 3  根据用户回答更新验证状态

        A（已验证）：
        → 更新 fragment_index.md：验证状态=✅已验证，verified_date=今天
        → 更新 L1 文档：将🟡标注改为✅（StrReplace）

        B（已否定）：
        → 更新 fragment_index.md：验证状态=❌已否定，verified_date=今天
        → 在 cognitive/L3_logs/todo.md 追加：
          □ [校准-YYYYMMDD] 碎片[ID]/[L1段落]已被否定，需要修订对应内容
          建议：运行 cognitive-update-knowledge 或 cognitive-detect-contradiction
        → 不自动修改 L1（修订需要用户确认）

        C（继续观察）：
        → 更新 fragment_index.md：验证状态=⏸️观察中，last_check=今天
        → 不做其他操作

        D（跳过）：
        → 不更新验证状态
        → 记录「已跳过」供下次校准时再展示

Step 4  生成校准摘要

        输出：
        ---
        ## 置信度校准摘要（[今日日期]）
        处理条目：N条
        - ✅ 已验证：X条
        - ❌ 已否定（需修订）：Y条 → 已加入待完成清单
        - ⏸️ 继续观察：Z条
        - ⏭️ 跳过：W条（下次校准时再显示）
        ---

Step 5  追加系统日志
        Write: cognitive/L3_logs/system_log.md（追加）
        格式：[LOG-YYYYMMDD-NN] cognitive-calibrate | 校准完成：验证X条，否定Y条，观察Z条 | fragment_index.md
```

---

## 归因标注说明

| 归因类型 | 含义 | 需要校准？ |
|----------|------|----------|
| 🟢 user_original | 用户直接说出的内容 | 否 |
| 🟡 ai_inference | AI推断/合成，未经用户确认 | **是（本Skill的核心对象）** |
| 🔵 ai_synthesis | AI整合多个来源的综合 | 是（可选） |
| ✅ verified | 已经过校准确认 | 否 |
| ❌ rejected | 已被否定 | 否（但需要修订文档）|

---

## D5：任务完成后的 Loop 反馈

**本次执行产出**：
- K-object 更新：碎片索引验证状态更新 + L1 文档🟡→✅标注修改
- S-object 追加：系统日志 + 待完成清单（否定类条目）

**Loop 路由**：
- **通路B（Loop 3 → Loop 2）**：发现被否定内容 → 追加到 todo.md → 等待 cognitive-update-knowledge 修订
- **系统完整性**：随时间推移，🟡内容比例降低，🟢/✅内容比例上升，知识准确性持续提升

**信号类型（A-G框架）**：
- 发现已否定内容（B类）≥ 3条 → **G信号**（结构性根因：🟡归因机制被过度使用，AI推断质量需要系统性改进）
- 所有内容已验证通过（A类）→ 通路A内部完成，无额外信号（知识准确性良好）
- 发现大量「⏸️无法验证」 → **A信号**（Skill改进：calibrate步骤可补充外部验证引导机制）

---

## 变更记录

### v0.1 — 2026-03-23 — 从全量认知Skill规范.md Skill 13 复现

**来源**：会话 a55a4e9e（认知体系完善规划），全量规范 §Skill 13
**路径映射**：原 _内部总控/ 路径已替换为 cognitive/ 通用路径
**状态**：🟡 待审核（Gate A/B/C 尚未通过）
**存放位置**：pending-skills/（非正式部署区）
