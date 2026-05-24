# How to Run LLMs Locally with LM Studio: Complete Guide 2026

Run Large Language Models Offline on Your Computer — No API Keys, No Cloud Dependencies, Complete Privacy

*February 28, 2026*

---

My name is Mykhailo Kapustin, I am the Co-Founder and CTO at Advanced Scientific Research Projects (ASRP). Over the last decade I've worked across the entire technology stack — from frontend and backend to DevOps and AI/ML infrastructure. Recently I set myself a goal: **build a completely local AI stack that does not depend on corporate APIs**.

This article is part of my ongoing research into local LLM infrastructure. After experimenting with Ollama, Claude Code, and various open-source tools, I turned my attention to **LM Studio** — a desktop application that promises to combine ease of use with powerful local inference.

## What is LM Studio?

**LM Studio** is a desktop application for running large language models (LLMs) locally and privately. It provides a convenient GUI (plus CLI and API access) for downloading, running, and interacting with open-source LLMs on your own hardware.

### Key Features

1. Integrated model management — search and download models directly from Hugging Face
2. Chat and completion interfaces — with structured output support
3. Embedding generation — for RAG and semantic search
4. Tool call support — MCP (Model Context Protocol) agent integration
5. RAG capabilities — chat with your documents
6. Vision-enabled models — via Apple MLX engine on M1/M2/M3 Mac
7. Developer SDK — TypeScript and Python packages
8. OpenAI-compatible REST endpoints — simple integration into existing scripts and applications

### Architecture

LM Studio combines three layers that are often separated in other tools:

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

**Windows and Linux:** LM Studio uses the **llama.cpp** engine with GGUF/GGML model formats — a mature, well-optimized codebase with broad model compatibility, active community updates, and quantization support (4-bit GGUF, AWQ, etc.).

**Apple Silicon (M1/M2/M3):** LM Studio also supports the **Apple MLX engine**, combining mlx-lm for text models and mlx-vlm for vision-enabled models. MLX is specifically optimized for Apple Silicon, providing fast vision input processing.

### Headless Daemon (llmster)

A key architectural decision in LM Studio v0.4+ is the **headless daemon** called `llmster`. This separates the GUI from inference:

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

This allows LM Studio to run in the background on a server or in CI/CD pipelines, providing a REST API even without a GUI.

### GPU Offloading

LM Studio supports GPU offloading with NVIDIA RTX GPUs. According to NVIDIA's blog, GPU offloading can transform an unusably slow 2.1 tokens/sec on Gemini 2-27B into interactive speed (~12-15 tokens/sec).

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

**Step 1:** Download LM Studio from [lmstudio.ai](http://lmstudio.ai) for your OS.

**Step 2:** Install the CLI:

```bash
# macOS/Linux
curl -fsSL https://lmstudio.ai/cli/install.sh | bash

# Or via npm
npm install -g @lmstudio/sdk

# Or via pip
pip install lmstudio
```

**Step 3:** Download a model:

```bash
# Using CLI
lms get qwen3-coder
```

Or via GUI: Search -> Select -> Download.

### Essential CLI Commands

```bash
lms chat         # Start a chat session
lms get <model>  # Get model information
lms list         # List downloaded models
lms serve        # Start headless server
lms status       # Check system resources
```

### API Integration

LM Studio provides an OpenAI-compatible API. Here is how to integrate it in Python:

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

TypeScript SDK example:

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

**Key insight from my testing:** 4-bit GGUF models achieve near-FP16 quality at a fraction of the memory cost. For most applications, the quality difference is negligible.

## Conclusion

LM Studio occupies a unique position in the local LLM landscape:

1. **For individual users:** A free, polished way to experiment with local models
2. **For developers:** OpenAI-compatible APIs and SDKs for integration
3. **For enterprises:** Headless deployment with Team/Enterprise plans

**My verdict:** LM Studio earns a place in my local AI stack alongside Ollama and other tools. Each has strengths — LM Studio for GUI-oriented exploration and Apple Silicon optimization, Ollama for CLI automation, and Open WebUI for web-oriented collaborative deployments.

**What's next:** In the next article in this series, I will explore OpenHands and OpenCode — open-source environments optimized for running smaller models (7B-13B) with reduced context windows for faster iteration.

The goal remains the same: build a complete local AI stack where I can develop agents on local models and deploy them the same way. No corporate dependencies. No API bills. Just code and compute under my control.

---

*My name is Mykhailo Kapustin. I am Co-Founder and CTO at ASRP, where we build transatlantic research infrastructure for AI, blockchain, and consciousness studies. If you are working on local AI infrastructure or want to discuss agent architecture, find me on [GitHub](https://github.com/Kapustin2000) or [LinkedIn](https://www.linkedin.com/in/mykhailo-kapustin-55885612a/).*

---

### Sources

1. [LM Studio Official Site](https://lmstudio.ai/)
2. [LM Studio Developer Docs](https://lmstudio.ai/docs/developer)
3. [LM Studio System Requirements](https://lmstudio.ai/docs/app/system-requirements)
4. [NVIDIA Blog: Accelerating Large LLMs on RTX with LM Studio](https://blogs.nvidia.com/blog/ai-decoded-lm-studio/)
5. [LM Studio GitHub](https://github.com/lmstudio-ai)
6. [Ollama Pricing & Features](https://ollama.com/pricing)
7. [Open WebUI GitHub](https://github.com/open-webui/open-webui)
8. [LMDeploy GitHub](https://github.com/InternLM/lmdeploy)
