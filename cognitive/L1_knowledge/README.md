# L1 Knowledge — Systematic Knowledge Layer

> **Layer**: L1 (Semantic Memory equivalent)
> **Nature**: Stable, time-independent systematic documents — your core knowledge frameworks
> **Cognitive Science Basis**: Semantic Memory (Squire & Zola-Morgan, 1993) — facts and concepts detached from specific time/place

---

## How to Organize This Folder

Create one subfolder per knowledge domain. Examples:

```
L1_knowledge/
├── product_theory/          ← Product design principles, business frameworks
├── org_design/              ← Organization, collaboration models
├── research_methodology/    ← Research approaches, experimental design
├── technical_systems/       ← System architecture, engineering principles
├── cognitive_science/       ← Mind, learning, decision-making
├── personal_methodology/    ← Your personal thinking/working methods
└── formal_spec/             ← Formal specifications (optional)
    └── self_evolving_agent_spec.md
```

## What Belongs in L1

✅ **Belongs here:**
- Frameworks you've built through thinking (not just researched)
- Principles you've validated across multiple contexts
- System-level understanding you've developed
- Concepts that remain stable over time

❌ **Does NOT belong here:**
- Work-in-progress project documents → put in `projects/`
- Raw fragments/ideas not yet systematized → put in `L2_fragments/`
- Time-stamped event records → put in `L3_logs/`
- External research you haven't processed → use REF-EXT format in `references/` subfolder

## Document Metadata Header Template

Every L1 document should start with:

```markdown
> **Cognitive Structure Metadata**
> Layer: L1 (Systematic Document)
> Domain: [your domain name]
> Document Relationships:
>   - depends_on: [other L1 doc] (if applicable)
>   - extends: [other L1 doc] (if applicable)
> L1.5 Constraints: P1 / P2 (which principles apply)
> Attribution: 🔵 Original thinking / 🟢 AI-organized / 🟡 AI-generated
> Imported: YYYY-MM-DD
> Status: ★ CURRENT
> Version: v1.0
```

## Getting Started

1. Think about your main areas of knowledge/expertise
2. Create a subfolder for each domain
3. Move or create your first systematic document in that folder
4. Use `cognitive-reorganize` Skill to classify any existing documents
5. Use `cognitive-update-knowledge` Skill for controlled updates

---

*v1.0 | Template | cognitive-os*
