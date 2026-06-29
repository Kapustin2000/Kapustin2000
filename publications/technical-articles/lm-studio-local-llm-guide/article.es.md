# Cómo ejecutar LLMs localmente con LM Studio: guía completa 2026

Ejecuta grandes modelos de lenguaje sin conexión en tu computadora: sin claves de API, sin dependencias de la nube, privacidad completa

*28 de febrero de 2026*

---

Mi nombre es Mykhailo Kapustin, soy Co-Founder y CTO en Advanced Scientific Research Projects (ASRP). Durante la última década he trabajado en todo el stack tecnológico: desde frontend y backend hasta DevOps e infraestructura de AI/ML. Hace poco me fijé un objetivo: **construir un stack de IA completamente local que no dependa de APIs corporativas**.

Este artículo forma parte de mi investigación continua sobre infraestructura LLM local. Después de experimentar con Ollama, Claude Code y varias herramientas open source, centré mi atención en **LM Studio**: una aplicación de escritorio que promete combinar facilidad de uso con inferencia local potente.

## ¿Qué es LM Studio?

**LM Studio** es una aplicación de escritorio para ejecutar grandes modelos de lenguaje (LLMs) de forma local y privada. Ofrece una GUI cómoda (además de CLI y acceso API) para descargar, ejecutar e interactuar con LLMs open source en tu propio hardware.

### Funciones clave

1. Gestión integrada de modelos: buscar y descargar modelos directamente desde Hugging Face
2. Interfaces de chat y completion: con soporte para salida estructurada
3. Generación de embeddings: para RAG y búsqueda semántica
4. Soporte para tool calls: integración de agentes MCP (Model Context Protocol)
5. Capacidades RAG: chatear con tus documentos
6. Modelos con visión: mediante el motor Apple MLX en Mac M1/M2/M3
7. Developer SDK: paquetes TypeScript y Python
8. Endpoints REST compatibles con OpenAI: integración sencilla en scripts y aplicaciones existentes

### Arquitectura

LM Studio combina tres capas que a menudo están separadas en otras herramientas:

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

### Motores de inferencia

**Windows y Linux:** LM Studio usa el motor **llama.cpp** con formatos de modelo GGUF/GGML: una base de código madura, bien optimizada, con amplia compatibilidad de modelos, actualizaciones activas de la comunidad y soporte de cuantización (4-bit GGUF, AWQ, etc.).

**Apple Silicon (M1/M2/M3):** LM Studio también soporta el **motor Apple MLX**, combinando mlx-lm para modelos de texto y mlx-vlm para modelos con visión. MLX está específicamente optimizado para Apple Silicon y ofrece procesamiento rápido de entradas visuales.

### Headless Daemon (llmster)

Una decisión arquitectónica clave en LM Studio v0.4+ es el **headless daemon** llamado `llmster`. Esto separa la GUI de la inferencia:

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

Esto permite que LM Studio se ejecute en segundo plano en un servidor o en pipelines CI/CD, proporcionando una API REST incluso sin GUI.

### GPU Offloading

LM Studio soporta GPU offloading con GPUs NVIDIA RTX. Según el blog de NVIDIA, el GPU offloading puede transformar una velocidad inutilizable de 2.1 tokens/sec en Gemini 2-27B en una velocidad interactiva (~12-15 tokens/sec).

### Requisitos del sistema

| Component | Requirements |
|-----------|-------------|
| OS | macOS (Apple Silicon), Windows (x64/ARM with AVX2), Linux (x64/ARM64) |
| CPU | AVX2 support (x64) or Apple Silicon |
| RAM | 16GB+ recommended |
| GPU | Optional, 4GB+ VRAM recommended for NVIDIA RTX |
| Storage | Depends on model size (typically 4-40GB per model) |

## Guía de configuración

### Instalación

