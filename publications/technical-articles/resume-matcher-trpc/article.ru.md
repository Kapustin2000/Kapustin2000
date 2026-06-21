# Создание Resume Matcher с tRPC, NLP и Vertex AI

**Автор:** Mykhailo Kapustin (@kapustinomm)  
**Опубликовано на Habr:** 2 сентября 2025  
**Сложность:** лёгкая | **Время чтения:** 6 мин | **Охват:** 7.5K

**Теги:** tRPC, Type-Safe API, Resume Matcher, PDF Text Extraction, NLP, Google Vertex AI, Gemini  
**Хабы:** Google API, Google Cloud Platform, Google App Engine, Node.js, JavaScript

![Cover](images/cover/image.png)

Недавно я построил небольшое TypeScript-приложение, которое сравнивает PDF-резюме с описаниями вакансий. Мне нужен был быстрый способ прототипировать API, поэтому для backend я выбрал **tRPC**.

tRPC — это RPC-фреймворк, ориентированный на TypeScript, который обещает "end-to-end typesafe APIs": то есть я могу разделять типы между клиентом и сервером без написания OpenAPI или GraphQL SDL schemas. На практике это означало, что я мог сосредоточиться на логике, а не на boilerplate-коде.

## Почему tRPC?

В отличие от REST или GraphQL, tRPC не предоставляет универсальную схему — он просто публикует процедуры (по сути функции) на сервере, которые клиент может вызывать, напрямую разделяя типы входных и выходных данных. Я строил внутренний инструмент (MVP) и уже использовал TypeScript с обеих сторон. Модель tRPC без build steps и со встроенной типизацией идеально подошла.

Если я меняю input или output серверной функции, TypeScript предупредит меня на стороне клиента ещё до отправки запроса. Это помогает ловить ошибки раньше. С REST или GraphQL мне пришлось бы вручную синхронизировать или генерировать схемы.

## Определение tRPC Router

После настройки tRPC я написал простой router для основной операции: анализа двух загруженных PDF-файлов (CV и описания вакансии). Используя tRPC вместе с Zod-form-data, я мог легко валидировать загрузку файлов:

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

Мутация `analyzePdfs` принимает multipart form с двумя PDF-файлами. После валидации я использую `PDFService.extractText()`, чтобы извлечь raw text из каждого PDF, а затем вызываю `MatcherService.match()` для анализа. Поскольку tRPC знает типы input/output, frontend получает полностью типизированные результаты без дополнительных DTO.

## Извлечение навыков с помощью базового NLP

Когда у меня был чистый текст из CV и описания вакансии, нужно было извлечь значимые keywords или skills. Я оставил решение простым: объединил `natural` для токенизации, `compromise` для part-of-speech tagging (nouns) и фильтр stop words:

```typescript
private static extractSkills(text: string): Set<string> {
  const doc = nlp(text);
  const nouns = doc.nouns().out("array");
  const capitalizedWords = text.match(/\b[A-Z][a-zA-Z0-9.-]+\b/g) || [];
  return new Set([...nouns, ...capitalizedWords].map(w => w.toLowerCase()));
}
```

Этот код приводит текст к нижнему регистру, пропускает его через NLP-библиотеку для получения nouns и использует regex, чтобы найти все слова с заглавной буквы (часто это названия технологий). Объединение этих результатов даёт набор кандидатов в "skills" из каждого документа. Это базовое извлечение keywords — не сложный ML, — но оно работает быстро и неплохо подсвечивает совпадающие навыки.

## Интеграция Vertex AI (Gemini 1.5 Flash) для matching

Для основной логики сопоставления я обратился к Google Vertex AI с новой моделью **Gemini 1.5 Flash**. Главная цель была получить структурированный результат сравнения (scores и recommendations), не реализуя сложную NLP-логику самостоятельно:

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

Этот подход оказался очень удобным: Gemini выдавал результаты без необходимости писать ranking algorithm. Это ощущалось как использование модели в роли "black-box comparator". Пришлось обработать ошибки и rate limits, но в целом интеграция позволила мне сосредоточиться на UI и data flow, а не на fine-tuning LLM.

## Почему tRPC подошёл и где его ограничения

Использование tRPC заметно ускорило разработку. Без необходимости писать API-схемы я мог поднять endpoint за минуты. Full-stack TypeScript означает, что код router фактически является общим кодом для клиента и сервера, а проверки выполняются на этапе компиляции.

С другой стороны, tRPC тесно связывает frontend с этой серверной реализацией. Если бы мне понадобился публичный REST API или mobile client, архитектуру пришлось бы пересмотреть. Также caching и rate limiting нужно было реализовывать самостоятельно: tRPC не даёт встроенных решений уровня GraphQL.

Для этого проекта — по сути внутреннего demo — такие ограничения были приемлемы.

## Выводы

Строить этот проект на современных TypeScript API было довольно приятно. Я получил end-to-end typing и не должен был поддерживать отдельную client library. Код ощущается почти как SDK: я просто вызываю функции из `matchRouter`, будто это локальный код.

Со стороны NLP я понял, что даже простые эвристики (nouns + capitalized words) могут хорошо работать для извлечения keywords в базовых случаях. А интеграция Vertex AI напомнила, что значительную часть "AI magic" можно вынести во внешние модели при грамотном prompt engineering.

Но silver bullet не существует. Если бы было больше времени, я бы улучшил обработку ошибок вокруг AI-сервиса и добавил caching результатов, потому что PDF-to-text и AI calls стоят дорого. Если бы приложение развивалось дальше, я, возможно, заменил бы tRPC на более привычный REST/GraphQL API для публичного интерфейса. Но на текущем этапе tRPC дал ровно то, что было нужно: быстрый MVP со строгой типизацией и минимумом церемоний.

## Источники

- [Официальный сайт tRPC](https://trpc.io/) — Move Fast and Break Nothing. End-to-end typesafe APIs made easy.
- Viljami Kuosmanen, [Comparing REST, GraphQL & tRPC](https://dev.to/) (dev.to, Oct 2023)
- Bryant Gillespie, [REST vs. GraphQL vs. tRPC](https://directus.io/) (Directus blog, Feb 2025)

---

[← Назад к статьям](../README.md)
