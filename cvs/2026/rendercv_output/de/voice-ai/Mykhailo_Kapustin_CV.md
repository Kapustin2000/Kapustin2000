# Mykhailo Kapustin's CV

- Email: [kapustinomm@gmail.com](mailto:kapustinomm@gmail.com)
- Location: Berlin, Germany · EU citizen, no visa needed · Available now
- LinkedIn: [mykhailo-kapustin-55885612a](https://linkedin.com/in/mykhailo-kapustin-55885612a)
- GitHub: [Kapustin2000](https://github.com/Kapustin2000)


# Summary
I've been programming since the age of 15 (2015) and have worked on 20+ projects, both building new products from scratch and developing existing ones. I like taking ownership of tasks and whole projects, and I enjoy research and development. I keep deepening my expertise: I learn new technologies, tools and techniques, attend technical events, and write technical articles and research, including on AI. Outside of work I lead a healthy lifestyle and practice Pilates. Based in Berlin, seeking a full-time role; open to Berlin hybrid/on-site and remote EU.

# Experience
## **Voice AI Engineer (Contract)**

*Remote (US, Ohio)*

*Sept 2025 – Sept 2026*

*WireBee, 2–10 employees, team of 4*

AI call automation and call routing for freight brokerages; the company reports its voice agents automate 40–90% of inbound carrier calls. Owned the development end to end; communicated directly with the CEO.

- Built the voice-AI call flow and the backend behind it: the agent handles part of inbound calls end to end and collects caller details up front for the rest, with a fallback to the standard phone menu if the AI path fails.

- Built a scenario-testing framework for the voice agent that runs calls, captures transcripts and events, and checks outcomes against explicit assertions.

- Built a ring-all routing engine that calls all available operators and uses a distributed lock to ensure exactly one person claims the call, with idempotent fallback when no one answers.

- Solved a race condition where call events arrived before the platform could identify the call, using bounded buffering and replay instead of dropping unmatched events.

- Designed a synchronization model for live call and operator state: inbound events plus periodic reconciliation keep the platform's local view aligned with the external phone system, without making the UI depend on live third-party API calls.

- Stack: TypeScript, Node.js, Jambonz, Redis, MySQL



## **AI Engineer (Contract)**

*Berlin, Germany (on-site)*

*June 2024 – Sept 2025*

*Osnova GmbH, 2–10 employees, team of 4*

AI agent platform (cogit): agent factories turn a business requirement into a researched, configured, tested and deployed agent for workflows like orders and documents; the company reports −20 h/week order processing and −96% document processing time. Owned the development end to end; communicated directly with the CEO.

- Designed a registry-based contract for tools and agents so a new business onboards as configuration, not a new project; built the multi-tenant NestJS/PostgreSQL backend and React operator dashboard.

- Productionized an AI order-entry agent that turns emailed orders into ERP orders, creating them only after validation, with duplicate protection and clear status replies for cases needing review.

- Stack: Python, TypeScript, React, Node.js, NestJS, FastAPI, PostgreSQL, Azure, OpenAI, Gemini, Claude



## **AI Engineer (Contract)**

*Remote (US, San Francisco)*

*Apr 2023 – June 2024*

*Woolf, 50–200 employees, team of 7*

Online university with accredited degrees; LLM-agent exam system for student onboarding. Owned the development end to end; communicated directly with the product manager.

- Designed and built an LLM-agent exam system on Google ADK for Woolf's higher-education onboarding — covering exam generation, delivery, and evaluation — deployed for real Oxford students running an entrance-style assessment, across 80+ test sessions in three months.

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
**AI / LLM:** Voice AI (Jambonz), OpenAI, Gemini, Claude, Google ADK, LangGraph, agent evaluation, tracing & observability (OpenTelemetry, Arize Phoenix)

**Backend:** Node.js, NestJS, TypeScript, Python, FastAPI, GraphQL, OAuth2.0/JWT

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
