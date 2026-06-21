# Як запускати LLM локально з LM Studio: повний посібник 2026

Запуск великих мовних моделей офлайн на своєму комп'ютері — без API-ключів, без хмарних залежностей і з повною приватністю.

*28 лютого 2026*

---

Мене звати Mykhailo Kapustin, я Co-Founder і CTO в Advanced Scientific Research Projects (ASRP). За останнє десятиліття я працював по всьому технологічному стеку — від frontend і backend до DevOps та AI/ML infrastructure. Нещодавно я поставив собі мету: **побудувати повністю локальний AI stack, який не залежить від корпоративних API**.

Ця стаття — частина мого ongoing research у сфері local LLM infrastructure. Після експериментів з Ollama, Claude Code і різними open-source tools я звернув увагу на **LM Studio** — desktop application, який обіцяє поєднати зручність використання й потужний local inference.

## Що таке LM Studio?

**LM Studio** — desktop application для локального й приватного запуску великих мовних моделей (LLMs). Він надає зручний GUI, а також CLI і API access для завантаження, запуску та взаємодії з open-source LLMs на власному hardware.

### Key Features

1. Integrated model management — пошук і завантаження моделей напряму з Hugging Face.
2. Chat and completion interfaces — з підтримкою structured output.
3. Embedding generation — для RAG і semantic search.
4. Tool call support — інтеграція MCP (Model Context Protocol) agents.
5. RAG capabilities — chat with your documents.
6. Vision-enabled models — через Apple MLX engine на M1/M2/M3 Mac.
7. Developer SDK — TypeScript і Python packages.
8. OpenAI-compatible REST endpoints — проста інтеграція в наявні scripts і applications.

### Архітектура

LM Studio об'єднує три шари, які в інших інструментах часто розділені:

```
┌─────────────────────────────────────────────────────────┐
│                    LM Studio Stack                       │
├─────────────────────────────────────────────────────────┤
│  Layer 3: User Interface                                │
│  • Desktop GUI (Windows, macOS, Linux)                  │
│  • CLI (lms command)                                    │
│  • Themes, split-view chat, export                      │
├─────────────────────────────────────────────────────────┤
│  Layer 2: API & SDK                                     │
│  • OpenAI-compatible REST endpoints                     │
│  • TypeScript SDK (@lmstudio/sdk)                       │
│  • Python SDK (lmstudio pip package)                    │
├─────────────────────────────────────────────────────────┤
│  Layer 1: Inference Engine                              │
│  • llama.cpp (GGUF/GGML formats)                        │
│  • Apple MLX engine (M1/M2/M3 optimization)             │
│  • GPU offloading (NVIDIA RTX)                          │
│  • Continuous batching for parallel requests            │
└─────────────────────────────────────────────────────────┘
```

### Inference Engines

**Windows і Linux:** LM Studio використовує engine **llama.cpp** з форматами моделей GGUF/GGML — зрілу й добре оптимізовану codebase з широкою сумісністю моделей, активними оновленнями спільноти та підтримкою quantization (4-bit GGUF, AWQ тощо).

**Apple Silicon (M1/M2/M3):** LM Studio також підтримує **Apple MLX engine**, об'єднуючи mlx-lm для text models і mlx-vlm для vision-enabled models. MLX спеціально оптимізований для Apple Silicon і забезпечує швидку обробку vision input.

### Headless Daemon (llmster)

Ключове архітектурне рішення в LM Studio v0.4+ — **headless daemon** під назвою `llmster`. Він відділяє GUI від inference:

```
┌─────────────────┐         ┌──────────────────┐
│  Desktop App    │ ──────► │  llmster daemon  │
│  (GUI client)   │  HTTP   │  (inference      │
│                 │  API    │   engine)        │
└─────────────────┘         └──────────────────┘
                                   │
                                   ▼
                          ┌──────────────────┐
                          │  Models in       │
                          │  memory / GPU    │
                          └──────────────────┘
```

Це дозволяє LM Studio працювати у background на server або в CI/CD pipelines, надаючи REST API навіть без GUI.

### GPU Offloading

LM Studio підтримує GPU offloading з NVIDIA RTX GPUs. Згідно з блогом NVIDIA, GPU offloading може перетворити непридатні для інтерактивної роботи 2.1 tokens/sec на Gemini 2-27B на interactive speed (~12-15 tokens/sec).

### System Requirements

| Component | Requirements |
|-----------|-------------|
| OS | macOS (Apple Silicon), Windows (x64/ARM with AVX2), Linux (x64/ARM64) |
| CPU | AVX2 support (x64) or Apple Silicon |
| RAM | 16GB+ recommended |
| GPU | Optional, 4GB+ VRAM recommended for NVIDIA RTX |
| Storage | Depends on model size (typically 4-40GB per model) |

## Setup Guide

### Installation

