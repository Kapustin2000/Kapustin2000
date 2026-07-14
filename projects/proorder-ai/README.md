[← All Projects](../README.md)

# ProOrder AI — Email-to-ERP Order Automation

*December 2025 – March 2026 · Completed*

**Developed at:** [Osnova GmbH](../../experience/osnova/) · delivered through [ASRP](../../experience/asrp/) as a contracting engagement

**Project Overview:**  
ProOrder AI is a production system that removes manual order entry from a manufacturer's sales-support desk. Customers email purchase orders — almost always a German-language PDF, occasionally several per email — and the system reads them, matches every line against the manufacturer's Business Central catalog, and creates a validated sales order without a human retyping anything. It then attaches the source document to the created order and forwards a plain-language German status message: what was created, what partially failed, and exactly which field or article blocked the rest.

The hard part isn't calling an LLM on a PDF — it's the enterprise reality in between: purchase-order tables whose rows wrap across visual lines, customer article numbers that don't match the manufacturer's internal item numbers, and a Business Central catalog where the same customer reference can point at both a **blocked** (retired) record and a live one — while the import API gives no clean way to say which one you meant. The system is built to survive that messiness deterministically and to escalate to a human — never guess — when it can't.

## Key Features

- **Unattended mailbox worker** – Polls a shared Outlook mailbox via Microsoft Graph, deduplicates against a local SQLite queue, and filters own-domain senders and automatic replies
- **Document extraction** – Sends the raw PDF to Anthropic Claude (`temperature=0`) with a heavily engineered extraction prompt pulling customer, order metadata, and a full product table into a strict JSON schema
- **Blocked/ambiguous item resolution** – A layered search (exact → generated code variations → core-identifier match → write-time recovery) that prefers unblocked catalog records and recovers from Business Central rejecting a blocked reference at write time
- **Customer matching** – A graceful-degradation cascade (VAT → postcode+country → fuzzy name) tuned with different confidence thresholds per tier, since a false-positive customer match is worse than a clean escalation
- **Multi-plant support** – One deployment serves several Business Central company entities, plus one plant routed to a SharePoint Excel workbook instead of the ERP

## Engineering highlight — the blocked-item write-time recovery

Business Central stores customer article references, and the *same* reference can exist as both a blocked (retired) record and a live one. The import API accepts only the customer's reference number — not the internal item number — so even when the pipeline has correctly identified the live item, it can't tell the ERP "use this exact record": Business Central re-resolves the reference at write time and can still pick the blocked one, failing the whole order. The fix layers resolution (exact match → formatting variations → core-identifier search, each preferring unblocked hits) and adds a write-time recovery path: if creation still fails on a recognized blocked-item error, the code parses the offending reference out of the German error text, finds an unblocked sibling sharing the same internal item number, swaps it into the order payload, and retries the create exactly once — never blindly, and never more than once.

## My Role and Contributions

- #1 contributor in the productionization-and-accuracy window (Dec 2025 – Mar 2026) — 28 of 28 commits, the only development activity in that window
- Ran the opening diagnostic that isolated the two dominant failure classes (customer matching and article-number matching) and set the roadmap for the rest of the engagement
- Engineered the item-resolution and blocked-item write-time recovery engine described above
- Hardened customer matching into the three-tier VAT → postcode+country → fuzzy-name cascade
- Authored customer-specific extraction rules, including a buyer/supplier role-detection fix that cut a recurring misattribution from ~73% to 0% across 100 production re-runs
- Built the go-live and debugging tooling — batch email-replay harness, logging layer, and deployment hardening (multi-stage Docker image)

---

Meta: [meta.yaml](meta.yaml)

[← All Projects](../README.md)
