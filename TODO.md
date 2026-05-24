# TODO — Profile Polish

## README (main)
- [ ] Expand bio section (currently 2 lines)
- [ ] Add reference to TODO.md in navigation

## Experience

- [ ] Fill in location for ASRP, LAB325, MOB.325, Provectus, Ephyros, Woolf
- [ ] Verify stacks for Provectus, PHP-academy, SuperMediaAds, Top Agent (PHP only?)
- [ ] Expand thin entries (Provectus, PHP-academy, SuperMediaAds) with concrete facts/metrics
- [ ] Add duration to ASRP header
- [ ] Add `reference.md` for companies with reference letters (Coelix, HYS, PHP-academy, ...)
- [ ] Enrich Impact column with metrics (optional)

### Ideas
- Index: add Location column
- Index: add Duration column
- Index: visually indicate concurrent roles (LAB325 + MOB.325 ran in parallel)
- ASRP: link to live products (arcanum12th.education, asrp.media)
- Cross-link Experience → Publications by company
- Add Prev / Next navigation between company pages

## Projects

- [ ] Cross-link Projects → Experience (done: all 11 have "Developed at")
- [ ] Cross-link Experience → Projects (done: 7/11 companies have "Related Projects")
- [ ] Create project pages for ASRP.science and ASRP.tech
- [ ] Scrape ASRP.tech website to extract all activities, products, and research — add to ASRP project descriptions

### Ideas
- Add featured projects with preview images to `projects/README.md`

## Publications

### Ideas
- Link publications to companies (which articles were written at which company)
- Add read counts (38K, 10K, 7.5K, etc.) to article READMEs

## Skills

### Ideas
- Group by proficiency: Expert / Proficient / Familiar
- Link skills to specific projects/experience

## General

- [x] Add reference letters from former colleagues (12 recommendations + PDFs across HYS, LAB325, MOB.325, Coelix, Provectus)
- [x] Create timeline page (work + projects + publications + conferences in chronological order)

### AI Knowledge Graph

- [ ] Create `graph.yaml` — machine-readable schema of all entities (companies, projects, publications, conferences) with relations and dates
- [ ] Add `_meta.md` to each image folder — describes what the image shows, its context, and how it relates to other entities
- [ ] Design AI navigation layer: a graph view of everything — what was done, when, and how it connects

### Structured Data (YAML frontmatter)

- [ ] Add YAML frontmatter (`id`, `type`, `date`, `tags`, `relations`) to all entity READMEs — Person, Company, Project, Article, Conference, Course
- [ ] Add `status` field to projects (idea / in-progress / completed) and articles (draft / published / archived)
- [ ] Add `evidence` field — link back to source GitHub pages for verifiability
- [ ] Create `_schema_.yaml` — canonical entity type definitions with required fields
- [ ] Keep folder-per-item structure intact (no flat renaming, no date prefixes)
- [ ] No static site generators, no graph databases — pure YAML + Markdown

### Narrative & Architecture

- [ ] Define and add **grand narrative** to README — one sentence tying together research, AI, education, consciousness
- [ ] Separate layers in entity pages: narrative (why) / semantic links (relations) / evidence (proof) / timeline (evolution)
- [ ] Create **Concept Graph** in `_graph_/concepts.yaml` — intellectual architecture (Consciousness → Lucid dreaming → AI agents → ASRP)
- [ ] Add **temporal evolution** to each entity — not just dates, but how it evolved over time
- [ ] Ensure every claim/achievement has an **evidence** backlink (article, repo, PDF, talk, demo, screenshot)

## Done

- [x] All 11 project pages — full descriptions
- [x] All 11 experience pages — consistent template, no emojis
- [x] Bidirectional project ↔ company cross-references
- [x] Skills and education migrated to folders
- [x] GitHub stats added to README
- [x] Links consistent across all pages (no .md extensions)
- [x] ← Back to Profile / ← All Projects / ← All Experience consistent everywhere
- [x] Conferences sorted by date descending
- [x] Publications sorted by date descending
