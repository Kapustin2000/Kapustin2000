# Как запускать LLM локально с LM Studio: полное руководство 2026

Запуск больших языковых моделей офлайн на своём компьютере — без API-ключей, без облачных зависимостей и с полной приватностью.

*28 февраля 2026*

---

Меня зовут Mykhailo Kapustin, я Co-Founder и CTO в Advanced Scientific Research Projects (ASRP). За последнее десятилетие я работал по всему технологическому стеку — от frontend и backend до DevOps и AI/ML infrastructure. Недавно я поставил себе цель: **построить полностью локальный AI stack, который не зависит от корпоративных API**.

Эта статья — часть моего ongoing research в области local LLM infrastructure. После экспериментов с Ollama, Claude Code и различными open-source tools я обратил внимание на **LM Studio** — desktop application, которое обещает объединить удобство использования и мощный local inference.

## Что такое LM Studio?

**LM Studio** — desktop application для локального и приватного запуска больших языковых моделей (LLMs). Оно предоставляет удобный GUI, а также CLI и API access для загрузки, запуска и взаимодействия с open-source LLMs на собственном hardware.

### Key Features

1. Integrated model management — поиск и загрузка моделей напрямую с Hugging Face.
2. Chat and completion interfaces — с поддержкой structured output.
3. Embedding generation — для RAG и semantic search.
4. Tool call support — интеграция MCP (Model Context Protocol) agents.
5. RAG capabilities — chat with your documents.
6. Vision-enabled models — через Apple MLX engine на M1/M2/M3 Mac.
7. Developer SDK — TypeScript и Python packages.
8. OpenAI-compatible REST endpoints — простая интеграция в существующие scripts и applications.

### Архитектура

LM Studio объединяет три слоя, которые в других инструментах часто разделены:

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

**Windows и Linux:** LM Studio использует engine **llama.cpp** с форматами моделей GGUF/GGML — зрелую и хорошо оптимизированную codebase с широкой совместимостью моделей, активными обновлениями сообщества и поддержкой quantization (4-bit GGUF, AWQ и т. д.).

**Apple Silicon (M1/M2/M3):** LM Studio также поддерживает **Apple MLX engine**, объединяя mlx-lm для text models и mlx-vlm для vision-enabled models. MLX специально оптимизирован для Apple Silicon и обеспечивает быструю обработку vision input.

### Headless Daemon (llmster)

Ключевое архитектурное решение в LM Studio v0.4+ — **headless daemon** под названием `llmster`. Он отделяет GUI от inference:

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

Это позволяет LM Studio работать в background на server или в CI/CD pipelines, предоставляя REST API даже без GUI.

### GPU Offloading

LM Studio поддерживает GPU offloading с NVIDIA RTX GPUs. Согласно блогу NVIDIA, GPU offloading может превратить непригодные для интерактивной работы 2.1 tokens/sec на Gemini 2-27B в interactive speed (~12-15 tokens/sec).

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

**Step 1:** скачайте LM Studio с [lmstudio.ai](http://lmstudio.ai) для вашей OS.

**Step 2:** установите CLI:

```bash
# macOS/Linux
curl -fsSL https://lmstudio.ai/cli/install.sh | bash

# Or via npm
npm install -g @lmstudio/sdk

# Or via pip
pip install lmstudio
```

**Step 3:** скачайте model:

```bash
# Using CLI
lms get qwen3-coder
```

Или через GUI: Search -> Select -> Download.

### Essential CLI Commands

```bash
lms chat         # Start a chat session
lms get <model>  # Get model information
lms list         # List downloaded models
lms serve        # Start headless server
lms status       # Check system resources
```

### API Integration

LM Studio предоставляет OpenAI-compatible API. Вот пример интеграции на Python:

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

Пример TypeScript SDK:

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

**Ключевой вывод из моего тестирования:** 4-bit GGUF models дают качество, близкое к FP16, при значительно меньших затратах памяти. Для большинства applications разница в качестве несущественна.

## Заключение

LM Studio занимает уникальную позицию в local LLM landscape:

1. **Для индивидуальных пользователей:** бесплатный и polished способ экспериментировать с local models.
2. **Для разработчиков:** OpenAI-compatible APIs и SDKs для интеграции.
3. **Для предприятий:** headless deployment с Team/Enterprise plans.

**Мой вердикт:** LM Studio заслуживает места в моём local AI stack рядом с Ollama и другими инструментами. У каждого есть сильные стороны: LM Studio — для GUI-oriented exploration и оптимизации под Apple Silicon, Ollama — для CLI automation, Open WebUI — для web-oriented collaborative deployments.

**Что дальше:** в следующей статье этой серии я изучу OpenHands и OpenCode — open-source environments, оптимизированные для запуска smaller models (7B-13B) с уменьшенными context windows для более быстрой итерации.

Цель остаётся прежней: построить complete local AI stack, где я могу разрабатывать agents на local models и deploy them the same way. Без корпоративных зависимостей. Без API bills. Только code и compute под моим контролем.

---

*Меня зовут Mykhailo Kapustin. Я Co-Founder и CTO в ASRP, где мы строим трансатлантическую исследовательскую инфраструктуру для AI, blockchain и consciousness studies. Если вы работаете над local AI infrastructure или хотите обсудить agent architecture, найдите меня на [GitHub](https://github.com/Kapustin2000) или [LinkedIn](https://www.linkedin.com/in/mykhailo-kapustin-55885612a/).*

---

### Источники

1. [LM Studio Official Site](https://lmstudio.ai/)
2. [LM Studio Developer Docs](https://lmstudio.ai/docs/developer)
3. [LM Studio System Requirements](https://lmstudio.ai/docs/app/system-requirements)
4. [NVIDIA Blog: Accelerating Large LLMs on RTX with LM Studio](https://blogs.nvidia.com/blog/ai-decoded-lm-studio/)
5. [LM Studio GitHub](https://github.com/lmstudio-ai)
6. [Ollama Pricing & Features](https://ollama.com/pricing)
7. [Open WebUI GitHub](https://github.com/open-webui/open-webui)
8. [LMDeploy GitHub](https://github.com/InternLM/lmdeploy)
