# CLAUDE.md

Guidance for navigating this repository (Kapustin2000/Kapustin2000 — GitHub profile README plus structured content about Mykhailo Kapustin: work experience, projects, publications, education, conferences, skills).

## What this repo is

Not a codebase — a personal knowledge base rendered as a GitHub profile. Every top-level folder is an entity category (`experience/`, `projects/`, `publications/`, `education/`, `conferences/`, `skills/`, `cvs/`, `work-authorization/`). Each entity lives in its own subfolder with a machine-readable `meta.yaml` (structured fields, relations to other entities) and a human-readable `README.md` (narrative, achievements, cross-links).

## How to navigate

Start at `_graph_/graph.yaml` — it lists every entity, its type, date, and relations in one file. Then follow the protocol documented in `_graph_/GUIDE.md`:

```
graph.yaml ──→ pick entity ──→ entity/meta.yaml ──→ entity/README.md
                              (structured data)    (human narrative)
```

Read `_graph_/GUIDE.md` before doing any nontrivial lookup or cross-referencing task — it has the full query patterns (e.g. "what was built at company X", "timeline of all activity") and the section-index map. `_schema_.yaml` defines every entity type's required/optional fields if you need to check what a `meta.yaml` should contain.

For quick orientation without touching the graph, `README.md` at the root has the same section list a human visitor sees.

## Task playbooks

- **Adding a publication** (article, research paper, media mention) — see [`publications/CONTRIBUTING.md`](publications/CONTRIBUTING.md). It has the folder structure, `meta.yaml` schema, and the full list of aggregator files that must be updated in sync.

## Conventions

- Only commit when explicitly asked to.
- Validate any `meta.yaml` you touch: `python3 -c "import yaml; yaml.safe_load(open('path/to/meta.yaml'))"`.
- Run `git status --short` before committing to confirm only intended files changed.
