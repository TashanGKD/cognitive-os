<!-- Logo -->
<p align="center">
  <strong>cognitive-os · Cognitive Operating System</strong><br>
  <em>AI-native Knowledge Externalization for Cursor Agents</em>
</p>

<p align="center">
  <a href="#what-is-this">What is this</a> •
  <a href="#cognitive-science-foundation">Science</a> •
  <a href="#architecture">Architecture</a> •
  <a href="#13-skills">Skills</a> •
  <a href="#installation">Install</a> •
  <a href="README.md">中文</a>
</p>

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Skills](https://img.shields.io/badge/Skills-13-blue)](#13-skills)
[![Rules](https://img.shields.io/badge/Rules-4-green)](#4-rules)
[![Agents](https://img.shields.io/badge/SubAgents-4-purple)](#4-subagents)
[![Deep Dive](https://img.shields.io/badge/Deep_Dive-With_Diagrams-teal)](docs/article/cognitive-science-deep-dive.html)

> Externalize the human brain's layered memory structure into an AI-operable knowledge system.

---

> 📖 **Deep Dive Article**: [**"Externalizing the Layered Brain: A Neuroscience Deconstruction of an AI Cognitive System"**](docs/article/cognitive-science-deep-dive.md)
> Step-by-step mapping of each Skill to cognitive science theory, with 10 original diagrams (Piaget assimilation/accommodation, ViolEx contradiction model, Wallas 4-stage incubation, spreading activation…)
> 📎 [Full HTML version with embedded images (12MB)](docs/article/cognitive-science-deep-dive.html) 13 Skills + 4 Rules + 4 SubAgents that let AI agents **build, maintain, and self-evolve** your cognitive framework — grounded in 50+ years of cognitive science.

---

## What Is This

**cognitive-os solves one fundamental problem:**

> **Your best thinking is trapped inside your head — fragmented, inconsistent, inaccessible to AI agents.**

| Problem | Symptom | Solution |
|---------|---------|----------|
| AI doesn't know how you think | Every time you ask AI its opinion, it answers from training data, not your judgment | Externalize your cognitive framework; AI answers based on **your documents** |
| Insights stay in your head | Good thoughts not recorded, or recorded but lost | Fragment capture mechanism, structured storage in layered knowledge system |
| Knowledge system is inconsistent | Documents from different periods contradict each other | Contradiction detection + version control + consistency validation, C1-C13 conditions |
| Experience can't self-evolve | AI starts from zero every conversation, no accumulation | Cascade notification + task extraction, cognitive system auto-updates with every task |

---

## Cognitive Science Foundation

This system's architecture **strictly mirrors** the human brain's actual memory hierarchy (empirically validated neuroscience, not metaphor):

| System Layer | File Location | Brain Equivalent | Theory |
|---|---|---|---|
| **L0** Brain Map | `cognitive/L0_brain_map.md` | Metacognition | Flavell (1979) |
| **L1.5** Principles | `cognitive/L1.5_principles/` | Schema / Mental Model | Piaget (1952) |
| **L1** Knowledge | `cognitive/L1_knowledge/` | Semantic Memory | Squire & Zola-Morgan (1993) |
| **L2** Fragments | `cognitive/L2_fragments/` | Episodic→Semantic transition | Hippocampal-neocortical dialogue |
| **L3** Logs | `cognitive/L3_logs/` | Episodic Memory | Tulving (1972) |

---

## Architecture

```
L0 Brain Map (Metacognition)
    ↕ constrains / distills
L1.5 Principles (Schema — the cognitive OS)
    ↕ constrains / distills
L1 Systematic Knowledge (Semantic Memory)
    ↕ Homunculus integration mechanism (Piaget Assimilation/Accommodation)
L2 Fragment Thinking (Episodic→Semantic transition)
    ↓ full record
L3 Raw Logs (Episodic Memory)
```

---

## 13 Skills

### Initial Construction (5 modes)

| Skill | Trigger | Function | Theory |
|-------|---------|----------|--------|
| `cognitive-capture-fragment` | fragment / record this / new insight | Captures ideas as L2 fragments with attribution | Episodic externalization |
| `cognitive-integrate-fragments` | integrate fragments / process backlog | Integrates L2→L1 via Homunculus (assimilation/accommodation/covered) | Piaget equilibration |
| `cognitive-update-knowledge` | update [doc] / modify [doc] | Controlled L1 update: backup→attribution→contradiction check→5 cascade writes | ceremony(K) protocol |
| `cognitive-extract-principle` | extract principle / find patterns | Distills cross-domain principles into L1.5 (requires ≥3 domain evidence) | DMN schema formation |
| `cognitive-reorganize` | reorganize cognitive structure / structure is messy | Builds structure from scratch using 4-axis classification | Memory initialization |

### Iterative Evolution (8 modes)

| Skill | Trigger | Function | Theory |
|-------|---------|----------|--------|
| `cognitive-detect-contradiction` | contradiction / inconsistent | 5-type contradiction detection + ViolEx defense mode tracking (C13) | ViolEx 2.0 |
| `cognitive-consistency-check` | consistency check / validate | C1-C13 full consistency validation | Flavell metacognitive monitoring |
| `cognitive-self-reflect` | reflect / I notice I have a habit | 10+ rounds, 5-dimension deep reflection with rumination detection | Treynor (2003) |
| `cognitive-ask` | based on my documents / remind me | Answers strictly from your own documents with citations and confidence | Semantic retrieval |
| `cognitive-daily-briefing` | briefing / what's new today | Daily cognitive system status report | Episodic memory review |
| `cognitive-review-brain-map` | brain map / cognitive status | Current state snapshot of your cognitive structure | Metacognitive snapshot |
| `cognitive-version-snapshot` | create new version / major change | Creates milestone snapshots for L1 documents | Memory consolidation |
| `cognitive-input-classifier` | classify this input / route first | Routes ambiguous input before acting | Pre-routing |

---

## 4 SubAgents

| SubAgent | Function | Isolation Value |
|---------|----------|-----------------|
| `cognitive-verifier` | Post-update consistency check (CV-1/2/3) | Independent "reader" perspective, no author bias |
| `cognitive-fragment-integrator` | Batch integration for ≥5 fragments | Pure homunculus perspective, uncontaminated by capture history |
| `cognitive-cascade-notifier` | Async spreading activation after principle/L1 updates | Background, non-blocking, spreading activation equivalent |
| `cognitive-task-reflector` | Post-task cognitive value extraction | Detached from operation details, "cognitive maintainer" perspective |

---

## 4 Rules

| Rule | Type | Function |
|------|------|----------|
| `cognitive-structure-write-guard` | Conditional | Before writing L1/L1.5: backup + attribution + 5 cascade writes |
| `cognitive-l3-auto-log` | alwaysApply | After every cognitive-* op: auto-append system log |
| `cognitive-principle-check` | Conditional | After writing L1 content: check tension with P1/P2 |
| `fragment-before-direct-edit` | Conditional | Before editing L1: prompt "fragment first or direct edit?" |

---

## Installation

### Option 1: `ai-agent-skills` CLI (recommended)

```bash
npx ai-agent-skills install TashanGKD/cognitive-os

# Then initialize your cognitive structure:
./scripts/setup.sh
```

### Option 2: Cursor Built-in GitHub Import

1. Open Cursor Settings (`Cmd+Shift+J`)
2. Go to **Rules** → **Add Rule** → **Remote Rule (Github)**
3. Enter: `https://github.com/TashanGKD/cognitive-os`
4. Restart Cursor

### Option 3: Manual Clone

```bash
git clone https://github.com/TashanGKD/cognitive-os.git

cp -r cognitive-os/skills/* your-project/.cursor/skills/
cp -r cognitive-os/rules/* your-project/.cursor/rules/
cp -r cognitive-os/agents/* your-project/.cursor/agents/

cd cognitive-os && ./scripts/setup.sh /path/to/your-project
```

---

## Quick Start

```
# Initialize your cognitive structure
"Help me organize my cognitive structure"
→ cognitive-reorganize guides you through 4-axis classification

# Capture a new insight
"Fragment: I notice I skip validation when under pressure"
→ cognitive-capture-fragment writes to L2 with proper attribution

# Ask your own knowledge
"Based on my documents, what's my core view on product design?"
→ cognitive-ask retrieves from your L1/L1.5/L2, with citations and confidence

# Daily briefing
"What's new in my cognitive system today?"
→ cognitive-daily-briefing generates backlog/updates/action items
```

---

## References

1. Tulving, E. (1972). Episodic and semantic memory.
2. Squire, L. R., & Zola-Morgan, S. (1993). The medial temporal lobe memory system.
3. Flavell, J. H. (1979). Metacognition and cognitive monitoring.
4. Piaget, J. (1952). The origins of intelligence in children.
5. Collins, A. M., & Loftus, E. F. (1975). A spreading-activation theory of semantic processing.
6. Wallas, G. (1926). The art of thought.
7. Treynor, W., et al. (2003). Rumination reconsidered.
8. Gawronski, B., & Brannon, S. M. (2022). What is cognitive consistency?

---

## License

MIT License. See [LICENSE](LICENSE) for details.
