// Import the rendercv function and all the refactored components
#import "@preview/rendercv:0.3.0": *

// Apply the rendercv template with custom configuration
#show: rendercv.with(
  name: "Mykhailo Kapustin",
  title: "Mykhailo Kapustin - AI Engineer",
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

  #headline([AI Engineer])

#connections(
  [#link("mailto:kapustinomm@gmail.com", icon: false, if-underline: false, if-color: false)[kapustinomm\@gmail.com]],
  [#link("https://linkedin.com/in/mykhailo-kapustin-55885612a", icon: false, if-underline: false, if-color: false)[linkedin.com\/in\/mykhailo-kapustin-55885612a]],
  [#link("https://github.com/Kapustin2000", icon: false, if-underline: false, if-color: false)[github.com\/Kapustin2000]],
  [Sofia, Bulgaria · EU citizen · Available now],
)


== Summary

I've been programming since the age of 15 (2015) and have worked on 20+ projects, both building new products from scratch and developing existing ones. I like taking ownership of tasks and whole projects, and I enjoy research and development. I keep deepening my expertise: I learn new technologies, tools and techniques, attend technical events, and write technical articles and research, including on AI. Outside of work I lead a healthy lifestyle and practice Pilates. Based in Sofia, seeking a full-time role; open to Sofia hybrid\/on-site and remote EU.

== Experience

#regular-entry(
  [
    #strong[AI Engineer (Contract)]

    #emph[WireBee, 2–10 employees, team of 4]

  ],
  [
    #emph[Remote (US, Ohio)]

    #emph[Sept 2025 – Sept 2026]

  ],
  main-column-second-row: [
    #summary[AI call automation and call routing for freight brokerages; the company reports its voice agents automate 40–90\% of inbound carrier calls. Owned the development end to end; communicated directly with the CEO.]

    - Built the voice-AI call flow and the backend behind it: the agent handles part of inbound calls end to end and collects caller details up front for the rest, with a fallback to the standard phone menu if the AI path fails.

    - Built a scenario-testing framework for the voice agent that runs calls, captures transcripts and events, and checks outcomes against explicit assertions.

    - Stack: TypeScript, Node.js, Jambonz, Redis, MySQL

  ],
)

#regular-entry(
  [
    #strong[AI Engineer (Contract)]

    #emph[Osnova GmbH, 2–10 employees, team of 4]

  ],
  [
    #emph[Berlin, Germany (on-site)]

    #emph[June 2024 – Sept 2025]

  ],
  main-column-second-row: [
    #summary[AI agent platform (cogit): agent factories turn a business requirement into a researched, configured, tested and deployed agent for workflows like orders and documents; the company reports −20 h\/week order processing and −96\% document processing time. Owned the development end to end; communicated directly with the CEO.]

    - Designed a registry-based contract for tools and agents so a new business onboards as configuration, not a new project; built the multi-tenant NestJS\/PostgreSQL backend and React operator dashboard.

    - Productionized an AI order-entry agent that turns emailed orders into ERP orders, creating them only after validation, with duplicate protection and clear status replies for cases needing review.

    - Owned the platform end to end — research, development, deployment, QA, and support — across backend, frontend, cloud, and AI; agents deployed to a website widget, Outlook add-in, and email pipeline.

    - Stack: Python, TypeScript, React, Node.js, NestJS, FastAPI, PostgreSQL, Azure, OpenAI, Gemini, Claude

  ],
)

#regular-entry(
  [
    #strong[AI Engineer (Contract)]

    #emph[Woolf, 50–200 employees, team of 7]

  ],
  [
    #emph[Remote (US, San Francisco)]

    #emph[Apr 2023 – June 2024]

  ],
  main-column-second-row: [
    #summary[Online university with accredited degrees; LLM-agent exam system for student onboarding. Owned the development end to end; communicated directly with the product manager.]

    - Designed and built an LLM-agent exam system on Google ADK for Woolf's higher-education onboarding — covering exam generation, delivery, and evaluation — deployed for real Oxford students running an entrance-style assessment, across 80+ test sessions in three months.

    - Cut LLM workflow cost\/latency by \~40\% through token and memory optimization, making the multi-agent pipeline viable to run at that volume.

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

#strong[AI \/ LLM:] OpenAI, Gemini, Claude, RAG, LangChain, LangGraph, Google ADK, Vertex AI, agent evaluation, tracing & observability (OpenTelemetry, Arize Phoenix), voice AI (Jambonz)

#strong[Backend:] Python, FastAPI, TypeScript, Node.js, NestJS, GraphQL, OAuth2.0\/JWT

#strong[Data:] PostgreSQL (row-level security), MySQL, Redis, ClickHouse, Elasticsearch

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
