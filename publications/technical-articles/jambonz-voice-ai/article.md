# Voice AI Systems Powered by Jambonz: From Telephony to Human–Machine Dialogue

An exploration of how telephony evolves into programmable Voice AI — from PSTN to SIP, Jambonz, and backend logic.

*October 21, 2025*

---

My name is **Mykhailo Kapustin**, CTO and Co-Founder of ASRP (Advanced Scientific Research Projects). I graduated from the **Odesa National Academy of Telecommunications named after A. S. Popov**, where I studied signal physics, frequencies, and switching principles. Today, those same principles form the foundation of Voice AI systems — where voice becomes a data stream and communication logic becomes code.

## From PSTN to SIP: The Voice Journey

Any voice call starts with a **caller** — a mobile phone, landline, or VoIP client. The signal travels through:

- **PSTN (Public Switched Telephone Network)** — the classic telephone network. Stable but not suitable for direct digital integration.
- **SIP (Session Initiation Protocol)** — converts voice to digital format for internet transmission. Manages call setup, routing, and termination.
- **SIP Trunk** — a virtual channel bridging PSTN and digital systems, converting calls into SIP sessions.

## What is Jambonz?

**Jambonz** is an open-source platform that makes phone calls programmable. It sits between the telephony network and your application, converting call events into webhooks and executing JSON instructions called **verbs**.

```
Caller → PSTN → SIP Trunk → Jambonz → Your Backend (webhooks) → AI/LLM
```

### Key Verbs

| Category | Examples | Purpose |
|----------|----------|---------|
| Call Control | `answer`, `hangup`, `redirect` | Accept, end, or redirect calls |
| Speech & Audio | `say`, `play`, `gather`, `listen`, `transcribe` | TTS, STT, audio playback |
| AI Integration | `LLM`, `Dialogflow`, `Rasa` | Connect external AI models |
| Connection | `dial`, `conference`, `enqueue` | Connect participants, conferences |

## Building a Voice AI Application

### 1. Incoming Call Handling

When a call arrives, Jambonz sends a webhook to your backend:

```javascript
app.post('/webhooks/call', (req, res) => {
  res.json([
    { verb: 'say', text: 'Hello. Please describe your request.' },
    { verb: 'gather', input: ['speech'], actionHook: '/webhooks/gather' }
  ]);
});
```

- `say` — synthesizes speech via TTS
- `gather` — enables speech recognition (STT) and waits for user input

### 2. Speech Processing with AI

The recognized speech is sent to your backend via `actionHook`. Connect any LLM (GPT, Gemini, etc.) to generate a response:

```javascript
app.post('/webhooks/gather', async (req, res) => {
  const userInput = req.body.speech.transcript;
  const reply = await ai.generate(userInput);
  res.json([
    { verb: 'say', text: reply },
    { verb: 'gather', input: ['speech'], actionHook: '/webhooks/gather' }
  ]);
});
```

This creates a **dialogue loop** — Jambonz handles voice, AI controls the conversation content.

### 3. Ending the Call

```javascript
res.json([
  { verb: 'say', text: 'Thank you for the conversation. Goodbye.' },
  { verb: 'hangup' }
]);
```

### Protocol Stack

- **SIP / RTP** — signal and audio transport
- **HTTP / WebSocket** — communication between Jambonz and your app
- **STT / TTS** — speech-to-text and text-to-speech conversion
- **LLM API** — semantic dialogue management

## Conclusion

Today we manage calls the way engineers once managed radio signals — except the schematic is now a JSON file and the antenna is an LLM model.

Every communication technology — from radio to neural interfaces — solves the same problem: to hear and be understood. Jambonz shows how old principles translate into a new context, where **voice becomes code** and code becomes part of a living conversation.

---

*Mykhailo Kapustin, Co-Founder & CTO at ASRP*

### Sources

- [Original article on Arcanum12th](https://arcanum12th.education/ru/documents/b84ee790-effe-42f8-8ae8-dba899b3650e)
- [Jambonz Official Site](https://www.jambonz.org/)
