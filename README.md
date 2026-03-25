# cognitive-os · 认知操作系统

> **AI agents don't forget. But without structure, they can't truly think.**
>
> **AI 智能体不会遗忘。但没有结构，它们无法真正思考。**

A Cursor-native system that externalizes the human brain's layered memory structure, enabling AI agents to **build**, **maintain**, and **self-evolve** a user's cognitive framework — grounded in 50+ years of cognitive science.

一套基于 Cursor 的认知外化系统，将人类大脑的层级记忆结构数字化，让 AI 智能体能够**构建**、**维护**并**自我迭代**用户的认知体系 — 以 50 余年认知科学研究为基础。

---

## Why This Exists / 为什么做这个

Every knowledge worker faces the same problem: their best thinking is trapped inside their head — fragmented, inconsistent, inaccessible to AI agents, and forgotten the moment they switch contexts.

每个知识工作者都面临同一个问题：他们最好的思考被锁在脑子里——碎片化、自相矛盾、AI 无法触及，而且一旦切换上下文就会遗忘。

This system does one thing: **externalize the cognitive structure of the human brain into a queryable, updatable, self-consistent knowledge system** that AI agents can operate on.

这套系统做一件事：**把人脑的认知结构外化为可查询、可更新、自洽的知识体系**，让 AI 智能体能够操作它。

---

## Cognitive Science Foundation / 认知科学基础

The architecture mirrors the human brain's actual memory hierarchy (as established by Squire & Zola-Morgan, 1993; Piaget, 1952; Flavell, 1979):

系统架构镜像了人类大脑的真实记忆层次（Squire & Zola-Morgan 1993; Piaget 1952; Flavell 1979 的研究成果）：

| Layer | Files | Brain Equivalent | Theory |
|---|---|---|---|
| **L0** Brain Map | `cognitive/L0_brain_map.md` | Metacognition | Flavell (1979) |
| **L1.5** Principles | `cognitive/L1.5_principles/` | Schema / Mental Model | Piaget (1952) |
| **L1** Knowledge | `cognitive/L1_knowledge/` | Semantic Memory | Squire & Zola-Morgan (1993) |
| **L2** Fragments | `cognitive/L2_fragments/` | Episodic→Semantic transition | Hippocampal-neocortical dialogue |
| **L3** Logs | `cognitive/L3_logs/` | Episodic Memory | Tulving (1972) |

Each cognitive operation is also grounded in theory:

每种认知操作也有对应的理论基础：

| Operation / Skill | Cognitive Science Mechanism | Key Reference |
|---|---|---|
| Fragment capture | Episodic memory externalization + Source Monitoring | Tulving (1972); Source Monitoring Framework |
| Fragment integration (Homunculus mechanism) | Piaget Assimilation / Accommodation | Piaget (1952) Equilibration Theory |
| Direct L1 update | Controlled semantic memory modification `ceremony(K)` | Formal specification; Flavell metacognitive monitoring |
| Principle extraction | Schema formation via DMN incubation | Wallas (1926) 4-stage model; Collins & Loftus (1975) |
| Contradiction detection | ViolEx 2.0 schema violation processing | Gawronski & Brannon (2022) |
| Self-reflection | Reflection vs. Rumination distinction | Treynor et al. (2003); DMN+FPCN vs. mPFC |
| Cascade notification | Spreading activation | Collins & Loftus (1975) |
| Task-cognitive extraction | Episodic→Semantic consolidation | Squire (1993) hippocampal-neocortical dialogue |

---

## Architecture / 架构

