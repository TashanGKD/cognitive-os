# Core Principles Library (L1.5 — Schema Layer)

> **Layer**: L1.5 (Schema / Mental Model Layer)
> **Neuroscience basis**: Schema / Mental Model
> **Nature**: Cross-topic applicable core thinking habits — the "operating system" of cognition
> **Generation**: Distilled from L2 fragments by finding cross-domain patterns, confirmed by user
> **Last Updated**: [DATE]

---

## 一、Confirmed Principles

### ✅ P1: Verify Before Feeling

**Formal Statement:**
> Do not substitute subjective feeling for objective verification. Feelings are immediate and subjective; verification is delayed and objective. Before verification results appear, feelings will lead you astray.

**Cross-domain Evidence:**

| Domain | Manifestation | Source |
|---|---|---|
| Self-behavior | Premature generalization driven by "feels right" — applying a method before validation | Add your example |
| Product judgment | Cannot judge product direction by current feeling alone; needs objective validation | Add your example |
| Technical design | AI systems must have objective validation mechanisms, not just subjective quality judgment | Add your example |

**Skill Implementation** (P1 execution layer — C12 validation anchor):
- `cognitive-capture-fragment` attribution system 🔵🟢🟡: distinguishes verified from felt
- `cognitive-structure-write-guard` (Rule): content must have attribution, no evidence-free writes
- `cognitive-verifier` (Subagent): CV-2 checks new content doesn't violate P1

---

### ✅ P2: Start Small, Ask "Why", Elevate to Underlying Pattern

**Formal Statement:**
> Do not start from a grand universal framework. Start from one specific small point. Repeatedly ask "why" and "what's the common pattern here?" Iteratively spiral upward until finding a cross-domain universal underlying pattern.

**Cross-domain Evidence:**

| Domain | Example | Source |
|---|---|---|
| Thinking method | Start from one concrete phenomenon → ask why repeatedly → elevate to universal principle | Add your example |
| Problem analysis | From a specific question → elevate to cross-domain framework | Add your example |

**Operational Steps:**
```
Step 1  Find a specific small point (problem/phenomenon/confusion)
Step 2  Describe it (write it down, even if incomplete)
Step 3  Ask: does this have larger value? What other situations share this pattern?
Step 4  Elevate one dimension, find a more universal statement
Step 5  Repeat Steps 2-4, ~10 minutes per round
Step 6  Stop when: found cross-domain universal pattern, or existing theory already covers it
```

**Skill Implementation:**
- `cognitive-extract-principle`: starts from specific evidence (not conclusions), requires 3 cross-domain validations
- Internal constraint in `session-bootstrap` A1.5: retreat when jumping directly to macro framework

---

## 二、Candidate Principles (Under Observation)

> Add candidate principles here as you discover cross-domain patterns.
> Confirm only after ≥3 independent domain validations.

| ID | Candidate Statement | Evidence Found | Status |
|---|---|---|---|
| P3? | [Your candidate principle] | [1-2 examples] | 🟠 Under observation |

---

## 三、Principle Relationships

```
P1 "Verify before feeling"
    ↕ P1 constrains P2
P2 "Start small, elevate"
    At each elevation, P1 still applies:
    "Feeling like I've reached the underlying pattern" ≠ "verified at underlying pattern level"
```

---

## 四、Known Priority Conflicts Between Candidate Principles

| Principle A | Principle B | Conflict Scenario | Arbitration | Basis |
|---|---|---|---|---|
| (Add conflicts discovered via cognitive-detect-contradiction E-type) | | | | |

---

*v1.0 | Template | cognitive-os*
