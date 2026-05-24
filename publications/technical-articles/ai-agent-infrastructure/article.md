# Building AI Agent Infrastructure: Three Paths from Chaos to Scalable Systems

How to move from a messy AI monorepo to a scalable agent ecosystem — with real examples, three architectural paths, and lessons from building multi-agent infrastructures.

*October 25, 2025*

---

My name is **Mykhailo Kapustin**, Co-Founder & CTO at ASRP (Advanced Scientific Research Projects). This article was co-authored with **Kyryl Zmiienko, Senior Artificial Intelligence Engineer (AI/ML) at ASRP**, whose advice and technical vision played a key role in shaping the proposed solutions.

## The Problem

Recently a client approached ASRP with a familiar challenge. Over years of work in the German market, they had developed an extensive set of internal tools — from libraries for PDF processing, image and data handling to automation and analysis systems. Their team was actively adopting agent technologies and wanted to make these tools available to AI agents as composable modules.

For quick start, the client created a single large **monorepo** containing both agents and tools. Agents could communicate locally and use tools from neighboring directories. When creating a new agent, they simply copied needed tools into its directory.

This approach does not scale:

1. No **unified tool registry** — no way to see what tools exist
2. No **agent directory** — each agent lived in isolation
3. New agents required **constant code copying**, bloating the repo
4. No **version control** for tools — hard to maintain and evolve

## Three Architectural Paths

After detailed analysis of the client's data and project structure, I developed three strategic lines of development:

### Path 1: Filesystem Registry with Lazy Loading

A lightweight, fast path to stabilize the existing monorepo. Automatic tool indexing with a manual manifest enables quick updates and prepares the system for future growth.

```
project_root/
├── agents/
│   ├── researcher/
│   │   ├── main.py
│   │   └── config.yaml
│   └── summarizer/
│       └── main.py
├── tools/
│   ├── extract_pdf.py
│   ├── search_web.py
│   └── system_file.py
└── registries/
    ├── tool_registry.py
    └── agent_registry.py
```

**Simple Tool Registry Example:**

```python
from pathlib import Path
import importlib.util, json

class ToolRegistry:
    def __init__(self, path="tools", cache=".cache/tools_index.json"):
        self.path = Path(path)
        self.cache = Path(cache)
        self.index = {}

    def scan(self):
        tools = {}
        for file in self.path.glob("*.py"):
            name = file.stem
            tools[name] = {"file_path": str(file), "mtime": file.stat().st_mtime}
        self.index = tools
        self.cache.parent.mkdir(parents=True, exist_ok=True)
        json.dump({"tools": tools}, open(self.cache, "w"), indent=2)
        return tools

    def load(self, tool_name):
        entry = self.index.get(tool_name)
        if not entry:
            raise KeyError(f"Tool {tool_name} not found")
        spec = importlib.util.spec_from_file_location(tool_name, entry["file_path"])
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        return module
```

Agents can now load only what they need:

```python
from registries.tool_registry import ToolRegistry

registry = ToolRegistry()
registry.scan()
pdf_tool = registry.load("extract_pdf")
pdf_tool.run("document.pdf")
```

**Pros:** No CI/CD needed, works out of the box for local setups and pilots.  
**Cons:** Minimal version control — updating a tool instantly affects all agents; rollback is manual.

### Path 2: Package Manager & Modular Tool Ecosystem

Tools become **packages** — independent modules with their own version, documentation, and lifecycle. Instead of endless copying, tools are extracted into domain-specific packages (`pdf-toolset`, `image-processing`, `data-analysis`) and connected via an internal package manager.

Each agent gets a configuration file (`package.json` or `requirements.txt`) declaring its dependencies. On initialization, the agent pulls the exact versions from the internal package registry.

**Pros:**
- End of code duplication and manual updates
- Transparent dependencies and version control
- Reduced risk of unpredictable breakage
- Architectural flexibility for phased evolution

**Cons:** Requires real engineering work — extracting tools, setting up internal registry, updating CI/CD, adapting agents.

### Path 3: AgentOps Infrastructure (MCP & A2A)

The highest maturity level — agents operate not as modules inside a monolith but as **autonomous services** communicating via open standards.

**MCP (Model Context Protocol):** Open standard allowing LLMs and agents to connect to external data sources, tools, and APIs. A unified format for agent-tool communication.

**A2A (Agent-to-Agent):** Enables agents to interact and collaborate — delegate tasks, build joint action chains, even work with agents built on different frameworks.

**Pros:**
- No need to keep everything in one monolith
- Independent teams per agent or business domain
- Easy model and tool versioning with rollbacks
- True scalability — microservice-like architecture
- Cross-company integration possible

**Cons:** Requires DevOps practices, CI/CD, containerization, orchestration systems.

## Conclusion

Every agent ecosystem passes through three stages:

1. **Filesystem Registry** — good for MVP
2. **Package Manager** — controlled order with modules, registries, versions (MLP)
3. **AgentOps (MCP & A2A)** — intelligent infrastructure where agents are scalable, interacting services (Enterprise)

AgentOps is not a buzzword — it is the natural endpoint of system maturity. Companies that reach this level create not just manageable code but an **AI ecosystem** where agents grow with the business.

---

*Mykhailo Kapustin, Co-Founder & CTO at ASRP*  
*Kyryl Zmiienko, Senior AI/ML Engineer at ASRP*

---

### Sources

- [Original article on Arcanum12th](https://arcanum12th.education/ru/documents/529d51a0-5d82-4b3f-b8ea-7ea06c9955f0)
- [MCP Specification](https://modelcontextprotocol.io/)
- [A2A Protocol](https://github.com/google/A2A)
