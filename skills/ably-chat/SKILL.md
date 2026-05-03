---
name: ably-chat
description: >-
  Use when building Ably Chat with @ably/chat: rooms, messages, typing, presence,
  reactions, occupancy, moderation, React hooks, React UI kit, or Kotlin/JS/Swift
  clients. Read bundled docs under references/chat/ first. Enforces subscribe-before-attach,
  JWT or token client auth, and room-level APIs—not raw Pub/Sub for chat shapes.
  For Pub/Sub, Spaces, AI Transport, or LiveObjects use the broader ably skill.
license: Apache-2.0
metadata:
  category: technique
  triggers:
    - ably chat
    - "@ably/chat"
    - ChatClient
    - useMessages
    - useTyping
    - usePresence
    - room.messages
    - typing indicator
    - message reactions
    - chat moderation
    - react-ui-kit
source: >-
  https://github.com/ably/agent-skills/tree/main/skills/using-ably
  (narrowed to Chat; docs mirror from ably.com/docs/chat)
date_added: "2026-05-03"
---

# Ably Chat

Use this skill when building, modifying, or generating code that uses **Ably Chat** (`@ably/chat`) — rooms, live messages, typing, presence, reactions, history, moderation, and React integrations.

For **non-chat** Ably products (generic Pub/Sub, Spaces, LiveObjects, LiveSync, AI Transport), use the **`ably`** skill in this repository instead; it carries the full platform mirror and decision rules.

---

## What Ably Chat Is

Ably Chat is a product SDK on top of the core **Ably Realtime** connection. You create a `ChatClient` with an existing `Ably.Realtime` instance, then work with **rooms** (`room.messages`, `room.typing`, `room.presence`, and related APIs) instead of hand-rolling channel naming, history pagination, and ephemeral features on raw channels.

---

## Documentation (read before code)

This skill bundles a **markdown mirror** of Ably Chat documentation under [`references/chat/`](references/chat/). **Read the relevant files there first** so method names, hook signatures, and platform availability match current docs.

1. Open the closest guide: e.g. [`references/chat/getting-started/javascript.md`](references/chat/getting-started/javascript.md) or [`references/chat/getting-started/react.md`](references/chat/getting-started/react.md).
2. For API details, use [`references/chat/api.md`](references/chat/api.md) and the per-language trees under `references/chat/api/javascript/`, `references/chat/api/react/`, `references/chat/api/kotlin/`.
3. If something does not appear in the bundle, use [ably.com/docs/chat](https://ably.com/docs/chat) or [ably.com/llms.txt](https://ably.com/llms.txt); do not invent APIs.

See [`references/README.md`](references/README.md) for a topic index.

---

## Before Writing Code

### 1. Confirm platform support

Chat SDKs differ by platform. Before generating code, confirm from the bundled page for that language that the feature exists (for example Kotlin vs JavaScript coverage).

### 2. Post-generation checks (Chat-specific)

After generating code, verify:

- [ ] **No API key in browser or mobile clients** — use `authUrl` / `authCallback` with JWT or Ably token request from your server (same rules as core Realtime).
- [ ] **`room.messages.subscribe` (or equivalent) before `attach()`** — attaching before subscribing can **drop messages silently** (see below).
- [ ] **React: no new `Ably.Realtime` per render** — create once, provider/context, or `useEffect` with `close()` on teardown.
- [ ] **Using Chat room APIs** — not `channel.publish` / `channel.subscribe` for the same conversation shape when `@ably/chat` is in use.

---

## Authentication (clients)

- **Server:** API key (`Ably.Rest` / `Ably.Realtime` with `key: ...`) is acceptable for token issuance and trusted publishes.
- **Client:** Never ship the API key. Use JWT (recommended) or `createTokenRequest` from the server and `authUrl` / `authCallback` on the Realtime client you pass into `ChatClient`.
- **Presence:** set `clientId` via auth when you need identifiable presence members.

Details and capability examples: [`references/chat/authentication.md`](references/chat/authentication.md) and core auth topics in the **`ably`** skill if you need JWT claim shape outside Chat pages.

---

## Critical lifecycle: subscribe before attach

When using `@ably/chat`, **subscribe to messages (and other streams you care about) before calling `attach()`** on the room. Doing `attach()` first and subscribing afterward can miss messages that arrived during attach.

```javascript
const room = await chat.rooms.get('my-room');

// Wrong: attach first — can lose messages
await room.attach();
room.messages.subscribe((msg) => console.log(msg.text));

// Right: subscribe first, then attach
room.messages.subscribe((msg) => console.log(msg.text));
await room.attach();
```

Always confirm exact method names (`attach`, subscription entry points) in the bundled API page for your language.

---

## Use Chat APIs end-to-end

Prefer **`room.messages`**, **`room.typing`**, **`room.presence`**, **`room.reactions`**, and related room features over reimplementing the same behavior on a raw Realtime channel.

**Do not assume features that are not in the docs**, for example threading, read receipts, built-in file attachments, or APIs that sound plausible but are not listed — check [`references/chat/rooms/messages.md`](references/chat/rooms/messages.md) and the API reference tree.

**Built-in behavior you should not reimplement** when the SDK already provides it: typing cadence, message ordering and history pagination patterns, and delivery for features exposed as room methods or hooks.

---

## React

Ably Chat ships React hooks under `@ably/chat/react`. Common hooks (names and options — verify in bundled docs):

| Concern | Package / area | Typical entry |
|--------|----------------|----------------|
| Chat client + connection | `@ably/chat/react` | `useChatClient`, `useChatConnection`, providers |
| Messages | `@ably/chat/react` | `useMessages` |
| Typing | `@ably/chat/react` | `useTyping` |
| Presence | `@ably/chat/react` | `usePresence`, `usePresenceListener` |
| Room reactions / occupancy | `@ably/chat/react` | `useRoomReactions`, `useOccupancy` |
| Prebuilt UI | React UI kit docs | [`references/chat/react-ui-kit.md`](references/chat/react-ui-kit.md) |

**Rule:** one long-lived `Ably.Realtime` instance per application shell, passed into `ChatClient` — not constructed inside leaf components without cleanup.

---

## Moderation and integrations

- **Moderation** (direct providers, webhooks, Lambdas): [`references/chat/moderation.md`](references/chat/moderation.md) and subpages.
- **External storage / processing**: [`references/chat/external-storage-and-processing.md`](references/chat/external-storage-and-processing.md).

---

## Operational notes

- **Discontinuity / connection gaps:** see [`references/chat/guides/handling-discontinuity.md`](references/chat/guides/handling-discontinuity.md).
- **Limits and errors:** platform limits still apply (message size, rate limits). For broad platform error handling, the **`ably`** skill’s production checklist remains useful.

---

## When not to use this skill

- **Spaces** (cursors, member stacks, locks) → **`ably`** skill, `@ably/spaces`.
- **Generic Pub/Sub** only → **`ably`** skill, core channels.
- **AI Transport** token streaming → **`ably`** skill, `docs/ai-transport/`.

---

## Quick path map under `references/chat/`

| Directory | Purpose |
|-----------|---------|
| `getting-started/` | Per-platform first steps |
| `rooms/` | Messages, history, typing, presence, reactions, occupancy, media, replies |
| `api/javascript/`, `api/kotlin/`, `api/react/` | SDK and hook reference |
| `moderation/` | Content moderation integrations |
| `react-ui-kit/` | Prebuilt React components |
| `guides/` | Livestream, discontinuity, etc. |

If bundled files are stale relative to production, refresh from Ably’s site or your docs export pipeline, then replace `references/chat/`.
