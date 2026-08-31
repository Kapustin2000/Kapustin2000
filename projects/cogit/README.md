[← All Projects](../README.md)

# Cogit — Multi-Tenant AI Agent Platform

*October 2025 – July 2026 · Completed*

**Developed at:** [Osnova GmbH](../../experience/osnova/) · delivered through [ASRP](../../experience/asrp/) as a contracting engagement

> Anonymized case study. Neither the client, its industry, nor the product is named. This page states a class of problem and the engineering approach ASRP applies to it. It does not describe the state, defects, or internal detail of any particular system: implementation specifics, data models, identifiers, source, operational history, commercial outcomes, and recordings are all excluded.

## Executive summary

A multi-tenant SaaS platform for building and running AI agents. A business operator describes an agent in plain language — its purpose, instructions, tools, knowledge — and the platform turns that description into a configured, deployable agent, which then runs across several customer-facing channels: an embeddable website chat widget, an add-in inside the user's mail client, and an autonomous email processor that works with no human in the loop. The operator never writes code.

The engineering through-line: for prose to become a deployed agent, an agent has to stop being a deployment artifact and become data with an explicit contract — something the platform can store, query, compose, isolate per tenant, and reason about without running it.

## Problem

The product thesis: small and mid-sized businesses want AI agents doing real back-office work — triaging email, reading documents, answering website visitors — but they can't staff an ML team and shouldn't have to. The answer is an operator-facing control plane: describe the job in prose, get a working agent, deploy it in one click to wherever the work arrives.

Without such a platform, standing up one agent means bespoke prompt engineering, a custom integration per channel, and a hand-rolled tenant and permissions layer for every customer. The objective was a single product in which agent definition, knowledge ingestion, tool wiring, tenant isolation and multi-channel deployment are first-class, reusable primitives — so that onboarding a new business is configuration rather than a new project.

## What was built

- **Multi-tenant control plane** — tenants, invite-only users, roles and statuses, and per-tenant data isolation enforced at the storage layer, with tenant context carried on every request.
- **Agent builder** — a guided wizard and a detail workspace (prompt, configuration, templates, schedules, sub-agents, relations) plus a live playground, all scoped to a tenant.
- **Natural-language agent authoring** — a meta-agent that decomposes a plain-text brief and dispatches specialized sub-makers into a full, validated configuration the platform can deploy.
- **Knowledge and retrieval** — file-based sources ingested and indexed, each chunk tenant-tagged, attachable to any agent for grounded answers.
- **Three deployment channels from one agent** — an embeddable website chat widget with a per-tenant branding designer, a mail-client add-in, and an autonomous email agent.
- **Email processing pipeline** — stateful, retryable inbound handling with per-tenant dynamic classification and a source-agnostic case model for tracked work items.
- **Tool integrations and secrets** — a typed tool registry with per-agent, per-tenant encrypted secrets.
- **Operational surface** — activity and audit logs, execution logs with per-step traces, scheduled work, live updates over websockets, log retention, and a documented API.
- **The agent contract** — an explicit, machine-readable definition of what an agent is.

![Cogit dashboard](dashboard.png)

## Architecture

Architecturally it is two cooperating systems: a TypeScript SaaS that owns tenants, users, agents, deployments and data, and a Python agent-authoring and execution service that generates agents from natural language and runs them. The spine runs operator dashboard → multi-tenant API → relational store with row-level isolation, with the backend delegating authoring and execution to the agent service, which scales separately. One agent definition fans out to three deployment surfaces.

```
Client surfaces                Multi-tenant API              Relational store
dashboard · web widget    →    tenant context on every  →    row-level isolation
· mail add-in                  request
                                       ↕
                                Agent service          →     Managed services
                                authoring · execution         search index · bus
                                                               · storage · mail
```

| Component | Responsibility |
|---|---|
| Operator dashboard | Build agents, manage tenants and users, configure deployments, read logs. Live updates over websockets. |
| Backend | Authoritative API. Layered domain / application / infrastructure, token auth, per-request tenant context, row-level isolation, scheduling, websocket gateways. |
| Agent service | Authoring and execution: the meta-agent, the dynamic runtime, the email pipeline. Scaled independently of the transactional tier. |
| Deployment surfaces | One agent definition, three channels: embeddable widget, mail-client add-in, autonomous email. |
| Models | Reasoning models reached only through an explicit allowlist, with no silent default. |

![AI_ORG screen-template workflow](screen-template.png)

## Hard problems

**An agent is data, not a deployment artifact.** An agent is not a set of files and not a long-lived process — it is instructions plus configuration, which is to say, data, and data belongs in a database. Making that true is the decision the rest of the platform rests on: it is what allows one runtime codebase to serve many tenants, what lets the authoring meta-agent *find* an existing agent and compose it in as a sub-agent, and what makes behaviour changeable without a deploy. Runtime code stays static; behaviour changes purely through data.

**Tenant isolation belongs in the store, and it fails quietly.** Carrying the boundary between tenants in application code makes every new code path a fresh chance to forget it; moving it into the database removes that class of mistake and introduces a subtler one. A row-level policy does not raise on a missing tenant context — it returns fewer rows, often zero, so code without context quietly does nothing while its logs report success. The design has to be paid for deliberately: with observability of its own, with a rule that a missing context is an error rather than an empty result, and with the migration a fail-closed default forces on whatever depended on the permissive one.

**Routing a message to an agent is selection over a set that changes at runtime.** This is what separates an agent platform from ordinary mail filtering. The candidates are not an enum a developer wrote down; they are rows a business operator adds at any moment, scoped to their tenant. So the agent has to declare how it can be found, the classifier's prompt becomes data assembled per tenant and per run, routing quality is bounded by the quality of those declarations, the choice has to stay stable across a conversation rather than merely correct per message, and "no agent matches" has to be a real outcome rather than a nearest-plausible guess.

