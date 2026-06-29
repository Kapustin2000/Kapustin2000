# Einen Resume Matcher mit tRPC, NLP und Vertex AI bauen

**Autor:** Mykhailo Kapustin (@kapustinomm)  
**Veröffentlicht auf Habr:** 2. September 2025  
**Schwierigkeit:** Einfach | **Lesezeit:** 6 Min. | **Reichweite:** 7.5K

**Tags:** tRPC, Type-Safe API, Resume Matcher, PDF Text Extraction, NLP, Google Vertex AI, Gemini  
**Hubs:** Google API, Google Cloud Platform, Google App Engine, Node.js, JavaScript

![Cover](images/cover/image.png)

Vor Kurzem habe ich eine kleine TypeScript-Anwendung gebaut, die PDF-Lebensläufe mit Stellenbeschreibungen vergleicht. Ich brauchte eine schnelle Möglichkeit, eine API zu prototypisieren, also wählte ich **tRPC** für das Backend.

tRPC ist ein auf TypeScript ausgerichtetes RPC-Framework, das "end-to-end typesafe APIs" verspricht: Das bedeutet, ich kann Typen zwischen Client und Server teilen, ohne OpenAPI- oder GraphQL-SDL-Schemata zu schreiben. In der Praxis konnte ich mich dadurch auf die Logik statt auf Boilerplate-Code konzentrieren.

## Warum tRPC?

Anders als REST oder GraphQL stellt tRPC kein universelles Schema bereit: Es exponiert einfach Prozeduren (im Wesentlichen Funktionen) auf dem Server, die der Client aufrufen kann, und teilt Eingabe- und Ausgabetypen direkt. Ich baute ein internes Tool (ein MVP) und verwendete bereits TypeScript auf beiden Seiten. Das Modell von tRPC ohne Build-Schritte und mit eingebauter Typisierung passte perfekt.

Wenn ich die Eingabe oder Ausgabe einer Serverfunktion ändere, warnt mich TypeScript auf der Client-Seite, bevor ich überhaupt eine Anfrage sende. Das hilft, Fehler früh zu finden. Mit REST oder GraphQL müsste ich Schemata manuell synchronisieren oder generieren.

## Den tRPC-Router definieren

Nachdem tRPC eingerichtet war, schrieb ich einen einfachen Router für die Hauptoperation: die Analyse zweier hochgeladener PDF-Dateien (Lebenslauf und Stellenbeschreibung). Mit tRPC und Zod-form-data konnte ich Datei-Uploads leicht validieren:

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

Die Mutation `analyzePdfs` akzeptiert ein Multipart-Formular mit zwei PDF-Dateien. Nach der Validierung verwende ich `PDFService.extractText()`, um Rohtext aus jeder PDF zu extrahieren, und rufe dann `MatcherService.match()` zur Analyse auf. Da tRPC die Eingabe-/Ausgabetypen kennt, erhält das Frontend vollständig typisierte Ergebnisse, ohne zusätzliche DTOs zu schreiben.

## Skills mit einfachem NLP extrahieren

Nachdem ich sauberen Text aus Lebenslauf und Stellenbeschreibung hatte, musste ich sinnvolle Schlüsselwörter oder Skills extrahieren. Ich hielt es einfach: Ich kombinierte `natural` für Tokenisierung, `compromise` für Part-of-Speech-Tagging (Substantive) und einen Stopword-Filter:

```typescript
private static extractSkills(text: string): Set<string> {
  const doc = nlp(text);
  const nouns = doc.nouns().out("array");
  const capitalizedWords = text.match(/\b[A-Z][a-zA-Z0-9.-]+\b/g) || [];
  return new Set([...nouns, ...capitalizedWords].map(w => w.toLowerCase()));
}
```

Dieser Code wandelt den Text in Kleinbuchstaben um, schickt ihn durch die NLP-Bibliothek, um Substantive zu erhalten, und nutzt einen Regex, um alle großgeschriebenen Wörter zu finden (oft Technologienamen). Die Vereinigung dieser Ergebnisse liefert mir eine Kandidatenmenge von "Skills" aus jedem Dokument. Es ist einfache Keyword-Extraktion, kein komplexes ML, aber sie läuft schnell und hebt passende Skills ordentlich hervor.

## Vertex AI (Gemini 1.5 Flash) für das Matching integrieren

Für die Kernlogik des Matchings wandte ich mich an Google Vertex AI mit dem neuen Modell **Gemini 1.5 Flash**. Hauptsächlich wollte ich strukturierte Vergleichsergebnisse (Scores und Empfehlungen), ohne selbst komplexe NLP-Logik zu implementieren:

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

Dieser Ansatz war sehr bequem: Gemini lieferte Ergebnisse, ohne dass ich einen Ranking-Algorithmus schreiben musste. Es fühlte sich an, als würde man das Modell als "Black-Box-Komparator" verwenden. Ich musste Fehler und Rate Limits behandeln, aber insgesamt ließ mich die Integration auf UI und Datenfluss konzentrieren, statt ein LLM feinzujustieren.

## Warum tRPC passte (und wo seine Grenzen liegen)

Der Einsatz von tRPC beschleunigte die Entwicklung deutlich. Ohne API-Schemata schreiben zu müssen, konnte ich in Minuten einen Endpoint aufsetzen. Full-Stack-TypeScript bedeutet, dass der Router-Code gemeinsamer Code für Client und Server ist und mir Compile-Time-Checks gibt.

Andererseits koppelt tRPC mein Frontend eng an diese Serverimplementierung: Wenn ich eine öffentliche REST-API oder einen Mobile Client bräuchte, müsste ich die Architektur überdenken. Außerdem musste ich Caching und Rate Limiting selbst behandeln (tRPC bietet keine eingebauten Lösungen wie GraphQL).

Für dieses Projekt, im Wesentlichen eine interne Demo, waren diese Einschränkungen akzeptabel.

## Gelernte Lektionen

Dieses Projekt mit modernen TypeScript-APIs zu bauen, war ziemlich angenehm. Ich bekam End-to-End-Typisierung und musste keine separate Client-Bibliothek pflegen. Der Code fühlt sich sehr "SDK-artig" an: Ich rufe einfach Funktionen in `matchRouter` auf, als wären sie lokaler Code.

Auf der NLP-Seite lernte ich, dass selbst einfache Heuristiken (Substantive + großgeschriebene Wörter) in Basisszenarien gut für Keyword-Extraktion funktionieren können. Und schließlich erinnerte mich die Integration von Vertex AI daran, dass ein großer Teil der "KI-Magie" mit gutem Prompt Engineering an externe Modelle ausgelagert werden kann.

Aber es gibt keine Wunderlösung. Mit mehr Zeit würde ich die Fehlerbehandlung rund um den KI-Service verbessern und Ergebnis-Caching hinzufügen (da PDF-zu-Text und KI-Aufrufe teuer sind). Wenn sich die Anwendung weiterentwickeln würde, würde ich tRPC für eine öffentliche Schnittstelle vielleicht durch eine konventionellere REST/GraphQL-API ersetzen. Im Moment lieferte tRPC jedoch genau das, was nötig war: ein schnelles MVP mit strenger Typisierung und minimalem Aufwand.

## Quellen

- [tRPC Official Site](https://trpc.io/) — Move Fast and Break Nothing. End-to-end typesafe APIs made easy.
- Viljami Kuosmanen, [Comparing REST, GraphQL & tRPC](https://dev.to/) (dev.to, Oct 2023)
- Bryant Gillespie, [REST vs. GraphQL vs. tRPC](https://directus.io/) (Directus blog, Feb 2025)

---

[← Back to articles](../README.md)
