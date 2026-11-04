#set page(paper: "a4", margin: (x: 2.2cm, y: 2.2cm))
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 11pt)
#set par(justify: true, leading: 0.7em)
#align(center)[#text(size: 20pt, weight: "bold")[Mykhailo Kapustin] \ #v(2pt) Senior Backend Engineer (TypeScript / Python) \ #v(2pt) #text(size: 10pt)[kapustinomm\@gmail.com • linkedin.com/in/mykhailo-kapustin-55885612a • github.com/Kapustin2000]]
#v(1em)
Hi Peec team,

I'm applying for the Senior Backend Engineer role. One line in your description stood out: "design a better queueing model before lunch, ship a TypeScript service change in the afternoon." That is how I have worked for the last two years, in TypeScript and Python.

Three examples that map to what you are building:

- *Queues and failure handling.* At Osnova, agent creation took 1–30 minutes and synchronous HTTP caused gateway timeouts. I moved it to a message-bus queue with retries, dead-letter handling and lock renewal, and added per-step traces so failures were diagnosable.
- *Distributed locks and idempotency.* At WireBee I built a ring-all call router: a distributed lock guarantees exactly one winner, and the fallback fires exactly once. I also fixed a race where events arrived before the platform could identify the call, using bounded buffering and replay.
- *Cost and provider reliability.* At Woolf I cut LLM cost and latency by about 40% on Gemini and Vertex AI, and I have integrated OpenAI, Claude and Gemini behind fallbacks.

I run TypeScript services on Bun and have worked with ClickHouse for analytics, so your stack is familiar ground. The underlying problems (rate limits, flaky providers, retries, backpressure) are ones I have solved in production.

I am a Bulgarian (EU) citizen, based in Berlin, and happy to work on-site. I would be glad to walk you through any of these systems.

Best regards, \
Mykhailo Kapustin
