// Import the rendercv function and all the refactored components
#import "@preview/rendercv:0.3.0": *

// Apply the rendercv template with custom configuration
#show: rendercv.with(
  name: "Mykhailo Kapustin",
  title: "Mykhailo Kapustin - Senior Backend Engineer (TypeScript / Python)",
  footer: context { [#emph[Mykhailo Kapustin -- #str(here().page())\/#str(counter(page).final().first())]] },
  top-note: [ #emph[Last updated in Nov 2026] ],
  locale-catalog-language: "en",
  text-direction: ltr,
  page-size: "us-letter",
  page-top-margin: 0.7in,
  page-bottom-margin: 0.7in,
  page-left-margin: 0.7in,
  page-right-margin: 0.7in,
  page-show-footer: true,
  page-show-top-note: false,
  colors-body: rgb(0, 0, 0),
  colors-name: rgb(0, 0, 0),
  colors-headline: rgb(0, 0, 0),
  colors-connections: rgb(0, 0, 0),
  colors-section-titles: rgb(0, 0, 0),
  colors-links: rgb(0, 0, 0),
  colors-footer: rgb(128, 128, 128),
  colors-top-note: rgb(128, 128, 128),
  typography-line-spacing: 0.6em,
  typography-alignment: "justified",
  typography-date-and-location-column-alignment: right,
  typography-font-family-body: "New Computer Modern",
  typography-font-family-name: "New Computer Modern",
  typography-font-family-headline: "New Computer Modern",
  typography-font-family-connections: "New Computer Modern",
  typography-font-family-section-titles: "New Computer Modern",
  typography-font-size-body: 10pt,
  typography-font-size-name: 30pt,
  typography-font-size-headline: 10pt,
  typography-font-size-connections: 10pt,
  typography-font-size-section-titles: 1.4em,
  typography-small-caps-name: false,
  typography-small-caps-headline: false,
  typography-small-caps-connections: false,
  typography-small-caps-section-titles: false,
  typography-bold-name: true,
  typography-bold-headline: false,
  typography-bold-connections: false,
  typography-bold-section-titles: true,
  links-underline: true,
  links-show-external-link-icon: false,
  header-alignment: center,
  header-photo-width: 3.5cm,
  header-space-below-name: 0.7cm,
  header-space-below-headline: 0.7cm,
  header-space-below-connections: 0.7cm,
  header-connections-hyperlink: true,
  header-connections-show-icons: false,
  header-connections-display-urls-instead-of-usernames: true,
  header-connections-separator: "•",
  header-connections-space-between-connections: 0.5cm,
  section-titles-type: "with_full_line",
  section-titles-line-thickness: 0.5pt,
  section-titles-space-above: 0.5cm,
  section-titles-space-below: 0.3cm,
  sections-allow-page-break: true,
  sections-space-between-text-based-entries: 0.3em,
  sections-space-between-regular-entries: 1.2em,
  entries-date-and-location-width: 4.15cm,
  entries-side-space: 0.2cm,
  entries-space-between-columns: 0.1cm,
  entries-allow-page-break: false,
  entries-short-second-row: false,
  entries-degree-width: 1cm,
  entries-summary-space-left: 0cm,
  entries-summary-space-above: 0cm,
  entries-highlights-bullet:  "◦" ,
  entries-highlights-nested-bullet:  "◦" ,
  entries-highlights-space-left: 0.15cm,
  entries-highlights-space-above: 0cm,
  entries-highlights-space-between-items: 0cm,
  entries-highlights-space-between-bullet-and-text: 0.5em,
  date: datetime(
    year: 2026,
    month: 11,
    day: 4,
  ),
)


= Mykhailo Kapustin

  #headline([Senior Backend Engineer (TypeScript \/ Python)])

#connections(
  [Bulgarian EU Citizen],
  [#link("mailto:kapustinomm@gmail.com", icon: false, if-underline: false, if-color: false)[kapustinomm\@gmail.com]],
  [#link("https://linkedin.com/in/mykhailo-kapustin-55885612a", icon: false, if-underline: false, if-color: false)[linkedin.com\/in\/mykhailo-kapustin-55885612a]],
  [#link("https://github.com/Kapustin2000", icon: false, if-underline: false, if-color: false)[github.com\/Kapustin2000]],
)


== Summary

Senior Backend Engineer with 10+ years of experience building production backends in TypeScript\/Node.js and Python (FastAPI). Recent work centers on the reliability problems behind LLM products: queues with retries and dead-letter handling, distributed locks, idempotent fallbacks, reconciliation of external systems, per-step tracing, and LLM cost\/latency control across OpenAI, Gemini, and Claude. Stack: TypeScript\/Node.js (NestJS), Python\/FastAPI, PostgreSQL, Redis, GCP\/Azure\/AWS.

== Experience

#regular-entry(
  [
    #strong[Full-stack Engineer and Voice-AI Engineer]

    #emph[WireBee · Contract]

  ],
  [
    #emph[Ohio, USA]

    #emph[Sept 2025 – Sept 2026]

  ],
  main-column-second-row: [
    - Built a ring-all routing engine that calls all available operators and uses a distributed lock so exactly one person claims the call, with an idempotent fallback when no one answers.

    - Solved a race condition where call events arrived before the platform could identify the call, using bounded buffering and replay instead of dropping unmatched events.

    - Designed a synchronization model for live call and operator state: inbound events plus periodic reconciliation keep the local view aligned with the external phone system, without making the UI depend on live third-party API calls.

    - Integrated voice AI into live calls while keeping call control and routing in the backend, with a fallback to the standard phone menu if the AI path fails.

    - Stack: TypeScript, Node.js, Jambonz, Redis, MySQL

  ],
)

#regular-entry(
  [
    #strong[Full-stack Engineer and AI Engineer]

    #emph[Osnova GmbH · Contract]

  ],
  [
    #emph[Berlin, Germany]

    #emph[June 2024 – Sept 2025]

  ],
  main-column-second-row: [
    - Built the Python\/FastAPI service behind agent authoring and execution, including an email-processing pipeline with a retryable state machine, running alongside the NestJS\/TypeScript backend (about 45\% of commits across the two core repos).

    - Moved long-running agent creation (1–30 min) from synchronous HTTP requests, which caused gateway timeouts, to a message-bus queue with retries, dead-letter handling, and lock renewal; added per-step execution traces so failures are diagnosable.

    - Fixed a blocking call on a shared event loop that stalled all tenants by moving I\/O to a thread pool and then an async DB pool, rolled out behind feature flags and per-tenant opt-in.

    - Built tenant-scoped agents, tools, data sources, and deployments, enforcing isolation with PostgreSQL row-level security and per-request tenant context.

    - Owned the platform end to end, including the staging-to-production release flow across three Azure environments.

    - Stack: TypeScript, Node.js, NestJS, Python, FastAPI, PostgreSQL, Azure, OpenAI, Gemini, Claude

  ],
)

#regular-entry(
  [
    #strong[Full-stack Engineer and AI Engineer]

    #emph[Woolf · Contract]

  ],
  [
    #emph[San Francisco, USA]

    #emph[Apr 2023 – June 2024]

  ],
  main-column-second-row: [
    - Built an LLM-agent exam system on Google ADK, used by real Oxford students across 80+ test sessions; cut LLM cost and latency by \~40\% through token and memory optimization.

    - Stack: Python, Node.js, TypeScript, Google ADK, Vertex AI, Gemini

  ],
)

#regular-entry(
  [
    #strong[LAB325 & MOB.325, Provectus, Coelix, Ephyros, HYS Enterprise, Top Agent, PHP-academy, SuperMediaAds]

    #emph[Earlier backend \/ full-stack experience]

  ],
  [
    #emph[Odesa & Kyiv, Ukraine]

    #emph[2016 – 2023]

  ],
  main-column-second-row: [
    - Team lead and backend roles across edtech, corporate, and travel\/ad-tech platforms, including Node.js\/GraphQL services with ClickHouse analytics, PostgreSQL, and Elasticsearch, and a service on Kubernetes (AWS, Terraform, Grafana).

    - Full history: #link("https://github.com/Kapustin2000/Kapustin2000/tree/master/experience")[github.com\/Kapustin2000\/Kapustin2000\/tree\/master\/experience]

  ],
)