```
cognitive-os/
│
├── cognitive/                 ← Your cognitive structure (user-customized)
│   ├── L0_brain_map.md        ← Metacognition: master index, restores context fast
│   ├── maintenance_protocol.md ← C1-C13 consistency conditions
│   ├── document_catalog.md    ← Status of all documents
│   ├── knowledge_graph.md     ← Relationship map of L1 documents
│   ├── work_domains.md        ← Your work areas (for cascade notifications)
│   ├── L1.5_principles/       ← Core principles (Schema layer)
│   │   └── principles.md
│   ├── L1_knowledge/          ← Systematic knowledge (Semantic Memory)
│   │   └── [your domains]/
│   ├── L2_fragments/          ← Raw insights (Episodic→Semantic in-progress)
│   │   ├── fragment_index.md
│   │   └── reflections/
│   └── L3_logs/               ← Operation logs (Episodic Memory)
│       ├── system_log.md
│       ├── todo.md
│       └── consistency_record.md
│
├── .cursor/
│   ├── skills/                ← 13 cognitive-* Skills
│   │   ├── cognitive-capture-fragment/
│   │   ├── cognitive-integrate-fragments/
│   │   ├── cognitive-update-knowledge/
│   │   ├── cognitive-extract-principle/
│   │   ├── cognitive-detect-contradiction/
│   │   ├── cognitive-ask/
│   │   ├── cognitive-self-reflect/
│   │   ├── cognitive-daily-briefing/
│   │   ├── cognitive-review-brain-map/
│   │   ├── cognitive-consistency-check/
│   │   ├── cognitive-reorganize/
│   │   ├── cognitive-input-classifier/
│   │   └── cognitive-version-snapshot/
│   │
│   ├── agents/                ← 4 cognitive-* Subagents
│   │   ├── cognitive-verifier.md         ← Post-update consistency check
│   │   ├── cognitive-fragment-integrator.md  ← Batch integration (≥5 fragments)
│   │   ├── cognitive-cascade-notifier.md ← Spreading activation notifier
│   │   └── cognitive-task-reflector.md   ← Post-task cognitive extraction
│   │
│   └── rules/                 ← 4 cognitive-* Rules (always-on guards)
│       ├── cognitive-structure-write-guard.mdc  ← Enforces backup+attribution+cascade
│       ├── cognitive-l3-auto-log.mdc            ← Auto-logs all cognitive ops
│       ├── cognitive-principle-check.mdc        ← Checks new content vs principles
│       └── fragment-before-direct-edit.mdc      ← Prompts fragment-first workflow
│
├── logs/
│   └── task_log.md            ← AI task history
│
└── scripts/
    └── setup.sh               ← One-command initialization
```

---

## Quick Start / 快速开始

### Option A: New Workspace (Recommended)

```bash
# Clone the repository into your workspace
git clone https://github.com/TashanGKD/cognitive-os.git
cd cognitive-os

# Initialize (copies cognitive structure + .cursor/ into current directory)
./scripts/setup.sh

# Open in Cursor
cursor .
```

### Option B: Add to Existing Workspace

```bash
# In your existing workspace root:
git clone https://github.com/TashanGKD/cognitive-os.git /tmp/cognitive-os
cd /tmp/cognitive-os
./scripts/setup.sh /path/to/your/workspace
```

### First Steps After Setup

1. Open your workspace in Cursor
2. Edit `cognitive/work_domains.md` — define your work areas
3. In Cursor chat, say: **"Let's reorganize my cognitive structure"** → `cognitive-reorganize` Skill guides you
4. Start capturing ideas: **"Record a fragment: [your idea]"** → `cognitive-capture-fragment`
5. Ask your own documents: **"Based on my documents, what do I think about [topic]?"** → `cognitive-ask`

---

## The 13 Skills / 13 种操作技能

### Initial Construction (5 modes) — building the structure

| Skill | Cognitive Science | What it does |
|---|---|---|
| `cognitive-capture-fragment` | Episodic memory externalization | Captures ideas as L2 fragments with attribution |
| `cognitive-integrate-fragments` | Piaget Assimilation/Accommodation | Integrates fragments into L1 (Homunculus mechanism) |
| `cognitive-update-knowledge` | Controlled semantic memory update | Directly updates L1 with ceremony(K) protocol |
| `cognitive-extract-principle` | DMN incubation → Schema formation | Distills cross-domain patterns into L1.5 principles |
| `cognitive-reorganize` | Memory system initialization | Classifies existing documents into 4-axis framework |

### Iterative Evolution (7 modes) — keeping it fresh

| Skill | Cognitive Science | What it does |
|---|---|---|
| `cognitive-detect-contradiction` | ViolEx 2.0 schema violation | Finds and resolves 5 types of contradictions |
| `cognitive-consistency-check` | Flavell metacognitive monitoring | Runs C1-C13 consistency validation |
| `cognitive-self-reflect` | Reflection vs. Rumination | Guided deep reflection with anti-rumination detection |
| `cognitive-ask` | Semantic memory retrieval | Answers questions strictly from your own documents |
| `cognitive-daily-briefing` | Episodic memory update review | Generates daily cognitive status report |
| `cognitive-review-brain-map` | Metacognitive snapshot | Shows current state of your cognitive structure |
| `cognitive-version-snapshot` | Long-term memory consolidation | Creates milestone snapshots of L1 documents |
| `cognitive-input-classifier` | Input routing | Classifies ambiguous inputs before acting |

