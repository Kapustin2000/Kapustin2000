# Construyendo un Resume Matcher con tRPC, NLP y Vertex AI

**Autor:** Mykhailo Kapustin (@kapustinomm)  
**Publicado en Habr:** 2 de septiembre de 2025  
**Dificultad:** Fácil | **Tiempo de lectura:** 6 min | **Alcance:** 7.5K

**Etiquetas:** tRPC, Type-Safe API, Resume Matcher, PDF Text Extraction, NLP, Google Vertex AI, Gemini  
**Hubs:** Google API, Google Cloud Platform, Google App Engine, Node.js, JavaScript

![Cover](images/cover/image.png)

Hace poco construí una pequeña aplicación TypeScript que compara currículums en PDF con descripciones de empleo. Necesitaba una forma rápida de prototipar una API, así que elegí **tRPC** para el backend.

tRPC es un framework RPC orientado a TypeScript que promete "end-to-end typesafe APIs": esto significa que puedo compartir tipos entre cliente y servidor sin escribir esquemas OpenAPI o GraphQL SDL. En la práctica, esto me permitió concentrarme en escribir lógica en lugar de código repetitivo.

## ¿Por qué tRPC?

A diferencia de REST o GraphQL, tRPC no proporciona un esquema universal: simplemente expone procedimientos (básicamente funciones) en el servidor que el cliente puede llamar, compartiendo directamente tipos de entrada y salida. Estaba construyendo una herramienta interna (un MVP) y ya usaba TypeScript en ambos lados. El modelo de tRPC, sin pasos de build y con tipado integrado, encajaba perfectamente.

Si cambio la entrada o salida de una función del servidor, TypeScript me avisa en el lado del cliente antes incluso de enviar una solicitud. Esto ayuda a detectar errores temprano. Con REST o GraphQL, tendría que sincronizar o generar esquemas manualmente.

## Definir el router tRPC

Con tRPC configurado, escribí un router sencillo para la operación principal: analizar dos archivos PDF subidos (un CV y una descripción de empleo). Usando tRPC con Zod-form-data, podía validar fácilmente las cargas de archivos:

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

La mutación `analyzePdfs` acepta un formulario multipart con dos archivos PDF. Después de la validación, uso `PDFService.extractText()` para extraer texto bruto de cada PDF y luego llamo a `MatcherService.match()` para el análisis. Como tRPC conoce los tipos de entrada/salida, el frontend recibe resultados totalmente tipados sin escribir DTOs adicionales.

## Extraer habilidades con NLP básico

Una vez que tuve texto limpio del CV y de la descripción de empleo, necesitaba extraer palabras clave o habilidades significativas. Lo mantuve simple: combiné `natural` para tokenización, `compromise` para etiquetado gramatical (sustantivos) y un filtro de stop words:

```typescript
private static extractSkills(text: string): Set<string> {
  const doc = nlp(text);
  const nouns = doc.nouns().out("array");
  const capitalizedWords = text.match(/\b[A-Z][a-zA-Z0-9.-]+\b/g) || [];
  return new Set([...nouns, ...capitalizedWords].map(w => w.toLowerCase()));
}
```

Este código convierte el texto a minúsculas, lo pasa por la biblioteca NLP para obtener sustantivos y usa una regex para encontrar todas las palabras con mayúscula inicial (a menudo nombres de tecnologías). La unión de estos resultados me da un conjunto candidato de "habilidades" de cada documento. Es extracción básica de palabras clave, no ML complejo, pero funciona rápido y resalta razonablemente bien las habilidades coincidentes.

## Integrar Vertex AI (Gemini 1.5 Flash) para el matching

Para la lógica central del matching, recurrí a Google Vertex AI con el nuevo modelo **Gemini 1.5 Flash**. Principalmente quería obtener resultados de comparación estructurados (puntuaciones y recomendaciones) sin implementar yo mismo lógica NLP compleja:

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

Este enfoque fue muy cómodo: Gemini entregó resultados sin que yo escribiera un algoritmo de ranking. Se sentía como usar el modelo como un "comparador de caja negra". Tuve que manejar errores y límites de tasa, pero en general la integración me permitió enfocarme en la UI y el flujo de datos en lugar de ajustar un LLM.

## Por qué tRPC encajó (y sus limitaciones)

Usar tRPC aceleró claramente el desarrollo. Sin necesidad de escribir esquemas de API, podía levantar un endpoint en minutos. Full-stack TypeScript significa que el código del router se comparte entre cliente y servidor, dándome comprobaciones en tiempo de compilación.

Por otro lado, tRPC acopla estrechamente mi frontend a esta implementación del servidor: si necesitara una API REST pública o un cliente móvil, tendría que replantear la arquitectura. También tuve que gestionar yo mismo el caching y el rate limiting (tRPC no ofrece soluciones integradas como GraphQL).

Para este proyecto, esencialmente una demo interna, estas limitaciones eran aceptables.

## Lecciones aprendidas

Construir este proyecto con APIs modernas de TypeScript fue bastante agradable. Obtuve tipado end-to-end y no tuve que mantener una biblioteca cliente separada. El código se siente muy "tipo SDK": simplemente llamo funciones en `matchRouter` como si fueran código local.

En el lado de NLP, aprendí que incluso heurísticas simples (sustantivos + palabras con mayúscula inicial) pueden funcionar bien para extraer palabras clave en casos básicos. Y finalmente, integrar Vertex AI me recordó que gran parte de la "magia de IA" puede delegarse en modelos externos con una buena ingeniería de prompts.

Pero no existe una bala de plata. Con más tiempo, mejoraría el manejo de errores alrededor del servicio de IA y añadiría caching de resultados (porque PDF-a-texto y las llamadas de IA son costosas). Si la aplicación evolucionara más, quizá reemplazaría tRPC por una API REST/GraphQL más convencional para una interfaz pública. Pero por ahora, tRPC entregó exactamente lo necesario: un MVP rápido con tipado estricto y ceremonia mínima.

## Fuentes

- [tRPC Official Site](https://trpc.io/) — Move Fast and Break Nothing. End-to-end typesafe APIs made easy.
- Viljami Kuosmanen, [Comparing REST, GraphQL & tRPC](https://dev.to/) (dev.to, Oct 2023)
- Bryant Gillespie, [REST vs. GraphQL vs. tRPC](https://directus.io/) (Directus blog, Feb 2025)

---

[← Back to articles](../README.md)
