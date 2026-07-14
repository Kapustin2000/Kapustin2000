[← All Projects](../README.md)

# Cogit SaaS — Agent Operations Platform

*October 2025 – March 2026 · Completed*

**Developed at:** [Osnova GmbH](../../experience/osnova/) · delivered through [ASRP](../../experience/asrp/) as a contracting engagement

**Project Overview:**  
Cogit is a multi-tenant SaaS platform for building and running "AI organizations" — an admin dashboard where a business operator defines an AI agent (its purpose, instructions, tools, and knowledge base) in plain language, then deploys that same agent across an embeddable website chat widget, an Outlook add-in, and an autonomous email processor. The operator never writes code.

Architecturally it's two cooperating systems: a TypeScript SaaS (NestJS backend + React admin dashboard) that owns tenants, users, agents, deployments, and data, and a Python agent-authoring/execution service that generates agents from natural language and runs them. Agent reasoning runs on Google Gemini and Anthropic Claude; the surrounding infrastructure is Azure-native (AI Search for RAG, Service Bus, Blob Storage, Communication Email, Container Apps).

![Cogit SaaS dashboard](dashboard.png)

## Key Features

- **Multi-tenant control plane** – Tenant isolation enforced at the database layer via PostgreSQL row-level security (`FORCE ROW LEVEL SECURITY`), with tenant identity carried on every request from the JWT
- **Agent builder** – A guided wizard plus a detail workspace (prompt, config, templates, schedules) and a live Test playground scoped to a tenant
- **AgentMaker (natural language → agent)** – A Python meta-agent that decomposes a plain-text brief and dispatches specialized sub-makers into a full, validated agent configuration in roughly a minute
- **Three deployment channels from one agent** – Website chat widget, Outlook add-in, and an autonomous email agent that classifies inbound mail per-tenant and routes it accordingly
- **Knowledge / RAG** – File-based data sources ingested into Azure AI Search, tenant-tagged and attachable to any agent

## Engineering highlight — multi-tenancy that fails safe

One database, many businesses, and the isolation guarantee can't hinge on every query author remembering `WHERE tenantId = ?`. Tenant identity rides in the JWT, a per-request interceptor lifts it into an `AsyncLocalStorage` context, and every tenant table carries `FORCE ROW LEVEL SECURITY` — so the boundary holds even for the table owner and even when an application query forgets to filter. Jobs that legitimately cross tenants (retention sweeps, cron fan-out) run through explicit `SECURITY DEFINER` functions on a separate connection rather than weakening the policies. RLS coverage was extended as the schema grew (email processing, execution logs), and the tenant-setting call was hardened into a parameterized `set_config` so the guarantee tracks the model instead of lagging behind it.

## My Role and Contributions

- #1 contributor across both core repositories (~45% of commits each) and owned the staging → production release flow across three Azure environments
- Built the multi-tenant NestJS backend — DDD layering, JWT/tenant-context auth, PostgreSQL row-level security, Prisma schema/migrations, WebSocket gateways, cron scheduling
- Built the React admin dashboard — agent builder, Test playground, tenant/user management, deployment configuration including the widget branding designer
- Implemented the multi-channel deployment layer — website widget, Outlook add-in, and the stateful, dynamically-classified email-processing pipeline
- Integrated the Azure surface (AI Search, Service Bus, Blob Storage, Communication Email) and the Python `ai_org` agent-authoring/execution service as the generation backend

---

Meta: [meta.yaml](meta.yaml)

[← All Projects](../README.md)
