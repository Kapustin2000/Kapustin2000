# AI Navigation Guide — Kapustin2000 Profile

This document describes how an AI agent should traverse this repository.

## Entry Point

Start with `graph.yaml`. It contains every entity, its type, date, and relations in one machine-readable file.

```yaml
companies:
  - id: woolf
    period: 2025-04 - 2025-09
    relations:
      projects: [ai-cv-matcher]
      publications: [mvp-llm-agent-adk, ...]
```

## Navigation Protocol

```
graph.yaml ──→ pick entity ──→ entity/meta.yaml ──→ entity/README.md
                              (structured data)    (human narrative)
```

### Step 1: `_graph_/graph.yaml`
- Understand the full scope: person, companies, projects, publications, conferences, education
- Follow `relations` to discover connections between entities
- Use `concepts.yaml` to understand the intellectual architecture (consciousness → AI → education → economy)
- Use dates to build timelines

### Step 2: `<section>/<entity>/meta.yaml`
- Get structured fields: stack, location, period, relations
- Follow `relations` to traverse to connected entities

### Step 3: `<section>/<entity>/README.md`
- Read human context: achievements, descriptions, cross-links

## Section Indexes

Each top-level section has its own `meta.yaml` with navigation:

| Section | Index | Child Entities |
|---------|-------|----------------|
| experience | `experience/meta.yaml` | companies with periods |
| projects | `projects/meta.yaml` | projects with status |
| publications | `publications/meta.yaml` | articles across categories |
| conferences | `conferences/meta.yaml` | conferences |
| skills | `skills/meta.yaml` | skill categories |
| education | `education/meta.yaml` | education entries |

## Schema

`_schema_.yaml` defines all entity types and their required/optional fields:

```yaml
company:
  required: [id, type, name, role, period]
  optional: [location, stack, relations]
```

## Relation Types

- `company → projects`: projects built during this role
- `company → publications`: articles written during this role
- `project → company`: where it was built
- `conference → publications`: articles about the event
- All relationships are mirrored in `graph.yaml` under `relations`

## Query Patterns

| Question | Path |
|----------|------|
| What did this person work on? | `graph.yaml` → all companies + projects |
| What was built at company X? | `companies[].relations.projects` |
| What was written at company X? | `companies[].relations.publications` |
| Full detail on entity Y | `entity/meta.yaml` + `entity/README.md` |
| Timeline of all activity | `timeline.md` |
| Tech stack evolution | `experience/README.md` → Skills Evolution section |
