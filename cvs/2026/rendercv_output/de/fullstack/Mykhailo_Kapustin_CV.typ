// Import the rendercv function and all the refactored components
#import "@preview/rendercv:0.3.0": *

// Apply the rendercv template with custom configuration
#show: rendercv.with(
  name: "Mykhailo Kapustin",
  title: "Mykhailo Kapustin - Senior Full-Stack Engineer (Backend-focused)",
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
    day: 6,
  ),
)


= Mykhailo Kapustin

  #headline([Senior Full-Stack Engineer (Backend-focused)])

#connections(
  [#link("mailto:kapustinomm@gmail.com", icon: false, if-underline: false, if-color: false)[kapustinomm\@gmail.com]],
  [#link("https://linkedin.com/in/mykhailo-kapustin-55885612a", icon: false, if-underline: false, if-color: false)[linkedin.com\/in\/mykhailo-kapustin-55885612a]],
  [#link("https://github.com/Kapustin2000", icon: false, if-underline: false, if-color: false)[github.com\/Kapustin2000]],
  [Berlin, Germany · EU citizen, no visa needed · Available now],
)


== Summary

I started programming at 15 and have worked professionally since 2016, moving from PHP\/Laravel to Node.js and, in the last 3+ years, Python-based LLM systems. I've launched around 20 products and like owning them end to end, from idea to production. I write about AI architecture and test new coding agents such as Claude Code and Codex. Based in Berlin, seeking a full-time role; open to Berlin hybrid\/on-site and remote EU.

== Experience

#regular-entry(
  [
    #strong[Senior Full-Stack Engineer (Contract)]

    #emph[WireBee]

  ],
  [
    #emph[Remote (US)]

    #emph[Sept 2025 – Sept 2026]

  ],
  main-column-second-row: [
    #summary[Voice and call-routing platform with live operator state and AI on calls.]

    - Designed a sync model for live call and operator state so the platform stays aligned with the external phone system without the UI depending on live third-party API calls.

    - Fixed a race where call events arrived before the call could be identified, using bounded buffering and replay instead of dropping unmatched events.

    - Built a ring-all routing engine with a distributed lock so exactly one operator claims each call, plus an idempotent fallback when no one answers.

    - Integrated voice AI into live calls while keeping control and routing in the backend, with a fallback to the standard phone menu if the AI path fails.

    - Stack: TypeScript, Node.js, Jambonz, Redis, MySQL

  ],
)

#regular-entry(
  [
    #strong[Senior Full-Stack Engineer (Contract)]

    #emph[Osnova GmbH]

  ],
  [
    #emph[Berlin, Germany]

    #emph[June 2024 – Sept 2025]

  ],
  main-column-second-row: [
    #summary[Multi-tenant AI agent platform for tenant-scoped agents, tools, data sources and deployments.]

    - Built backend capabilities for tenant-scoped agents, tools, data sources and deployments, with PostgreSQL row-level security and per-request tenant context.

    - Moved long-running agent creation from synchronous HTTP to a queue with retries and dead-letter handling, and added per-step execution traces so failures are diagnosable.

    - Owned the platform end to end across backend, frontend, cloud and AI, including the staging-to-production release flow across three Azure environments.

    - Stack: Python, TypeScript, React, Node.js, NestJS, FastAPI, PostgreSQL, Azure, OpenAI, Gemini, Claude

  ],
)

#regular-entry(
  [
    #strong[Senior Full-Stack Engineer (Contract)]

    #emph[Woolf]

  ],
  [
    #emph[Remote (US)]

    #emph[Apr 2023 – June 2024]

  ],
  main-column-second-row: [
    #summary[Edtech university exam system using LLM agents for student onboarding.]

    - Designed and built an LLM-agent exam system on Google ADK for student onboarding, used by Oxford students across 80+ test sessions.

    - Cut LLM cost and latency by about 40\% through token and memory optimization.

    - Stack: Python, TypeScript, React, Node.js, Google ADK, Vertex AI, Gemini

  ],
)

#regular-entry(
  [
    #strong[Backend \/ full-stack roles]

    #emph[Earlier experience]

  ],
  [
    #emph[Odesa and Kyiv, Ukraine]

    #emph[2016 – 2023]

  ],
  main-column-second-row: [
    - Senior Back-end Developer · LAB325 & MOB.325 (2021–2023): delivered 4 products (edtech platform, plant-care app, anonymous chat, smart-TV companion); OAuth2.0\/JWT, GraphQL, PostgreSQL\/ClickHouse\/Elasticsearch, Docker.

    - Senior Back-end Developer · Provectus (2021): refactored a large-scale tender management platform; PHP\/Laravel, PostgreSQL, Nginx, Docker, CI\/CD, RBAC.

    - Middle Back-end Developer · Coelix (2020–2021): moved the company from WordPress to custom software; delivered 3 projects incl. an edtech platform.

    - Middle Full Stack Developer · Ephyros (2020): QPQ International, a deal advisory platform for green-energy investments; Laravel, PostgreSQL, Vue.js.

    - Junior Full Stack Developer · HYS Enterprise (2018–2020) and Top Agent (2018): corporate website and a travel management platform; PHP.

    - Junior Full Stack Developer · PHP-academy (2017) and Junior Back-end Developer & Account Manager · SuperMediaAds (2016): website engine development; PHP.

  ],
)

== Skills

#strong[Backend:] Node.js, NestJS, TypeScript, Python, FastAPI, GraphQL, OAuth2.0\/JWT

#strong[Frontend:] React, Vue

#strong[Data:] PostgreSQL (row-level security), MySQL, Redis, ClickHouse, Elasticsearch

#strong[Cloud & infra:] Azure, GCP, Docker, Nginx

#strong[Tools:] Claude Code, Codex, Cursor, Pi

== Publications & Conferences

#strong[Articles:] “How to Integrate Google ADK with a Custom Interface” (2025, 10,000+ reads on Medium, Habr, Hashnode); “Building AI Agent Infrastructure: Three Paths from Chaos to Scalable Systems” (2025)

#strong[In total:] 23 publications, 100K+ reads

#strong[Conference:] THETA EuroCon, Berlin (Sept 2025): live pitch and hackathon; built an AI solution

#v(0.7em)
#grid(columns: (1fr, 1fr), column-gutter: 2em, [
#set par(spacing: 0.3em)
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

], [
#set par(spacing: 0.3em)
== Languages

#pad(left: 0.5em, top: 0em, bottom: 0.3em)[• #h(0.4em) Ukrainian \/ Russian: Native]

#pad(left: 0.5em, top: 0em, bottom: 0.3em)[• #h(0.4em) English: C1]

#pad(left: 0.5em, top: 0em, bottom: 0.3em)[• #h(0.4em) German: A2]
])
