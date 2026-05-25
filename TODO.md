# TODO — Profile Polish

## README (main)
- [ ] Grand narrative — one sentence tying together research, AI, education, consciousness
- [ ] Expand bio section (currently 2 lines)
- [ ] Add reference to TODO.md in navigation

## Experience
- [x] Locations filled for all companies
- [x] Duration added to ASRP header
- [x] Provectus expanded (reference letter, stack, concrete facts)
- [ ] Expand thin entries: PHP-academy, SuperMediaAds, Top Agent — if reference letters or facts exist
- [ ] Verify stacks for PHP-academy, Top Agent, SuperMediaAds (PHP only?)

### Ideas
- [x] Location column added to All Roles table
- [x] Duration column added to All Roles table
- [x] Concurrent roles indicated (LAB325 + MOB.325 footnote)
- [ ] Add Prev / Next navigation between company pages

## Projects
- [x] Cross-link Projects → Experience (all have "Developed at")
- [x] Cross-link Experience → Projects (7/11 companies have "Related Projects")
- [x] Create project pages for ASRP.science, ASRP.tech (ecosystem), and GFS
- [x] Scrape ASRP.tech website — done, extracted full product catalog and chronology

### Ideas
- [ ] Add featured projects with preview images to `projects/README.md`

## Publications
- [x] Add read counts to all 10 technical article READMEs
- [x] Add platform stats (Medium, Habr, Hashnode) to meta.yaml
- [x] Add By Reach table to `publications/README.md`

## Skills
- [x] Skills page redesigned with Used At column + Experience Summary
- [ ] Link skills to specific projects/experience (optional)

## General
- [x] Reference letters added (HYS, Coelix, LAB325, MOB.325, Provectus)
- [x] Timeline page created with clickable links
- [x] about/ page removed (was stub)

### AI Knowledge Graph
- [x] Create `graph.yaml` — machine-readable schema of all entities
- [x] Create `concepts.yaml` — intellectual architecture (Consciousness → Lucid dreaming → AI agents → Education → Economy)
- [x] AI navigation layer designed (graph.yaml → meta.yaml → README.md)
- [ ] Add `_meta.md` to each image folder — describes what the image shows and context

### Structured Data (YAML frontmatter)
- [x] `meta.yaml` added to all entities
- [x] `status` field added to all projects and articles
- [x] `read_count` + `stats` added to technical article meta.yaml
- [x] `_schema_.yaml` created
- [x] Folder-per-item structure intact
- [x] No static site generators — pure YAML + Markdown

### Narrative & Architecture
- [x] Create Concept Graph — done in `_graph_/concepts.yaml`
- [ ] Define and add grand narrative to README

## Done
- [x] All 14 project pages (was 11, added asrp.tech, asrp.science, gfs)
- [x] All experience pages — consistent template, no emojis
- [x] Bidirectional project ↔ company cross-references
- [x] Timeline links — all entries clickable
- [x] Experience → Publications cross-links
- [x] Publications → Experience cross-links
- [x] Links consistent (no .md extensions)
- [x] Navigation consistent across all pages
- [x] Conferences & publications sorted by date descending
- [x] Meta reference links on all entity READMEs
