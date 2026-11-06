# Mykhailo Kapustin's CV

- Email: [kapustinomm@gmail.com](mailto:kapustinomm@gmail.com)
- Location: EU citizen, no visa needed · Remote EU · Available now
- LinkedIn: [mykhailo-kapustin-55885612a](https://linkedin.com/in/mykhailo-kapustin-55885612a)
- GitHub: [Kapustin2000](https://github.com/Kapustin2000)


# Summary
I started programming at 15 and have worked professionally since 2016, moving from PHP/Laravel to Node.js and, in the last 3+ years, Python-based LLM systems. I've launched around 20 products and like owning them end to end, from idea to production. I write about AI architecture and test new coding agents such as Claude Code and Codex. Seeking a full-time role; open to remote EU.

# Experience
## **Senior Backend Engineer (Contract)**

*Remote (US)*

*Sept 2025 – Sept 2026*

*WireBee*

Voice and call-routing platform with live operator state and AI on calls.

- Designed a sync model for live call and operator state so the platform stays aligned with the external phone system without the UI depending on live third-party API calls.

- Fixed a race where call events arrived before the call could be identified, using bounded buffering and replay instead of dropping unmatched events.

- Built a ring-all routing engine with a distributed lock so exactly one operator claims each call, plus an idempotent fallback when no one answers.

- Integrated voice AI into live calls while keeping control and routing in the backend, with a fallback to the standard phone menu if the AI path fails.

- Stack: TypeScript, Node.js, Jambonz, Redis, MySQL



## **Senior Backend Engineer (Contract)**

*Berlin, Germany*

*June 2024 – Sept 2025*

*Osnova GmbH*

Multi-tenant AI agent platform for tenant-scoped agents, tools, data sources and deployments.

- Built backend capabilities for tenant-scoped agents, tools, data sources and deployments, with PostgreSQL row-level security and per-request tenant context.

- Moved long-running agent creation from synchronous HTTP to a queue with retries and dead-letter handling, and added per-step execution traces so failures are diagnosable.

- Owned the platform end to end across backend, frontend, cloud and AI, including the staging-to-production release flow across three Azure environments.

- Stack: Python, FastAPI, TypeScript, NestJS, Node.js, PostgreSQL, React, Azure, OpenAI, Gemini, Claude



## **Senior Backend Engineer (Contract)**

*Remote (US)*

*Apr 2023 – June 2024*

*Woolf*

Edtech university exam system using LLM agents for student onboarding.

- Designed and built an LLM-agent exam system on Google ADK for student onboarding, used by Oxford students across 80+ test sessions.

- Cut LLM cost and latency by about 40% through token and memory optimization.

- Stack: Python, Node.js, TypeScript, React, Google ADK, Vertex AI, Gemini



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
**Backend (primary):** Python, FastAPI, GraphQL, OAuth2.0/JWT

**Also used in production:** Node.js, NestJS, TypeScript

**Data:** PostgreSQL (row-level security), MySQL, Redis, ClickHouse, Elasticsearch

**Cloud Platforms:** Azure, AWS, GCP

**Infrastructure:** Docker, Nginx, microservices

**AI Integration:** OpenAI, Gemini, RAG, LangChain, LangGraph, Google ADK, Agent Evaluation, Tracing, Observability

**AI Coding Agents:** Claude Code, Codex (ChatGPT), Cursor

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
- Ukrainian / Russian: Native

- English: C1

- German: A2