**Paso 1:** Descarga LM Studio desde [lmstudio.ai](http://lmstudio.ai) para tu sistema operativo.

**Paso 2:** Instala la CLI:

```bash
# macOS/Linux
curl -fsSL https://lmstudio.ai/cli/install.sh | bash

# Or via npm
npm install -g @lmstudio/sdk

# Or via pip
pip install lmstudio
```

**Paso 3:** Descarga un modelo:

```bash
# Using CLI
lms get qwen3-coder
```

O mediante la GUI: Search -> Select -> Download.

### Comandos CLI esenciales

```bash
lms chat         # Start a chat session
lms get <model>  # Get model information
lms list         # List downloaded models
lms serve        # Start headless server
lms status       # Check system resources
```

### Integración API

LM Studio proporciona una API compatible con OpenAI. Así puedes integrarla en Python:

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

Ejemplo con TypeScript SDK:

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

### Modo de servidor headless

```bash
# Start the daemon
lms serve --port 1234

# Or run as a background service
nohup lms serve > lmstudio.log 2>&1 &
```

## Comparación con competidores

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

## Benchmarks de rendimiento

| Model Size | Hardware | Tokens/sec | Notes |
|-----------|----------|-----------|-------|
| 7B (4-bit) | M2 Pro | ~40-50 | Smooth interactive speed |
| 13B (4-bit) | RTX 4090 | ~30-40 | GPU fully loaded |
| 20B (4-bit) | RTX 4090 (24GB) | ~15-20 | With GPU offloading |
| 27B (4-bit) | RTX 4090 | ~8-12 | Gemini 2-27B (NVIDIA blog) |
| 70B (4-bit) | Dual RTX 4090 | ~5-8 | Requires model sharding |

**Idea clave de mis pruebas:** los modelos GGUF de 4 bits alcanzan una calidad cercana a FP16 con una fracción del coste de memoria. Para la mayoría de aplicaciones, la diferencia de calidad es insignificante.

## Conclusión

LM Studio ocupa una posición única en el panorama de LLMs locales:

1. **Para usuarios individuales:** una forma gratuita y pulida de experimentar con modelos locales
2. **Para desarrolladores:** APIs y SDKs compatibles con OpenAI para integración
3. **Para empresas:** despliegue headless con planes Team/Enterprise

**Mi veredicto:** LM Studio merece un lugar en mi stack local de IA junto a Ollama y otras herramientas. Cada una tiene sus fortalezas: LM Studio para exploración orientada a GUI y optimización en Apple Silicon, Ollama para automatización CLI, y Open WebUI para despliegues colaborativos orientados a web.

**Qué sigue:** En el próximo artículo de esta serie exploraré OpenHands y OpenCode: entornos open source optimizados para ejecutar modelos más pequeños (7B-13B) con ventanas de contexto reducidas para iteraciones más rápidas.

El objetivo sigue siendo el mismo: construir un stack de IA local completo donde pueda desarrollar agentes sobre modelos locales y desplegarlos del mismo modo. Sin dependencias corporativas. Sin facturas de API. Solo código y cómputo bajo mi control.

---

*Mi nombre es Mykhailo Kapustin. Soy Co-Founder y CTO en ASRP, donde construimos infraestructura de investigación transatlántica para IA, blockchain y estudios de la conciencia. Si trabajas en infraestructura local de IA o quieres hablar sobre arquitectura de agentes, encuéntrame en [GitHub](https://github.com/Kapustin2000) o [LinkedIn](https://www.linkedin.com/in/mykhailo-kapustin-55885612a/).*

---

### Fuentes

1. [LM Studio Official Site](https://lmstudio.ai/)
2. [LM Studio Developer Docs](https://lmstudio.ai/docs/developer)
3. [LM Studio System Requirements](https://lmstudio.ai/docs/app/system-requirements)
4. [NVIDIA Blog: Accelerating Large LLMs on RTX with LM Studio](https://blogs.nvidia.com/blog/ai-decoded-lm-studio/)
5. [LM Studio GitHub](https://github.com/lmstudio-ai)
6. [Ollama Pricing & Features](https://ollama.com/pricing)
7. [Open WebUI GitHub](https://github.com/open-webui/open-webui)
8. [LMDeploy GitHub](https://github.com/InternLM/lmdeploy)
