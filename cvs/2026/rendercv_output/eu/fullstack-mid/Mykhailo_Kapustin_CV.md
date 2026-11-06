# Mykhailo Kapustin's CV

- Email: [kapustinomm@gmail.com](mailto:kapustinomm@gmail.com)
- Location: EU citizen, no visa needed · Remote EU · Available now
- LinkedIn: [mykhailo-kapustin-55885612a](https://linkedin.com/in/mykhailo-kapustin-55885612a)
- GitHub: [Kapustin2000](https://github.com/Kapustin2000)


# Summary
I've been programming since the age of 15 (2015) and have worked on 20+ projects, both building new products from scratch and developing existing ones. I like taking ownership of tasks and whole projects, and I enjoy research and development. I keep deepening my expertise: I learn new technologies, tools and techniques, attend technical events, and write technical articles and research, including on AI. Seeking a full-time role; open to remote EU.

# Experience
## **Senior Full-Stack Engineer (Contract)**

*Remote (US, Ohio)*

*Sept 2025 – Sept 2026*

*WireBee, 2–10 employees, team of 4*

AI call automation and routing for freight brokerages (the company reports its voice AI agents automate 40–90% of inbound carrier calls). Owned the development end to end; worked directly with the CEO.

- Designed a sync model for live call and operator state, keeping the platform aligned with the external phone system without live third-party API calls from the UI.

- Fixed a race where call events arrived before the call could be identified, using bounded buffering and replay instead of dropping unmatched events.

- Built a ring-all routing engine with a distributed lock so exactly one operator claims each call, plus an idempotent fallback when no one answers.

- Built the voice-AI call flow and the backend behind it: the agent handles part of inbound calls end to end and collects caller details up front for the rest, with a fallback to the standard phone menu if the AI path fails.

- Stack: TypeScript, Node.js, Jambonz, Redis, MySQL



## **Senior Full-Stack Engineer (Contract)**

*Berlin, Germany (on-site)*

*June 2024 – Sept 2025*

*Osnova GmbH, 2–10 employees, team of 4*

AI agent platform (cogit): agent factories turn a business requirement into a tested, deployed agent for workflows like orders and documents (the company reports −20 h/week order processing and −96% document processing time). Owned the development end to end; worked directly with the CEO.

- Built the multi-tenant backend for agents, tools, data sources and deployments, with PostgreSQL row-level security and per-request tenant context.

- Moved long-running agent creation from synchronous HTTP to a queue with retries and dead-letter handling, and added per-step execution traces so failures are diagnosable.

- Owned the platform end to end across backend, frontend, cloud and AI, including the staging-to-production release flow across three Azure environments.

- Stack: Python, TypeScript, React, Node.js, NestJS, FastAPI, PostgreSQL, Azure, OpenAI, Gemini, Claude



## **Senior Full-Stack Engineer (Contract)**

*Remote (US, San Francisco)*

*Apr 2023 – June 2024*

*Woolf, 50–200 employees, team of 7*

Online university with accredited degrees. Owned the development end to end; worked directly with the product manager.

- Designed and built an LLM-agent exam system on Google ADK for student onboarding, used by Oxford students across 80+ test sessions.

- Cut LLM cost and latency by about 40% through token and memory optimization.

- Stack: Python, TypeScript, React, Node.js, Google ADK, Vertex AI, Gemini



# Skills
**Backend:** Node.js, NestJS, TypeScript, Python, FastAPI, GraphQL, OAuth2.0/JWT

**Frontend:** React, Vue

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
