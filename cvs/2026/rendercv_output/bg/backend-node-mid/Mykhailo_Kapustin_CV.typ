// Import the rendercv function and all the refactored components
#import "@preview/rendercv:0.3.0": *

// Apply the rendercv template with custom configuration
#show: rendercv.with(
  name: "Mykhailo Kapustin",
  title: "Mykhailo Kapustin - Senior Backend Engineer (Node.js / TypeScript)",
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
  entries-date-and-location-width: 4.6cm,
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
    day: 6,
  ),
)


= Mykhailo Kapustin

  #headline([Backend Engineer (Node.js \/ TypeScript)])

#connections(
  [#link("mailto:kapustinomm@gmail.com", icon: false, if-underline: false, if-color: false)[kapustinomm\@gmail.com]],
  [#link("https://linkedin.com/in/mykhailo-kapustin-55885612a", icon: false, if-underline: false, if-color: false)[linkedin.com\/in\/mykhailo-kapustin-55885612a]],
  [#link("https://github.com/Kapustin2000", icon: false, if-underline: false, if-color: false)[github.com\/Kapustin2000]],
  [Sofia, Bulgaria · EU citizen · Available now],
)


== Summary

I've been programming since the age of 15 (2015) and have worked on 20+ projects, both building new products from scratch and developing existing ones. I like taking ownership of tasks and whole projects, and I enjoy research and development. I keep deepening my expertise: I learn new technologies, tools and techniques, attend technical events, and write technical articles and research, including on AI. Based in Sofia, seeking a full-time role; open to Sofia hybrid\/on-site and remote EU.

== Experience

#regular-entry(
  [
    #strong[Senior Backend Engineer (Contract)]

    #emph[WireBee, 2–10 employees, team of 4]

  ],
  [
    #emph[Remote (US, Ohio)]

    #emph[Sept 2025 – Sept 2026]

  ],
  main-column-second-row: [
    #summary[AI call automation and routing for freight brokerages (the company reports its voice AI agents automate 40–90\% of inbound carrier calls). Owned the development end to end; worked directly with the CEO.]

    - Designed a sync model for live call and operator state, keeping the platform aligned with the external phone system without live third-party API calls from the UI.

    - Fixed a race where call events arrived before the call could be identified, using bounded buffering and replay instead of dropping unmatched events.

    - Built a ring-all routing engine with a distributed lock so exactly one operator claims each call, plus an idempotent fallback when no one answers.

    - Built the voice-AI call flow and the backend behind it: the agent handles part of inbound calls end to end and collects caller details up front for the rest, with a fallback to the standard phone menu if the AI path fails.

    - Stack: TypeScript, Node.js, Jambonz, Redis, MySQL

  ],
)

#regular-entry(
  [
    #strong[Senior Backend Engineer (Contract)]

    #emph[Osnova GmbH, 2–10 employees, team of 4]

  ],
  [
    #emph[Berlin, Germany (on-site)]

    #emph[June 2024 – Sept 2025]

  ],
  main-column-second-row: [
    #summary[AI agent platform (cogit): agent factories turn a business requirement into a tested, deployed agent for workflows like orders and documents (the company reports −20 h\/week order processing and −96\% document processing time). Owned the development end to end; worked directly with the CEO.]

    - Built the multi-tenant backend for agents, tools, data sources and deployments, with PostgreSQL row-level security and per-request tenant context.

    - Moved long-running agent creation from synchronous HTTP to a queue with retries and dead-letter handling, and added per-step execution traces so failures are diagnosable.

    - Owned the platform end to end across backend, frontend, cloud and AI, including the staging-to-production release flow across three Azure environments.

    - Stack: Node.js, NestJS, TypeScript, Python, FastAPI, PostgreSQL, React, Azure, OpenAI, Gemini, Claude

  ],
)

#regular-entry(
  [
    #strong[Senior Backend Engineer (Contract)]

    #emph[Woolf, 50–200 employees, team of 7]

  ],
  [
    #emph[Remote (US, San Francisco)]

    #emph[Apr 2023 – June 2024]

  ],
  main-column-second-row: [
    #summary[Online university with accredited degrees. Owned the development end to end; worked directly with the product manager.]

    - Designed and built an LLM-agent exam system on Google ADK for student onboarding, used by Oxford students across 80+ test sessions.

    - Cut LLM cost and latency by about 40\% through token and memory optimization.

    - Stack: Node.js, TypeScript, Python, React, Google ADK, Vertex AI, Gemini

  ],
)

== Skills

#strong[Backend:] Node.js, NestJS, TypeScript, Python, FastAPI, GraphQL, OAuth2.0\/JWT

#strong[Data:] PostgreSQL (row-level security), MySQL, Redis, ClickHouse, Elasticsearch

#strong[AI \/ LLM:] OpenAI, Gemini, Claude, RAG, LangChain, LangGraph, Google ADK, Vertex AI, agent evaluation, tracing & observability (OpenTelemetry, Arize Phoenix), voice AI (Jambonz)

#strong[Cloud & infra:] Azure, GCP, Docker, Nginx

#strong[Tools:] Claude Code, Codex, Cursor, Pi

== Publications & Conferences

#strong[Articles:] “How to Integrate Google ADK with a Custom Interface” (2025, 10,000+ reads on Medium, Habr, Hashnode); “Building AI Agent Infrastructure: Three Paths from Chaos to Scalable Systems” (2025)

#strong[In total:] 23 publications, 100K+ reads

#strong[Conference:] THETA EuroCon, Berlin (Sept 2025): live pitch and hackathon; built an AI solution

== Education

#education-entry(
  [
    #strong[State University of Intellectual Technologies and Communications]

    #emph[BSc, MSc] #emph[in] #emph[Automation and Computer-Integrated Technologies]

  ],
  [
    #emph[Odesa, Ukraine]

    #emph[Sept 2017 – Dec 2022]

  ],
  main-column-second-row: [
  ],
)

== Languages

#strong[Ukrainian \/ Russian:] Native

#strong[English:] C1

#strong[German:] A2
