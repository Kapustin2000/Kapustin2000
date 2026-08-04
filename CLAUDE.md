# CLAUDE.md

Guidance for Claude Code when working in this repository (Kapustin2000/Kapustin2000 — GitHub profile README + content).

## Adding a new publication to `publications/`

This repo tracks publications (articles, research papers, media mentions) as one folder per entry, indexed at three levels. When adding a new item — especially a research paper — update **all** of the following, not just the entry folder. Missing a level leaves the site's counts/timeline/tags out of sync.

### 1. Pick the category

- `research-publications/` — peer-reviewed or clinical papers, usually ASRP-affiliated, has a DOI or external journal link
- `academic-research/` — academic papers not tied to ASRP (e.g. university coursework/journals)
- `technical-articles/` — engineering write-ups, usually multi-language (`article.en.md`, `.ru.md`, `.uk.md`, `.de.md`, `.es.md`)
- `popular-science/` — accessible science/tech pieces, also multi-language
- `media-mentions/` — third-party press coverage, not authored by Kapustin

### 2. Create the entry folder

`publications/<category>/<descriptive-kebab-slug>/` containing:

- The source PDF (or `article.<lang>.md` files for technical-articles/popular-science), **keep the original filename** for PDFs
- `README.md` — breadcrumb back to category, title + date/venue, `Developed at:` link to `experience/asrp/` (only if `company: asrp`), `Authors:` line if paper has named co-authors, `Links:` (DOI/external link + local PDF), then a plain-language summary paragraph with the key findings/numbers. Embed extracted figures inline (see step 4) rather than just linking the PDF.
- `meta.yaml` — see schema below

`meta.yaml` schema for a `research_paper`:

```yaml
id: descriptive-kebab-slug          # matches folder name
type: research_paper
title: "Full paper title"
date: 2025-09                       # YYYY-MM, from the paper's own printed date, not a citation site's inferred year
journal: "Venue name, issue/series if any"
doi: "10.xxxx/xxxxx"                 # omit if none
link: "https://doi.org/10.xxxx/xxxxx"  # or external ResearchGate/journal URL
pdf: "filename.pdf"                  # relative to this folder
images:                               # only if figures were extracted, see step 4
  - "images/figure-1-....png"
company: asrp                         # omit if not ASRP-affiliated
authors: [Full Name, Full Name, ...]  # include when the paper lists named co-authors
tags: [tag-one, tag-two]              # check tag_taxonomy in publications/meta.yaml first — reuse existing tags/families before inventing new ones
cluster_ids: [existing-or-new-cluster]
related_publications: [other-entry-id, ...]  # only add real content overlap, don't force it
status: published
```

### 3. Propagate through every aggregator (in this order)

1. `publications/<category>/meta.yaml` — add to `entities:`
2. `publications/<category>/README.md` — add table row, bump the category count in the intro line
3. `publications/meta.yaml` (top-level) — bump `categories:` count, add to `entities:`, add/extend a `clusters:` entry, add/extend a `tag_taxonomy:` family (reuse existing tags where they fit — don't create near-duplicates), add to `timeline:` under the right year/month, optionally add `relations:` if there's a genuine content link to another publication (don't force one)
4. `publications/README.md` (top-level) — bump the header entry count, add to `## By Cluster`, `## Publication Timeline`, `## Tag Index`, the category's table under `## By Category`, and bump the year count in `## By Year`
5. If `company: asrp`, add a line to **Related Publications** in `experience/asrp/README.md`

Look at a recent research-publications entry (e.g. `gms-gfs-right-brain` or `inspira-x-clinical-validation`) as the concrete template before writing a new one — the schema above is a summary, the existing files are the source of truth.

### 4. Extract figures from the source PDF (for research papers with charts/tables)

Don't screenshot or re-describe figures — pull them straight out of the PDF:

```bash
pdfimages -list source.pdf          # find which page/object holds each figure (skip the logo/smask entries)
pdfimages -png source.pdf fig       # extract as fig-XXX.png
```

Read each extracted PNG back to verify it matches the paper's actual figure before using it (page/object order in the `-list` output tells you which `fig-XXX.png` is which figure). Copy the real ones into `<entry-folder>/images/` with descriptive names (`figure-1-....png`, not `fig-002.png`), then embed them in `README.md` with a caption matching the paper's own figure caption, interleaved with the relevant paragraph of the summary.

### 5. Validate before committing

```bash
python3 -c "import yaml; yaml.safe_load(open('path/to/meta.yaml'))"   # every meta.yaml you touched
git status --short                                                      # confirm only intended files changed
```

Only commit when explicitly asked to.
