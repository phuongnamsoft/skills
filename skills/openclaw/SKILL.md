---
name: openclaw
description: Use when installing, configuring, operating, or extending OpenClaw — the self-hosted Gateway that connects Discord, Slack, Telegram, WhatsApp, iMessage, Signal, Matrix, Teams, and other chat channels to AI coding agents. Covers Gateway setup, agent runtime, channels, model providers, tools/skills/plugins, memory, automation, sandboxing, and security.
---

# OpenClaw

## Overview

OpenClaw is a **self-hosted gateway** that connects messaging platforms
(Discord, Google Chat, iMessage, Matrix, Microsoft Teams, Signal, Slack,
Telegram, WhatsApp, Zalo, and 25+ more) to AI agents. You run **one Gateway
process** on your own machine and message your AI assistant from anywhere.

Core mental model:
- **Gateway** — a single long-lived daemon (default `127.0.0.1:18789`) that owns
  every messaging surface, provider connection, and the WebSocket control-plane
  API. One Gateway per host.
- **Agent runtime** — the loop that turns an inbound message into a model turn
  with tools, a workspace, and a session.
- **Channels** — the chat platforms wired into the Gateway (each has access
  controls / pairing).
- **Providers** — LLM backends (Anthropic, OpenAI, Google, local, 60+ total)
  referenced as `provider/model`.
- **Tools / Skills / Plugins** — tools are callable actions; skills are
  `SKILL.md` instruction packs; plugins add runtime capabilities (tools,
  providers, channels, hooks).
- **Nodes** — paired devices (macOS/iOS/Android/headless) that expose camera,
  screen, location, canvas, and notifications.

**This is a reference skill.** The `references/` directory holds verbatim
copies of the core docs pages. Read the relevant file before answering, and
fetch additional pages on demand (see "Fetching more docs" below).

## When to Use

- Installing OpenClaw or choosing a deploy target (Docker, VPS, cloud, macOS app)
- Configuring the Gateway: models, channels, tools, sandbox, auth
- Connecting or troubleshooting a chat channel
- Choosing/authenticating a model provider
- Writing an OpenClaw workspace skill (`SKILL.md`) or building a plugin
- Setting up memory, automation (cron/hooks/tasks/standing orders), or sandboxing
- Hardening or reasoning about the security/threat model

**Not for:** Anthropic Claude Code / Claude API questions (those are unrelated
to OpenClaw despite the name), or generic chatbot builds not using OpenClaw.

## Quick Start

```bash
# Install (macOS / Linux)
curl -fsSL https://openclaw.ai/install.sh | bash

# Onboard (choose provider, set API key, install daemon)
openclaw onboard --install-daemon

# Verify + open the Control UI
openclaw gateway status       # Gateway listens on :18789
openclaw dashboard
```

Requires Node.js 22.19+/23.11+/24+ and a provider API key. Windows users:
prefer the native Windows Hub app. Full path: [getting-started.md](references/getting-started.md).

## Reference Map

Local copies live in `references/` (mirrored verbatim from the docs). Read the
one matching the task. Core pages are top-level; the long tail is grouped into
subfolders (`channels/`, `providers/`, `tools/`, `plugins/`, `concepts/`,
`cli/`, `install/`, `gateway/`, `automation/`, `help/`).

### Core