**Step 1:** завантажте LM Studio з [lmstudio.ai](http://lmstudio.ai) для вашої OS.

**Step 2:** встановіть CLI:

```bash
# macOS/Linux
curl -fsSL https://lmstudio.ai/cli/install.sh | bash

# Or via npm
npm install -g @lmstudio/sdk

# Or via pip
pip install lmstudio
```

**Step 3:** завантажте model:

```bash
# Using CLI
lms get qwen3-coder
```

Або через GUI: Search -> Select -> Download.

### Essential CLI Commands

```bash
lms chat         # Start a chat session
lms get <model>  # Get model information
lms list         # List downloaded models
lms serve        # Start headless server
lms status       # Check system resources
```

### API Integration

LM Studio надає OpenAI-compatible API. Ось приклад інтеграції на Python:

```python
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:1234/v1",
    api_key="lm-studio"
)

response = client.chat.completions.create(
    model="qwen3-coder",
    messages=[
        {"role": "system", "content": "You are a helpful coding assistant."},
        {"role": "user", "content": "Write a Python function for fibonacci"}
    ],
    stream=True
)

for chunk in response:
    if chunk.choices[0].delta.content:
        print(chunk.choices[0].delta.content, end="")
```

Приклад TypeScript SDK:

```typescript
import { LMStudio } from "@lmstudio/sdk";

const lms = new LMStudio("ws://localhost:1234");
const model = await lms.llm.load("qwen3-coder");

const result = await model.complete({
  prompt: "Explain quantum computing in simple terms",
  maxTokens: 500
});

console.log(result.content);
```

### Headless Server Mode

```bash
# Start the daemon
lms serve --port 1234

# Or run as a background service
nohup lms serve > lmstudio.log 2>&1 &
```

## Competitor Comparison

| Feature | LM Studio | Ollama | Open WebUI | LMDeploy |
|---------|-----------|--------|------------|----------|
| Primary Interface | Desktop GUI + CLI | CLI-focused | Web UI | Library/API |
| Inference Engine | llama.cpp + MLX | Custom + llama.cpp | Backend-agnostic | Custom (CUDA) |
| Model Formats | GGUF, GGML, MLX | GGUF, GPTQ, AWQ | Any (via backend) | AWQ, KV-quant |
| Offline Use | Full offline | Full offline | Self-hosted | Local deployment |
| GPU Offloading | NVIDIA RTX | Optional | Via backend | Multi-GPU |
| Vision Support | MLX on Apple Silicon | Limited | Via plugins | Limited |
| API Compat. | OpenAI-compatible | Custom API | OpenAI + Ollama | Custom |
| SDK Support | TypeScript, Python | CLI + REST | REST API | Python |
| MCP/Tool Calls | Built-in | Via integrations | Extensive | No |
| RAG Support | Built-in | Via integrations | Built-in | No |
| License | Proprietary (free) | MIT (CLI) | Open Source | Apache 2.0 |

## Performance Benchmarks

| Model Size | Hardware | Tokens/sec | Notes |
|-----------|----------|-----------|-------|
| 7B (4-bit) | M2 Pro | ~40-50 | Smooth interactive speed |
| 13B (4-bit) | RTX 4090 | ~30-40 | GPU fully loaded |
| 20B (4-bit) | RTX 4090 (24GB) | ~15-20 | With GPU offloading |
| 27B (4-bit) | RTX 4090 | ~8-12 | Gemini 2-27B (NVIDIA blog) |
| 70B (4-bit) | Dual RTX 4090 | ~5-8 | Requires model sharding |

**Ключовий висновок з мого тестування:** 4-bit GGUF models дають якість, близьку до FP16, за значно менших витрат пам'яті. Для більшості applications різниця в якості несуттєва.

## Висновок

LM Studio займає унікальну позицію в local LLM landscape:

1. **Для індивідуальних користувачів:** безкоштовний і polished спосіб експериментувати з local models.
2. **Для розробників:** OpenAI-compatible APIs і SDKs для інтеграції.
3. **Для підприємств:** headless deployment з Team/Enterprise plans.

**Мій вердикт:** LM Studio заслуговує місця в моєму local AI stack поруч з Ollama та іншими інструментами. У кожного є сильні сторони: LM Studio — для GUI-oriented exploration і оптимізації під Apple Silicon, Ollama — для CLI automation, Open WebUI — для web-oriented collaborative deployments.

**Що далі:** у наступній статті цієї серії я досліджу OpenHands і OpenCode — open-source environments, оптимізовані для запуску smaller models (7B-13B) зі зменшеними context windows для швидшої ітерації.

Мета лишається тією самою: побудувати complete local AI stack, де я можу розробляти agents на local models і deploy them the same way. Без корпоративних залежностей. Без API bills. Лише code і compute під моїм контролем.

---

*Мене звати Mykhailo Kapustin. Я Co-Founder і CTO в ASRP, де ми будуємо трансатлантичну дослідницьку інфраструктуру для AI, blockchain і consciousness studies. Якщо ви працюєте над local AI infrastructure або хочете обговорити agent architecture, знайдіть мене на [GitHub](https://github.com/Kapustin2000) або [LinkedIn](https://www.linkedin.com/in/mykhailo-kapustin-55885612a/).*

---

### Джерела

1. [LM Studio Official Site](https://lmstudio.ai/)
2. [LM Studio Developer Docs](https://lmstudio.ai/docs/developer)
3. [LM Studio System Requirements](https://lmstudio.ai/docs/app/system-requirements)
4. [NVIDIA Blog: Accelerating Large LLMs on RTX with LM Studio](https://blogs.nvidia.com/blog/ai-decoded-lm-studio/)
5. [LM Studio GitHub](https://github.com/lmstudio-ai)
6. [Ollama Pricing & Features](https://ollama.com/pricing)
7. [Open WebUI GitHub](https://github.com/open-webui/open-webui)
8. [LMDeploy GitHub](https://github.com/InternLM/lmdeploy)
