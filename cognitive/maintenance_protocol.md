# Cognitive Structure Maintenance Protocol

> **Version**: v1.0
> **Nature**: System-level maintenance specification — defines consistency conditions, change propagation rules, validation processes
> **Authority**: All cognitive-* Rules and Skills must not violate this protocol

---

## 零、Structural Requirements (Invariants)

### 0.1 L0 Must Have Visual Framework Diagram
L0 Brain Map must contain a framework diagram showing all cognitive layers and their relationships.
**Violation**: if L0 lacks this diagram, C1 fails immediately.

### 0.2 Version Snapshots + Change Log
Every L1 document must maintain version history:
```
historical_versions/[doc_name]_v1.0_YYYYMMDD.md    ← created at initial import / major rewrite
[doc_name]_changes.md                               ← append for each modification between x.0 versions
```

### 0.3 Version Status Values

| Symbol | Meaning | Usage |
|---|---|---|
| **★ CURRENT** | Imported into cognitive structure, is the authoritative version | Update after migration |
| **◑ PENDING** | Identified, queued for migration (no active deferral) | Default after identification |
| **⏸️ DEFERRED** | Actively deferred: decided not to migrate yet | Format: `⏸️ DEFERRED (reason: xxx, plan: xxx)` |
| **○ DUPLICATE** | Authoritative version exists in cognitive structure, this is origin archive | Add redirect annotation first |
| **□ SUPERSEDED** | Replaced/integrated, demoted to history | When superseded by newer version |
| **✗ OUT** | Not personal cognition, excluded | Pure engineering files/credentials etc. |
| **❓ UNCLEAR** | Nature pending confirmation | Temporary, must not persist |

---

## 一、Consistency Conditions (C1-C13)

All 13 conditions satisfied = system is in consistent state.

| ID | Condition | Verification Method |
|---|---|---|
| **C1** | **L0 Completeness**: All docs listed in L0 actually exist | Enumerate L0 paths, check file existence |
| **C2** | **L0 Currency**: Each doc's status in L0 reflects reality | Compare L0 status with actual file modification times |
| **C3** | **Knowledge Graph Completeness**: Graph covers all ★ CURRENT L1 docs | Count L1 dir docs vs graph nodes |
| **C4** | **Fragment Index Completeness**: Index covers all L2 docs | Enumerate L2 dir files vs index entries |
| **C5** | **Catalog Accuracy**: Migrated→★; actively deferred→⏸️; queued→◑ | Row-by-row comparison |
| **C6** | **DUPLICATE Annotation**: All docs with authoritative version elsewhere have redirect annotation | Check each DUPLICATE doc's first line |
| **C7** | **System Log Completeness**: Every important operation in system log | Cross-check operation history vs log entries |
| **C7+** | **Version Control**: Each L1 doc has v1.0 snapshot and changes file | Check for historical_versions/ and _changes.md |
| **C8** | **L1.5 Constraint Consistency (optional)**: L1 content not contradicting confirmed principles | Run cognitive-detect-contradiction against P1/P2 |
| **C9** | **Relationship Edge Annotations (optional)**: Graph edges have corresponding annotations in doc metadata | Sample 5-10 edges, verify doc headers |
| **C10** | **Todo Currency**: Completed items marked ✅ | Row-by-row check of todo.md |
| **C11** | **No Orphan Directories**: No directories outside L0/L1/L1.5/L2/L3 hierarchy | Enumerate cognitive/ root subdirectories |
| **C12** | **Skill-Theory Alignment**: All cognitive-* Skills contain cognitive science annotations | Scan .cursor/skills/cognitive-*/SKILL.md for theory references |
| **C13** | **Defensive Skip Tracking**: Same document pair contradiction skipped ≥3 times triggers alert | Scan consistency_record.md for [SKIP-JUDGMENT] |

---

## 二、Change Propagation Rules

### When Adding a New L1 Document
```
Must execute (all, no skipping):
  → Add cognitive structure metadata header to doc
  → Add redirect annotation at original location (if any)
  → Update L0 Brain Map (add entry to corresponding domain)
  → Update knowledge_graph.md (add node + relationship edges)
  → Update document_catalog.md (status → ★ CURRENT)
  → Append to L3/system_log.md (one line record)
  → [Optional] Check doc against existing L1.5 principles (C8)
```

### When Modifying a L1 Document
```
Must execute:
  → Append to [doc_name]_changes.md (date/type/content/reason)
  → Create historical version backup (copy to historical_versions/)
  → Run contradiction detection (cognitive-detect-contradiction)
  → Update L0 Brain Map (last updated time)
  → Append to L3/system_log.md
```

### When Adding a New L1.5 Principle
```
Must execute:
  → Update L1.5_principles/principles.md (with cross-domain evidence, status=✅)
  → Update L0 Brain Map (L1.5 section)
  → Check all L1 docs against new principle (C8)
  → Append to L3/system_log.md
  → In related L2 fragments: fill in "corresponding L1.5 principle" field
```

### When Adding a New L2 Fragment
```
Must execute:
  → Append new row to L2_fragments/fragment_index.md (ID/title/type/related_L1/L1.5_principle/status/time)
  → Run L1.5 pattern matching
  → Append to L3/system_log.md
```

---

## 三、Consistency Validation Process

```
Step 1  Enumerate all L1 docs in cognitive structure
        → Compare against L0 records (validate C1/C2)
        → Compare against knowledge graph nodes (validate C3)
        → Compare against document catalog status (validate C5)

Step 2  Enumerate all L2 docs
        → Compare against fragment index (validate C4)

Step 3  Check system log
        → Confirm all known operations have log entries (validate C7)

Step 4  Check todo list
        → Confirm completed items marked ✅ (validate C10)

Step 5  [Optional, time-consuming]
        → Run cognitive-detect-contradiction on all L1 docs (validate C8)
        → Check knowledge graph edges vs doc metadata annotations (validate C9)

Validation output:
  → Each condition: ✅ Pass / ⚠️ Partial (list specifics) / ❌ Fail
  → Summary: System consistent / partially inconsistent (N issues) / seriously inconsistent
```

---

## 四、Maintenance Cycle

| Trigger | Action |
|---|---|
| Any single doc operation | Corresponding change propagation rules (Section 二) |
| After any batch operation | Full consistency validation (Section 三, Steps 1-4) |
| Weekly scheduled | Full validation (Section 三, Steps 1-5) |
| Any suspected contradiction | Immediately run cognitive-detect-contradiction |

---

*v1.0 | Template | cognitive-os*
