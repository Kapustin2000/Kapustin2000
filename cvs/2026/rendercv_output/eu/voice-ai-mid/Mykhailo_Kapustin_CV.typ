// Import the rendercv function and all the refactored components
#import "@preview/rendercv:0.3.0": *

// Apply the rendercv template with custom configuration
#show: rendercv.with(
  name: "Mykhailo Kapustin",
  title: "Mykhailo Kapustin - Voice AI Engineer",
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

  #headline([Voice AI Engineer])

#connections(
  [#link("mailto:kapustinomm@gmail.com", icon: false, if-underline: false, if-color: false)[kapustinomm\@gmail.com]],
  [#link("https://linkedin.com/in/mykhailo-kapustin-55885612a", icon: false, if-underline: false, if-color: false)[linkedin.com\/in\/mykhailo-kapustin-55885612a]],
  [#link("https://github.com/Kapustin2000", icon: false, if-underline: false, if-color: false)[github.com\/Kapustin2000]],
  [EU citizen, no visa needed · Remote EU · Available now],
)


== Summary

I started programming at 15 and have worked professionally since 2016, moving from PHP\/Laravel to Node.js and, in the last 3+ years, Python-based LLM systems. I've launched around 20 products and like owning them end to end, from idea to production. I write about AI architecture and test new coding agents such as Claude Code and Codex. Seeking a full-time role; open to remote EU.

== Experience

#regular-entry(
  [
    #strong[Full-stack Engineer and Voice-AI Engineer (Contract)]

    #emph[WireBee]

  ],
  [
    #emph[Remote (US)]

    #emph[Sept 2025 – Sept 2026]

  ],
  main-column-second-row: [
    #summary[Voice and call-routing platform with live operator state and AI on calls.]

    - Integrated voice AI into live calls while keeping call control and routing decisions in the backend, with a fallback to the standard phone menu if the AI path fails.

    - Built a scenario-testing framework for the voice agent that runs calls, captures transcripts and events, and checks outcomes against explicit assertions.

    - Built a ring-all routing engine that calls all available operators and uses a distributed lock to ensure exactly one person claims the call, with idempotent fallback when no one answers.

    - Solved a race condition where call events arrived before the platform could identify the call, using bounded buffering and replay instead of dropping unmatched events.

    - Designed a synchronization model for live call and operator state: inbound events plus periodic reconciliation keep the platform's local view aligned with the external phone system, without making the UI depend on live third-party API calls.

    - Stack: TypeScript, Node.js, Jambonz, Redis, MySQL

  ],
)

#regular-entry(
  [
    #strong[Full-stack Engineer and AI Engineer (Contract)]

    #emph[Osnova GmbH]

  ],
  [
    #emph[Berlin, Germany]

    #emph[June 2024 – Sept 2025]

  ],
  main-column-second-row: [
    #summary[Multi-tenant AI agent platform for tenant-scoped agents, tools, data sources and deployments.]

    - Designed a registry-based contract for tools and agents so a new business onboards as configuration, not a new project; built the multi-tenant NestJS\/PostgreSQL backend and React operator dashboard.

    - Productionized an AI order-entry agent that turns emailed orders into ERP orders, creating them only after validation, with duplicate protection and clear status replies for cases needing review.

    - Stack: Python, TypeScript, React, Node.js, NestJS, FastAPI, PostgreSQL, Azure, OpenAI, Gemini, Claude

  ],
)

#regular-entry(
  [
    #strong[Full-stack Engineer and AI Engineer (Contract)]

    #emph[Woolf]

  ],
  [
    #emph[Remote (US)]

    #emph[Apr 2023 – June 2024]

  ],
  main-column-second-row: [
    #summary[Edtech university exam system using LLM agents for student onboarding.]

    - Designed and built an LLM-agent exam system on Google ADK for Woolf's higher-education onboarding — covering exam generation, delivery, and evaluation — deployed for real Oxford students running an entrance-style assessment, across 80+ test sessions in three months.

    - Stack: Python, TypeScript, React, Node.js, Google ADK, Vertex AI, Gemini

  ],
)

== Skills

#strong[Backend (primary):] Node.js, NestJS, Python, FastAPI, TypeScript, PostgreSQL, Docker

#strong[Cloud Platforms:] Azure, AWS, GCP

#strong[Frontend (used in projects):] React (Osnova operator dashboard, Woolf), Vue (earlier roles)

#strong[AI\/ML:] RAG, Anthropic, OpenAI, Google Vertex AI, Gemini, OpenRouter, LiteLLM, Model fallback\/routing design, Claude Agent SDK

#strong[Agents & Observability:] Google ADK, LangChain, LangGraph, Agent Orchestration, Agent Evaluation & Observability, OpenTelemetry, Arize Phoenix tracing, Voice AI (Jambonz)

#strong[AI Coding Agents:] Claude Code, Codex (ChatGPT), Cursor, herdr, pi-agent, hermesagent

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
