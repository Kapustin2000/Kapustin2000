# Mykhailo Kapustin's CV

- Email: [kapustinomm@gmail.com](mailto:kapustinomm@gmail.com)
- Location: Sofia, Bulgaria · EU citizen · Available now
- LinkedIn: [mykhailo-kapustin-55885612a](https://linkedin.com/in/mykhailo-kapustin-55885612a)
- GitHub: [Kapustin2000](https://github.com/Kapustin2000)


# Summary
I've been programming since the age of 15 (2015) and have worked on 20+ projects, both building new products from scratch and developing existing ones. I take ownership of problems end to end and enjoy research and development. I build LLM agents and voice AI inside real business systems, keep deepening my expertise by learning new technologies and attending technical events, and write technical articles and research on AI. Based in Sofia, seeking a full-time role; open to Sofia hybrid/on-site and remote EU.

# Experience
## **Senior Backend & AI Engineer (Contract)**

*Remote (US, Ohio)*

*Sept 2025 – Sept 2026*

*WireBee, 2–10 employees, team of 4*

AI call automation and routing for freight brokerages. Owned the development end to end; worked directly with the CEO.

- Built the voice-AI call flow and the backend behind it: the agent handles part of inbound calls end to end and collects caller details up front for the rest, with a fallback to the standard phone menu if the AI path fails. Now the company reports its voice AI agents automate 40–90% of inbound carrier calls.

- Covered the 8 regular call types and focused on the largest, carriers calling to take a posted load (~80% of call volume, per the CEO): the agent picked up, established who was calling, why and about which load, checked the load, the company and the carrier, and filtered out unwanted calls before they reached an operator.

- Designed a sync model for live call and operator state, keeping the platform aligned with the external phone system without live third-party API calls from the UI.

- Built a ring-all routing engine with a distributed lock so exactly one operator claims each call, plus an idempotent fallback when no one answers.

- Built a scenario-testing framework for the voice agent that runs calls, captures transcripts and events, and checks outcomes against explicit assertions.

- Stack: TypeScript, Node.js, Jambonz, Redis, MySQL



## **Senior Backend & AI Engineer (Contract)**

*Berlin, Germany (on-site)*

*June 2024 – Sept 2025*

*Osnova GmbH, 2–10 employees, team of 4*

AI agent platform (cogit): agent factories turn a business requirement into a tested, deployed agent for workflows like orders and documents (the company reports −20 h/week order processing and −96% document processing time). Owned the development end to end; worked directly with the CEO.

- Productionized an AI order-entry agent that turns emailed orders into ERP orders, creating them only after validation, with duplicate protection and clear status replies for cases needing review.

- Deployed agents to a website widget, an Outlook add-in and an email pipeline; designed a registry-based contract so a new business onboards as configuration, not a new project.

- Moved long-running agent creation to a queue with retries and dead-letter handling, with per-step execution traces so failures are diagnosable.

- Owned the platform end to end across backend, frontend, cloud and AI, including the staging-to-production release flow across three Azure environments.

- Stack: Python, TypeScript, React, Node.js, NestJS, FastAPI, PostgreSQL, Azure, OpenAI, Gemini, Claude



## **Senior Backend & AI Engineer (Contract)**

*Remote (US, San Francisco)*

*Apr 2023 – June 2024*

*Woolf, 50–200 employees, team of 7*

Online university with accredited degrees. Owned the development end to end; worked directly with the product manager.

- Designed and built an LLM-agent exam system on Google ADK for student onboarding, used by Oxford students across 80+ test sessions.

- Cut LLM cost and latency by about 40% through token and memory optimization.

- Stack: Python, TypeScript, React, Node.js, Google ADK, Vertex AI, Gemini



## **Backend / full-stack roles**

*Odesa and Kyiv, Ukraine*

*2016 – 2023*

*Earlier experience*

- Senior Back-end Developer · LAB325 & MOB.325 (2021–2023): delivered 4 products (edtech platform, plant-care app, anonymous chat, smart-TV companion); OAuth2.0/JWT, GraphQL, PostgreSQL/ClickHouse/Elasticsearch, Docker.

- Senior Back-end Developer · Provectus (2021): refactored a large-scale tender management platform; PHP/Laravel, PostgreSQL, Nginx, Docker, CI/CD, RBAC.

- Middle Back-end Developer · Coelix (2020–2021): moved the company from WordPress to custom software; delivered 3 projects incl. an edtech platform.

- Middle Full Stack Developer · Ephyros (2020): QPQ International, a deal advisory platform for green-energy investments; Laravel, PostgreSQL, Vue.js.

- Junior Full Stack Developer · HYS Enterprise (2018–2020) and Top Agent (2018): corporate website and a travel management platform; PHP.

- Junior Full Stack Developer · PHP-academy (2017) and Junior Back-end Developer & Account Manager · SuperMediaAds (2016): website engine development; PHP.



# Skills
**AI / LLM:** OpenAI, Gemini, Claude, RAG, LangGraph, Google ADK, Vertex AI, agent evaluation, tracing & observability (OpenTelemetry, Arize Phoenix), voice AI (Jambonz)

**Integrations:** Telephony / PBX (Jambonz), ERP, Outlook add-in, email pipelines, REST / GraphQL APIs, OAuth2.0/JWT

**Backend:** Node.js, NestJS, TypeScript, Python, FastAPI

**Data:** PostgreSQL (row-level security), MySQL, Redis, ClickHouse, Elasticsearch

**Cloud & infra:** Azure, GCP, Docker, Nginx

**Tools:** Claude Code, Codex, Cursor, Pi

# Publications & Conferences
**Articles:** “How to Integrate Google ADK with a Custom Interface” (2025, 10,000+ reads on Medium, Habr, Hashnode); “Building AI Agent Infrastructure: Three Paths from Chaos to Scalable Systems” (2025)

**In total:** 23 publications, 100K+ reads

**Conference:** THETA EuroCon, Berlin (Sept 2025): live pitch and hackathon; built an AI solution

# Education
## **State University of Intellectual Technologies and Communications**
*Odesa, Ukraine*


*Sept 2017 – Dec 2022*

*BSc, MSc* *in* *Automation and Computer-Integrated Technologies*



# Languages
**Ukrainian / Russian:** Native

**English:** C1

**German:** A2
