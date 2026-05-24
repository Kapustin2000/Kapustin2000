# Building a Resume Matcher with tRPC, NLP, and Vertex AI

**Author:** Mykhailo Kapustin (@kapustinomm)  
**Published on Habr:** September 2, 2025  
**Difficulty:** Easy | **Reading time:** 6 min | **Reach:** 7.5K

**Tags:** tRPC, Type-Safe API, Resume Matcher, PDF Text Extraction, NLP, Google Vertex AI, Gemini  
**Hubs:** Google API, Google Cloud Platform, Google App Engine, Node.js, JavaScript

![Cover](images/cover.png)

I recently built a small TypeScript application that compares PDF resumes against job descriptions. I needed a quick way to prototype an API, so I chose **tRPC** for the backend.

tRPC is an RPC framework oriented around TypeScript that promises "end-to-end typesafe APIs" — meaning I can share types between client and server without writing OpenAPI or GraphQL SDL schemas. In practice, this meant I could focus on writing logic rather than boilerplate code.

## Why tRPC?

Unlike REST or GraphQL, tRPC doesn't provide a universal schema — it simply exposes procedures (essentially functions) on the server that the client can call, directly sharing input and output types. I was building an internal tool (an MVP) and already using TypeScript on both sides. tRPC's model with no build steps and built-in typing was a perfect fit.

If I change the input or output of a server function, TypeScript will warn me on the client side before I even send a request. This helps catch bugs early. With REST or GraphQL, I would have to manually synchronize or generate schemas.

## Defining the tRPC Router

With tRPC set up, I wrote a simple router for the main operation: analyzing two uploaded PDF files (a CV and a job description). Using tRPC with Zod-form-data, I could easily validate file uploads:

```typescript
export const matchRouter = router({
  analyzePdfs: baseProcedure
    .input(zfd.formData({
      vacancyPdf: zfd.file().refine(file => file.type === "application/pdf", {
        message: "Only PDF files are allowed",
      }),
      cvPdf: zfd.file().refine(file => file.type === "application/pdf", {
        message: "Only PDF files are allowed",
      }),
    }))
    .mutation(async ({ input }) => {
      const [cvText, vacancyText] = await Promise.all([
        PDFService.extractText(input.cvPdf),
        PDFService.extractText(input.vacancyPdf),
      ]);
      const result = await MatcherService.match(cvText, vacancyText);
      return { matchRequestId, ...result };
    }),
});
```

The `analyzePdfs` mutation accepts a multipart form with two PDF files. After validation, I use `PDFService.extractText()` to extract raw text from each PDF, then call `MatcherService.match()` for analysis. Since tRPC knows the input/output types, the frontend gets fully typed results without writing additional DTOs.

## Extracting Skills with Basic NLP

Once I had clean text from the CV and job description, I needed to extract meaningful keywords or skills. I kept it simple: combined `natural` for tokenization, `compromise` for part-of-speech tagging (nouns), and a stop-word filter:

```typescript
private static extractSkills(text: string): Set<string> {
  const doc = nlp(text);
  const nouns = doc.nouns().out("array");
  const capitalizedWords = text.match(/\b[A-Z][a-zA-Z0-9.-]+\b/g) || [];
  return new Set([...nouns, ...capitalizedWords].map(w => w.toLowerCase()));
}
```

This code lowercases the text, runs it through the NLP library to get nouns, and uses a regex to find all capitalized words (often technology names). The union of these results gives me a candidate set of "skills" from each document. It's basic keyword extraction — not complex ML — but it works fast and does a decent job highlighting matching skills.

## Integrating Vertex AI (Gemini 1.5 Flash) for Matching

For the core matching logic, I turned to Google Vertex AI with the new **Gemini 1.5 Flash** model. This was mainly to get structured comparison results (scores and recommendations) without implementing complex NLP logic myself:

```typescript
const aiPrompt = `
Analyze the job description and candidate's CV to provide a structured evaluation.

Job Description:
${cleanedJD}

Candidate CV:
${cleanedCV}

Provide a structured analysis in JSON format with fields "score", "strengths", and "suggestions".
`;

const response = await fetch(process.env.AI_API_ENDPOINT!, {
  method: "POST",
  headers: {
    Authorization: process.env.AI_API_TOKEN,
    "Content-Type": "application/json",
  },
  body: JSON.stringify({
    contents: [{ role: "user", parts: [{ text: aiPrompt }] }]
  })
});

const data = await response.json();
const rawResponse = data.candidates[0].content.parts[0].text;
```

This approach was very convenient — Gemini delivered results without writing a ranking algorithm. It felt like using the model as a "black-box comparator." I did need to handle errors and rate limits, but overall the integration let me focus on the UI and data flow rather than fine-tuning an LLM.

## Why tRPC Fit (and Its Limitations)

Using tRPC definitely accelerated development. Without needing to write API schemas, I could spin up an endpoint in minutes. Full-stack TypeScript means the router code is shared code for both the client and server, giving me compile-time checks.

On the other hand, tRPC tightly couples my frontend to this server implementation — if I needed a public REST API or a mobile client, I'd have to rethink the architecture. I also had to handle caching and rate limiting myself (tRPC doesn't provide built-in solutions like GraphQL).

For this project — essentially an internal demo — these limitations were acceptable.

## Lessons Learned

Building this project with modern TypeScript APIs was quite pleasant. I got end-to-end typing and didn't need to maintain a separate client library. The code feels very "SDK-like": I simply call functions in `matchRouter` as if they were local code.

On the NLP side, I learned that even simple heuristics (nouns + capitalized words) can work well for keyword extraction in basic cases. And finally, integrating Vertex AI reminded me that much of the "AI magic" can be outsourced to external models with proper prompt engineering.

But there's no silver bullet. With more time, I would improve error handling around the AI service and add result caching (since PDF-to-text and AI calls are expensive). If the application evolved further, I might replace tRPC with a more conventional REST/GraphQL API for a public interface. But for now, tRPC delivered exactly what was needed: a fast MVP with strict typing and minimal ceremony.

## Sources

- [tRPC Official Site](https://trpc.io/) — Move Fast and Break Nothing. End-to-end typesafe APIs made easy.
- Viljami Kuosmanen, [Comparing REST, GraphQL & tRPC](https://dev.to/) (dev.to, Oct 2023)
- Bryant Gillespie, [REST vs. GraphQL vs. tRPC](https://directus.io/) (Directus blog, Feb 2025)

---

*Originally published on [Habr](https://habr.com/en/articles/943306/). Full source code on [GitHub](https://github.com/Kapustin2000/resume-matcher).*
