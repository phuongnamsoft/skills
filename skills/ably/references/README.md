---
description: >-
  Bundled Ably documentation mirror and llms.txt index; read paths here before
  generating Ably integration code with the ably skill.
metadata:
  tags: [ably, docs, reference, llms.txt]
  source: bundled
---

# Ably skill references

## Layout

| Path | Contents |
|------|----------|
| [`docs/`](docs/) | Markdown export of **ably.com/docs** topics (products, API, auth, chat, AI Transport, platform, etc.). Prefer the subdirectory that matches your task (e.g. `docs/chat/` for Chat SDK). |
| [`llms.txt`](llms.txt) | Machine-readable index of documentation URLs (same role as [ably.com/llms.txt](https://ably.com/llms.txt)). Use it to locate which file under `docs/` corresponds to a given topic. |

## Quick routes

- **Auth (JWT, tokens, capabilities):** `docs/auth/`
- **Realtime / REST SDK API:** `docs/api/`
- **Pub/Sub concepts:** `docs/pub-sub/`
- **Chat:** `docs/chat/`
- **Spaces:** `docs/spaces/`
- **AI Transport:** `docs/ai-transport/`
- **LiveObjects / LiveSync:** `docs/liveobjects/`, `docs/livesync/`
- **Platform / limits / errors:** `docs/platform/`, `docs/faq/`

Refresh the bundle periodically by re-running your docs fetch script against Ably’s site if APIs drift.
