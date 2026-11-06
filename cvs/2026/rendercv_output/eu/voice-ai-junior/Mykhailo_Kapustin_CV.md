# Mykhailo Kapustin's CV

- Email: [kapustinomm@gmail.com](mailto:kapustinomm@gmail.com)
- Location: EU citizen, no visa needed · Remote EU · Available now
- LinkedIn: [mykhailo-kapustin-55885612a](https://linkedin.com/in/mykhailo-kapustin-55885612a)
- GitHub: [Kapustin2000](https://github.com/Kapustin2000)


# Summary
I started programming at 15 and have worked professionally since 2016, moving from PHP/Laravel to Node.js and, in the last 3+ years, Python-based LLM systems. I've launched around 20 products and like owning them end to end, from idea to production. I write about AI architecture and test new coding agents such as Claude Code and Codex. Seeking a full-time role; open to remote EU.

# Experience
## **Full-stack Engineer and Voice-AI Engineer (Contract)**

*Remote (US)*

*Sept 2025 – Sept 2026*

*WireBee*

Voice and call-routing platform with live operator state and AI on calls.

- Integrated voice AI into live calls while keeping call control and routing decisions in the backend, with a fallback to the standard phone menu if the AI path fails.

- Built a scenario-testing framework for the voice agent that runs calls, captures transcripts and events, and checks outcomes against explicit assertions.

- Built a ring-all routing engine that calls all available operators and uses a distributed lock to ensure exactly one person claims the call, with idempotent fallback when no one answers.

- Solved a race condition where call events arrived before the platform could identify the call, using bounded buffering and replay instead of dropping unmatched events.

- Designed a synchronization model for live call and operator state: inbound events plus periodic reconciliation keep the platform's local view aligned with the external phone system, without making the UI depend on live third-party API calls.

- Stack: TypeScript, Node.js, Jambonz, Redis, MySQL



## **Full-stack Engineer and AI Engineer (Contract)**

*Berlin, Germany*

*June 2024 – Sept 2025*

*Osnova GmbH*

Multi-tenant AI agent platform for tenant-scoped agents, tools, data sources and deployments.

- Designed a registry-based contract for tools and agents so a new business onboards as configuration, not a new project; built the multi-tenant NestJS/PostgreSQL backend and React operator dashboard.

- Productionized an AI order-entry agent that turns emailed orders into ERP orders, creating them only after validation, with duplicate protection and clear status replies for cases needing review.

- Stack: Python, TypeScript, React, Node.js, NestJS, FastAPI, PostgreSQL, Azure, OpenAI, Gemini, Claude



## **Full-stack Engineer and AI Engineer (Contract)**

*Remote (US)*

*Apr 2023 – June 2024*

*Woolf*

Edtech university exam system using LLM agents for student onboarding.

- Designed and built an LLM-agent exam system on Google ADK for Woolf's higher-education onboarding — covering exam generation, delivery, and evaluation — deployed for real Oxford students running an entrance-style assessment, across 80+ test sessions in three months.

- Stack: Python, TypeScript, React, Node.js, Google ADK, Vertex AI, Gemini



# Skills
**Backend (primary):** Node.js, NestJS, Python, FastAPI, TypeScript, PostgreSQL, Docker

**Cloud Platforms:** Azure, AWS, GCP

**Frontend (used in projects):** React (Osnova operator dashboard, Woolf), Vue (earlier roles)

**AI/ML:** RAG, Anthropic, OpenAI, Google Vertex AI, Gemini, OpenRouter, LiteLLM, Model fallback/routing design, Claude Agent SDK

**Agents & Observability:** Google ADK, LangChain, LangGraph, Agent Orchestration, Agent Evaluation & Observability, OpenTelemetry, Arize Phoenix tracing, Voice AI (Jambonz)

**AI Coding Agents:** Claude Code, Codex (ChatGPT), Cursor, herdr, pi-agent, hermesagent

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