| Topic | Local file | Live docs |
| --- | --- | --- |
| First run / quick setup | [getting-started.md](references/getting-started.md) | `/start/getting-started` |
| Personal-assistant end-to-end setup | [personal-assistant-setup.md](references/personal-assistant-setup.md) | `/start/openclaw` |
| Install methods (Docker, npm, cloud, source) | [install.md](references/install.md) | `/install` |
| Gateway architecture (WS protocol, clients, nodes) | [architecture.md](references/architecture.md) | `/concepts/architecture` |
| Agent runtime, workspace, session bootstrap | [agent-runtime.md](references/agent-runtime.md) | `/concepts/agent` |
| Chat channels overview | [channels.md](references/channels.md) | `/channels` |
| Configuration (common tasks + quick setup) | [configuration.md](references/configuration.md) | `/gateway/configuration` |
| Full config key reference | [configuration-reference.md](references/configuration-reference.md) | `/gateway/configuration-reference` |
| Security & threat model | [security.md](references/security.md) | `/gateway/security` |
| Sandboxing (modes, scopes, workspace access) | [sandboxing.md](references/sandboxing.md) | `/gateway/sandboxing` |
| Tools / skills / plugins overview | [tools-overview.md](references/tools-overview.md) | `/tools` |
| Skills: loading, precedence, gating | [skills.md](references/skills.md) | `/tools/skills` |
| Creating workspace skills (SKILL.md) | [creating-skills.md](references/creating-skills.md) | `/tools/creating-skills` |
| Model providers directory | [providers.md](references/providers.md) | `/providers` |
| Building plugins | [building-plugins.md](references/building-plugins.md) | `/plugins/building-plugins` |
| Memory (built-in, Honcho, LanceDB, QMD) | [memory.md](references/memory.md) | `/concepts/memory` |
| Automation (tasks, cron, hooks, standing orders) | [automation.md](references/automation.md) | `/automation` |
| CLI command index | [cli.md](references/cli.md) | `/cli` |
| Nodes (paired devices) | [nodes.md](references/nodes.md) | `/nodes` |

### Channels (`references/channels/`)

`telegram` · `whatsapp` · `discord` · `slack` · `signal` · `imessage` ·
`matrix` · `msteams` · `googlechat` · `sms` · `groups` · `pairing` ·
`access-groups` · `channel-routing` · `troubleshooting`

### Providers (`references/providers/`)

`anthropic` · `openai` · `google` · `openrouter` · `ollama` · `lmstudio` ·
`groq` · `deepseek` · `xai` · `mistral` · `together` · `vllm` · `litellm` ·
`models` (quickstart)

### Tools (`references/tools/`)

`exec` · `exec-approvals` · `elevated` · `browser` · `web` · `web-fetch` ·
`subagents` · `permission-modes` · `image-generation` · `media-overview` ·
`slash-commands` · `skill-workshop` · `skills-config`

### Plugins (`references/plugins/`)

`sdk-overview` · `tool-plugins` · `manifest` · `sdk-channel-plugins` ·
`sdk-provider-plugins` · `hooks` · `architecture` · `manage-plugins` ·
`plugin-inventory`

### Concepts (`references/concepts/`)

`agent-loop` · `session` · `context` · `system-prompt` · `messages` ·
`compaction` · `multi-agent` · `model-providers` · `soul` · `memory-builtin` ·
`memory-config`

### CLI commands (`references/cli/`)

`config` · `gateway` · `agent` · `channels` · `models` · `skills` · `plugins` ·
`cron` · `sessions` · `doctor` · `onboard` · `message`

### Install / platforms (`references/install/`)

`docker` · `kubernetes` · `node` · `updating` · `windows` · `vps`

### Gateway config & ops (`references/gateway/`)

`config-agents` · `config-channels` · `config-tools` · `authentication` ·
`remote` · `troubleshooting`

### Automation (`references/automation/`)

`cron-jobs` · `hooks` · `tasks` · `standing-orders` · `taskflow`

### Help (`references/help/`)

`faq` · `troubleshooting` · `environment`

## Fetching More Docs

The docs site (500+ pages) is far larger than what's mirrored here. To read any
other page as clean Markdown, **append `.md` to its URL** (or send
`Accept: text/markdown`):

```bash
curl -sL https://docs.openclaw.ai/channels/telegram.md
curl -sL https://docs.openclaw.ai/providers/anthropic.md
curl -sL https://docs.openclaw.ai/tools/exec-approvals.md
```

- Full page index: `https://docs.openclaw.ai/llms.txt`
- Per-channel pages live under `/channels/<name>`, providers under
  `/providers/<name>`, plugin reference under `/plugins/reference/<name>`, CLI
  commands under `/cli/<command>`, tools under `/tools/<name>`.

When a question needs a page not in `references/`, fetch it with the `.md`
trick, then answer — don't guess from memory.

## Common Mistakes

- **Confusing OpenClaw with Claude Code/Anthropic.** The name overlaps but the
  product is a separate open-source project; don't apply Claude Code behavior.
- **Answering channel/provider specifics from memory.** There are 25+ channels
  and 60+ providers, each with its own auth and config keys — fetch the page.
- **Exposing the Gateway past loopback without auth.** `gateway.auth.mode:
  "none"` and non-loopback binds require the security runbook first
  ([security.md](references/security.md)).