### The 4 Subagents / 4 个子智能体

| Agent | Role | Isolation Value |
|---|---|---|
| `cognitive-verifier` | Read-only post-update consistency check | Independent "reader" perspective, no author bias |
| `cognitive-fragment-integrator` | Batch integrator for ≥5 fragments | Pure homunculus perspective, uncontaminated by capture history |
| `cognitive-cascade-notifier` | Async spreading activation notifier | Background, non-blocking principle propagation |
| `cognitive-task-reflector` | Post-task cognitive extraction | Extracts insights from task logs without operation detail noise |

### The 4 Rules / 4 条规则（始终生效）

| Rule | Always-On | What it enforces |
|---|---|---|
| `cognitive-structure-write-guard` | Yes (conditional) | Before writing L1/L1.5: backup + attribution + 5 cascade writes |
| `cognitive-l3-auto-log` | Yes (alwaysApply) | After every cognitive-* op: auto-append system log |
| `cognitive-principle-check` | Yes (conditional) | After writing L1 content: check tension with P1/P2 |
| `fragment-before-direct-edit` | Yes (conditional) | Before editing L1: ask "fragment first or direct edit?" |

---

## Example Interactions / 使用示例

```
# Capture a new insight
"I just realized that every time I design a system under pressure, I skip validation. Record this."
→ cognitive-capture-fragment: stores as L2 fragment with attribution, checks for duplicates

# Integrate accumulated insights
"I have 7 fragments pending. Integrate them."
→ cognitive-integrate-fragments: applies Piaget assimilation/accommodation to each

# Ask your own knowledge
"Based on my documents, what's my view on product-market fit?"
→ cognitive-ask: searches L1.5→L1→L2, returns answer with citations, confidence, gaps

# Daily briefing
"What's my cognitive status today?"
→ cognitive-daily-briefing: shows changes since last session, pending items, suggested priorities

# Detect contradictions
"Check if my product theory and organization theory documents are consistent."
→ cognitive-detect-contradiction: finds 5 types, proposes resolution options

# Extract a principle
"I keep seeing the same pattern across my notes. Extract the principle."
→ cognitive-extract-principle: requires ≥3 cross-domain examples, challenges with counter-examples
```

---

## Formal Foundation / 形式化基础

The entire system is derived from 3 axioms (see `cognitive/L1_knowledge/formal_spec/`):

整套系统从 3 条公理推导而来：

```
Axiom A1: An agent receives inputs, executes operations, produces outputs.
Axiom A2: The agent's behavior at time t is fully determined by its internal object set at t.
Axiom A3: The same agent can have different internal object sets at different times.
```

From these axioms, the minimum infrastructure for self-evolution is: **{R, M, G}**:
- **R** (Registry): complete observability — all objects registered (= fragment index + knowledge graph)
- **M** (Modifier): controlled modification — formal ceremony protocol (= write-guard + change logs)
- **G** (Gap detector): self-sensing gaps (= cascade-notifier + task-reflector)

---

## References / 参考文献

1. Tulving, E. (1972). Episodic and semantic memory. *Organization of memory*, 1, 381-403.
2. Squire, L. R., & Zola-Morgan, S. (1993). The medial temporal lobe memory system. *Science*, 253(5026).
3. Flavell, J. H. (1979). Metacognition and cognitive monitoring. *American psychologist*, 34(10), 906.
4. Piaget, J. (1952). *The origins of intelligence in children*. International Universities Press.
5. Collins, A. M., & Loftus, E. F. (1975). A spreading-activation theory of semantic processing. *Psychological review*, 82(6), 407.
6. Wallas, G. (1926). *The art of thought*. Harcourt, Brace and Company.
7. Treynor, W., et al. (2003). Rumination reconsidered. *Cognitive therapy and research*, 27(3), 247-259.
8. Gawronski, B., & Brannon, S. M. (2022). What is cognitive consistency? *Dual-process theories of the social mind*.

---

## License / 许可证

MIT License — free to use, modify, and distribute.

---

## Contributing / 贡献

Issues and PRs welcome. If you find the system works well for your use case, consider sharing:
- Your domain structure under `L1_knowledge/`
- New Skills you've created
- Examples of successful principle extraction

---

*cognitive-os v1.0 | Built on cognitive science. Designed for AI agents.*
