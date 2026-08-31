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

## Stack

| Layer | Choice |
|---|---|
| Operator frontend | React, with websockets for live updates and full i18n |
| Backend | TypeScript on NestJS, DDD-layered, token auth, OpenAPI, websocket gateways, scheduling |
| Database | PostgreSQL with row-level security |
| Agent service | Python on FastAPI — authoring meta-agent, dynamic runtime, email pipeline |
| Models | Frontier reasoning models behind an explicit allow-list |
| Cloud | Managed vector/search index, message bus, blob storage, managed email, container and static hosting |

## My Role and Contributions

I worked across the platform's principal codebases: the multi-tenant backend (tenant isolation, agents, tools, data sources, deployments, the email-processing pipeline), the operator dashboard, and the agent-deployment layer that fans one definition out to three channels. I also ran the staging → production release flow, contributed the written architecture-decision practice, and authored the agent-contract and capabilities design work.

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
