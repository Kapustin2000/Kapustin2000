# Mykhailo Kapustin's CV

- Email: [kapustinomm@gmail.com](mailto:kapustinomm@gmail.com)
- Location: Bulgarian EU Citizen
- LinkedIn: [mykhailo-kapustin-55885612a](https://linkedin.com/in/mykhailo-kapustin-55885612a)
- GitHub: [Kapustin2000](https://github.com/Kapustin2000)


# Summary
Senior Backend Engineer with 10+ years of experience building production backends in TypeScript/Node.js and Python (FastAPI). Recent work centers on the reliability problems behind LLM products: queues with retries and dead-letter handling, distributed locks, idempotent fallbacks, reconciliation of external systems, per-step tracing, and LLM cost/latency control across OpenAI, Gemini, and Claude. Stack: TypeScript/Node.js (NestJS), Python/FastAPI, PostgreSQL, Redis, GCP/Azure/AWS.

# Experience
## **Full-stack Engineer and Voice-AI Engineer**

*Ohio, USA*

*Sept 2025 – Sept 2026*

*WireBee · Contract*

- Built a ring-all routing engine that calls all available operators and uses a distributed lock so exactly one person claims the call, with an idempotent fallback when no one answers.

- Solved a race condition where call events arrived before the platform could identify the call, using bounded buffering and replay instead of dropping unmatched events.

- Designed a synchronization model for live call and operator state: inbound events plus periodic reconciliation keep the local view aligned with the external phone system, without making the UI depend on live third-party API calls.

- Integrated voice AI into live calls while keeping call control and routing in the backend, with a fallback to the standard phone menu if the AI path fails.

- Stack: TypeScript, Node.js, Jambonz, Redis, MySQL



## **Full-stack Engineer and AI Engineer**

*Berlin, Germany*

*June 2024 – Sept 2025*

*Osnova GmbH · Contract*

- Built the Python/FastAPI service behind agent authoring and execution, including an email-processing pipeline with a retryable state machine, running alongside the NestJS/TypeScript backend (about 45% of commits across the two core repos).

- Moved long-running agent creation (1–30 min) from synchronous HTTP requests, which caused gateway timeouts, to a message-bus queue with retries, dead-letter handling, and lock renewal; added per-step execution traces so failures are diagnosable.

- Fixed a blocking call on a shared event loop that stalled all tenants by moving I/O to a thread pool and then an async DB pool, rolled out behind feature flags and per-tenant opt-in.

- Built tenant-scoped agents, tools, data sources, and deployments, enforcing isolation with PostgreSQL row-level security and per-request tenant context.

- Owned the platform end to end, including the staging-to-production release flow across three Azure environments.

- Stack: TypeScript, Node.js, NestJS, Python, FastAPI, PostgreSQL, Azure, OpenAI, Gemini, Claude



## **Full-stack Engineer and AI Engineer**

*San Francisco, USA*

*Apr 2023 – June 2024*

*Woolf · Contract*

- Built an LLM-agent exam system on Google ADK, used by real Oxford students across 80+ test sessions; cut LLM cost and latency by ~40% through token and memory optimization.

- Stack: Python, Node.js, TypeScript, Google ADK, Vertex AI, Gemini



## **LAB325 & MOB.325, Provectus, Coelix, Ephyros, HYS Enterprise, Top Agent, PHP-academy, SuperMediaAds**

*Odesa & Kyiv, Ukraine*

*2016 – 2023*

*Earlier backend / full-stack experience*

- Team lead and backend roles across edtech, corporate, and travel/ad-tech platforms, including Node.js/GraphQL services with ClickHouse analytics, PostgreSQL, and Elasticsearch, and a service on Kubernetes (AWS, Terraform, Grafana).

- Full history: [github.com/Kapustin2000/Kapustin2000/tree/master/experience](https://github.com/Kapustin2000/Kapustin2000/tree/master/experience)



# Skills
**Languages & runtimes:** TypeScript, Node.js, Bun, Python

**Backend:** NestJS, FastAPI (async), GraphQL, queues and workers, retries, idempotency, distributed locks, webhooks

**Data:** PostgreSQL (row-level security), ClickHouse, Redis, MySQL, Elasticsearch

**Cloud & infra:** GCP, Azure, AWS, Kubernetes, Terraform, Docker

**Observability:** Per-step tracing, OpenTelemetry, Arize Phoenix, Grafana, structured logging

**LLM providers:** OpenAI, Claude, Gemini, Vertex AI, RAG, agent evaluation

**AI coding agents:** Claude Code, Codex, Cursor

# Education
## **State University of Intellectual Technologies and Communications**
*Odesa, Ukraine*


*Aug 2021 – Dec 2022*

*MSc* *in* *Automation and Computer-Integrated Technologies*



## **State University of Intellectual Technologies and Communications**
*Odesa, Ukraine*


*Sept 2017 – July 2021*

*BSc* *in* *Automation and Computer-Integrated Technologies*



# Languages
**Ukrainian / Russian:** Native

**English:** C1

**German:** A2

# Publications
## **How to Integrate Google ADK with a Custom Interface**

*2025*

Hands-on guide to wiring Google ADK agents into a custom, non-default frontend — 10,000+ reads across Medium, Habr, and Hashnode.



## **Building AI Agent Infrastructure: Three Paths from Chaos to Scalable Systems**

*2025*

How to move from a messy AI monorepo to a scalable agent ecosystem — with real examples, three architectural paths (Filesystem Registry, Package Manager, AgentOps), and lessons from building multi-agent infrastructures.



## **[Other publications](https://github.com/Kapustin2000/Kapustin2000/tree/master/publications)**

23 entries · 10 technical articles (100K+ total reads) · 7 popular science articles · 4 research papers · 1 academic paper · 1 media mention