**Constrain the output space, then validate what is left.** Wherever a model produces something the system must then trust — a UI response, a configuration value, a structured result — the instinct is to fix the prompt and add validation. Validation over an open-ended output space is the weak link: it rejects only what its author anticipated, and rolling back arbitrary generated output at runtime is expensive and unreliable. Narrowing what can be produced changes that — a strictly typed structure the model cannot exceed, an allow-list with an explicit migration map for deprecated values on the way in. Validation still runs; it is simply cheap and conclusive once the space it checks is small. The schema carries the guarantee, the check catches the remainder.

**An agent needs a machine-readable contract.** When agents are assembled by a generation pipeline, "what an agent is" exists only as that pipeline's output — there is no place to point at and say here is the boundary of each layer's responsibility, here is what this agent can do. The shift is from an agent as a byproduct of generation to an agent as an object with a recorded contract: a manifest that declares its actions and their properties, so the platform can reason about an agent without running it, and so approval and tool visibility stop being decisions in code and become properties of a declaration. A contract is something you can check in CI, diff between versions, and point to in a dispute over whose side broke.

**One agent loop, one owner per concern, enforced by CI.** The model→tool→model loop lives in exactly one place; the runtime hosts it rather than rewriting it. The price is a mandatory dependency and a change that touches everyone. What it buys is that guardrails cannot be bypassed — if a direct path to the model existed alongside the loop, a tool-call budget would be a suggestion rather than a constraint. Generalized: every concern has exactly one owner, and automation enforces it, because a rule that survives on a verbal agreement lasts until the first deadline and a rule that fails the build lasts longer.

## Stack

| Layer | Choice |
|---|---|
| Operator frontend | React, with websockets for live updates and full i18n |
| Backend | TypeScript on NestJS, DDD-layered, token auth, OpenAPI, websocket gateways, scheduling |
| Database | PostgreSQL with row-level security |
| Agent service | Python on FastAPI — authoring meta-agent, dynamic runtime, email pipeline |
| Models | Frontier reasoning models behind an explicit allow-list |
| Cloud | Managed vector/search index, message bus, blob storage, managed email, container and static hosting |

## Reliability & operations

- **Isolation enforced by the database** — defence in depth beyond application checks.
- **Observability** — activity and audit logs, execution logs, per-step traces, log retention.
- **Async and scheduled work** — a message bus for bursty generation and execution, plus schedules.
- **Release flow** — a staging → production promotion path, with the agent service scaled independently of the transactional platform.
- **Fail closed at the perimeter** — private endpoints with public network access disabled, as a second line of defence on top of application auth rather than instead of it. *Public access plus narrow IP rules* is the more fragile configuration in practice: narrow rules break legitimate traffic as readily as illegitimate traffic, and a private network has no such failure mode to fall back from.
- **Fail closed at tool level** — an empty allow-list means a hard scope into a sandbox, never unrestricted access. A permission system whose empty state is "allow everything" is not one.
- **Secrets as one mechanism** — per-tenant, per-agent encrypted storage with a registry of secret types and a versioned format, so key rotation is possible and a new integration's credentials are a new consumer rather than a new subsystem.

## FAQ

**Single-tenant or multi-tenant?** Multi-tenant, with isolation enforced at the database via row-level security and a per-request tenant context.

**Do operators need to code?** No — an agent is described in plain language and the platform assembles a validated, deployable configuration.

**How is one agent used across channels?** It is defined once and executed against the agent service from three surfaces: website widget, mail-client add-in, and email processor.

**How do you keep a model from writing an invalid configuration?** By making most invalid configurations unrepresentable rather than leaving a check to catch them: a typed schema the model cannot exceed, an allow-list, and a migration map for deprecated values. Validation still runs — on a small space, where it is conclusive.

**What stops an approved action from executing something else?** The approved payload is what runs, not the submitted one, and the approval is consumed only after every other gate has passed.

**Who is the client?** Not disclosed. Client identity and implementation detail are covered by confidentiality obligations that survive the engagement; what is published here is ASRP's engineering approach and the class of problem solved.

**Why are there no numbers?** Because none were measured on production-scale traffic during the engagement. Adoption, latency and commercial figures are the client's to publish, not ASRP's, and inventing them would be worse than their absence.

## My Role and Contributions

ASRP worked across the platform's principal codebases: the multi-tenant backend (tenant isolation, agents, tools, data sources, deployments, the email-processing pipeline), the operator dashboard, and the agent-deployment layer that fans one definition out to three channels. ASRP also ran the staging → production release flow, contributed the written architecture-decision practice, and authored the agent-contract and capabilities design work described above.

- #1 contributor across both core repositories (~45% of commits each) and owned the staging → production release flow across three Azure environments
- Built the multi-tenant NestJS backend — DDD layering, JWT/tenant-context auth, PostgreSQL row-level security, Prisma schema/migrations, WebSocket gateways, cron scheduling
- Built the React admin dashboard — agent builder, Test playground, tenant/user management, deployment configuration including the widget branding designer
- Implemented the multi-channel deployment layer — website widget, Outlook add-in, and the stateful, dynamically-classified email-processing pipeline
- Integrated the Azure surface (AI Search, Service Bus, Blob Storage, Communication Email) and the Python `ai_org` agent-authoring/execution service as the generation backend
- Designed and implemented the core registry abstractions for tools and agents behind `ai_org`, and the dynamic agent orchestration and email-processing pipeline it runs
- Authored the agent-contract and capabilities design work — the manifest layer that lets the platform reason about an agent without running it

---

Meta: [meta.yaml](meta.yaml)

[← All Projects](../README.md)
