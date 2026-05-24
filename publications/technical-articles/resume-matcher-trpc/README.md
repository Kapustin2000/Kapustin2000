[← Technical Articles](../README.md)

# Building a Resume Matcher with tRPC, NLP, and Vertex AI
*September 2025*

**Links:** [Hashnode](https://kapustinomm.hashnode.dev/building-a-resume-matcher-with-trpc-nlp-and-vertex-ai) | [Medium](https://medium.com/@kapustinomm/building-a-resume-matcher-with-trpc-nlp-and-vertex-ai-fec6e9896adb) | [Habr](https://habr.com/en/articles/943306/)

**Full text:** [article.md](article.md)

In this article, I share how I built a resume matcher app using tRPC, TypeScript, and Google Vertex AI. The project takes PDF resumes and job postings, extracts text, applies basic NLP for skill detection, and then calls Gemini 1.5 Flash for deeper analysis. Along the way, I explain why tRPC felt faster and cleaner than REST or GraphQL for an MVP, show code snippets from the repo, and discuss both the benefits and trade-offs of this approach.
