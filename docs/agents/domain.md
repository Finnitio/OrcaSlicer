# Domain Docs

How the engineering skills should consume this repo's domain documentation when exploring the codebase.

## Before exploring, read these

- **`.agent/CONTEXT.md`** (the glossary)
- **`.agent/docs/adr/`**: read ADRs that touch the area you're about to work in.

If any of these files don't exist, **proceed silently**. Don't flag their absence; don't suggest creating them upfront. The `/domain-modeling` skill (reached via `/grill-with-docs` and `/improve-codebase-architecture`) creates them lazily when terms or decisions actually get resolved. In this repo, always create and edit them under `.agent/` (not the repo root), since `.agent/` holds the fork-local agent docs.

## File structure

Single-context, kept under `.agent/`:

```
.agent/
├── CONTEXT.md
├── docs/adr/
│   ├── 0001-event-sourced-orders.md
│   └── 0002-postgres-for-write-model.md
└── docs/agents/
```

## Use the glossary's vocabulary

When your output names a domain concept (in an issue title, a refactor proposal, a hypothesis, a test name), use the term as defined in `.agent/CONTEXT.md`. Don't drift to synonyms the glossary explicitly avoids.

If the concept you need isn't in the glossary yet, that's a signal: either you're inventing language the project doesn't use (reconsider) or there's a real gap (note it for `/domain-modeling`).

## Flag ADR conflicts

If your output contradicts an existing ADR, surface it explicitly rather than silently overriding:

> _Contradicts ADR-0007 (event-sourced orders), but worth reopening because…_

## OrcaSlicer specifics

- Upstream design docs live in `docs/HLSD/<subsystem>.md`. Read the relevant one before working in a subsystem.
- `.agent/CONTEXT.md` and `.agent/docs/adr/` are fork-local (orphan branch `agent-config`, excluded from the main checkout). Never commit them or reference them in upstream code, docs or PRs. A design worth upstreaming belongs in `docs/HLSD/`, per `AGENTS.md`.