== Skills

#strong[Languages & runtimes:] TypeScript, Node.js, Bun, Python

#strong[Backend:] NestJS, FastAPI (async), GraphQL, queues and workers, retries, idempotency, distributed locks, webhooks

#strong[Data:] PostgreSQL (row-level security), ClickHouse, Redis, MySQL, Elasticsearch

#strong[Cloud & infra:] GCP, Azure, AWS, Kubernetes, Terraform, Docker

#strong[Observability:] Per-step tracing, OpenTelemetry, Arize Phoenix, Grafana, structured logging

#strong[LLM providers:] OpenAI, Claude, Gemini, Vertex AI, RAG, agent evaluation

#strong[AI coding agents:] Claude Code, Codex, Cursor

== Education

#education-entry(
  [
    #strong[State University of Intellectual Technologies and Communications]

    #emph[MSc] #emph[in] #emph[Automation and Computer-Integrated Technologies]

  ],
  [
    #emph[Odesa, Ukraine]

    #emph[Aug 2021 – Dec 2022]

  ],
  main-column-second-row: [
  ],
)

#education-entry(
  [
    #strong[State University of Intellectual Technologies and Communications]

    #emph[BSc] #emph[in] #emph[Automation and Computer-Integrated Technologies]

  ],
  [
    #emph[Odesa, Ukraine]

    #emph[Sept 2017 – July 2021]

  ],
  main-column-second-row: [
  ],
)

== Languages

#strong[Ukrainian \/ Russian:] Native

#strong[English:] C1

#strong[German:] A2

== Publications

#regular-entry(
  [
    #strong[How to Integrate Google ADK with a Custom Interface]

  ],
  [
    #emph[2025]

  ],
  main-column-second-row: [
    #summary[Hands-on guide to wiring Google ADK agents into a custom, non-default frontend — 10,000+ reads across Medium, Habr, and Hashnode.]

  ],
)

#regular-entry(
  [
    #strong[Building AI Agent Infrastructure: Three Paths from Chaos to Scalable Systems]

  ],
  [
    #emph[2025]

  ],
  main-column-second-row: [
    #summary[How to move from a messy AI monorepo to a scalable agent ecosystem — with real examples, three architectural paths (Filesystem Registry, Package Manager, AgentOps), and lessons from building multi-agent infrastructures.]

  ],
)

  #regular-entry(
  [
    #strong[#link("https://github.com/Kapustin2000/Kapustin2000/tree/master/publications")[Other publications]]

  ],
  [
  ],
  main-column-second-row: [
    #summary[23 entries · 10 technical articles (100K+ total reads) · 7 popular science articles · 4 research papers · 1 academic paper · 1 media mention]

  ],
)
