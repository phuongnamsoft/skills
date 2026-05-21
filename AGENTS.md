# Agent instructions — skills repository

> **Audience:** AI agents and LLMs working in this repo. Humans can read it too; guidance is optimized for automation.

This repository hosts [Cursor agent skills](https://skills.sh/) — modular packages that extend assistants with specialized workflows, tooling, and domain guidance. Install with the [Skills CLI](https://skills.sh/) (`npx skills`), published as [`skills` on npm](https://www.npmjs.com/package/skills).

**Primary goal here:** maintain, extend, and publish skills — not ship an application runtime. Follow existing skill structure, frontmatter conventions, and the planning workflow under `.claude/skills/` before large changes.

---

## Repository layout

| Path | Purpose |
|------|---------|
| `skills/<skill-id>/` | Packaged skills (typical `--skill` target) |
| `template/` | Starter skill at repo root (`--skill template`) |
| `.claude/skills/` | **Local workflow skills** for this repo (brainstorming, plans, execution) |
| `spec/` | Notes; upstream spec lives at [agentskills.io](https://agentskills.io/specification) |
| `docs/features/specs/` | Design specs from brainstorming |
| `docs/features/plans/` | Implementation plans from writing-plans |

Skill metadata lives in each `SKILL.md` (YAML frontmatter: `name`, `description`). See [README.md](README.md) for the full skill catalog, install commands, and focus groups.

---

## Local workflow skills (`.claude/skills/`)

Use these in order for feature work in this repo. Read the full `SKILL.md` before invoking.

| Skill | When to use |
|-------|-------------|
| **brainstorming** | Before any creative work — features, new skills, behavior changes. Explores intent and design; **hard gate:** no implementation until design is approved and written to `docs/features/specs/`. |
| **writing-plans** | After an approved spec. Produces bite-sized implementation plans in `docs/features/plans/`. |
| **executing-plans** | Execute a plan in one session with checkpoints (no per-task subagents). |
| **subagent-driven-development** | Execute a plan with a **fresh subagent per task** plus two-stage review (spec, then code quality). Preferred when subagents are available. |
| **writing-skills** | Creating, updating, or improving skills under `skills/` — templates, CSO, anti-rationalization, testing. |

**Default pipeline:** `brainstorming` → spec in `docs/features/specs/` → `writing-plans` → plan in `docs/features/plans/` → `subagent-driven-development` (recommended) or `executing-plans`.

**Packaged orchestration skills** (install from `skills/` if needed): `dispatching-parallel-agents` (independent domains in parallel), `subagent-driven-development` (same-session task loop). Do not parallelize implementation subagents that touch the same files or git state.

---

## Subagent spawning rules

### When to spawn subagents

Spawn subagents when:

- Executing an implementation plan task-by-task (`subagent-driven-development`)
- Running independent investigations (test files, subsystems) with no shared mutable state (`dispatching-parallel-agents`)
- Spec or code-quality review after a task (reviewer subagents — read-only scope)

Do **not** spawn subagents when:

- A single quick edit or doc fix suffices
- Tasks share files, branches, or sequential dependencies (use one agent or sequential tasks)
- Multiple implementers would commit to the same branch concurrently

### Model selection (required)

**Every subagent spawn must set an explicit `model`.** Do not rely on the parent session’s model.

Resolve the model in this order — use the **first slug that exists** in the current environment:

1. `composer-2.5`
2. `composer-2`
3. Other **low-cost / fast** models available locally, in order:
   - `composer-2.5-fast`
   - `gpt-5.5-medium`
   - Any other fast tier the environment exposes (avoid Opus / large thinking models unless escalation below applies)

If the user or environment lists no `composer-*` models, skip steps 1–2 and pick the first available option from step 3. **Do not** substitute a premium model without reason.

**Escalate** to a more capable model only when:

- The subagent reports `BLOCKED` and more context did not help
- The task needs multi-file integration judgment the cheap model failed twice on
- The human explicitly requests a stronger model for that subagent

When escalating, step up one tier at a time; document why in the handoff prompt.

**Do not** pass `model` when resuming an existing subagent (`resume` set) — the prior run keeps its model.

### Subagent prompt hygiene

- Paste **full task text** into the prompt; do not tell the subagent to read the plan file
- Include scene-setting: goal, branch/worktree, files in scope, constraints
- One **implementer** subagent per plan task at a time (no parallel implementers on one branch)
- Review order: **spec compliance first**, then **code quality** — never reverse
- Subagents do not inherit parent chat history; provide everything they need

Prompt templates for implementer and reviewers: `.claude/skills/subagent-driven-development/*.md`.

### Example (Task tool)

```
Task:
  description: "Implement Task 2: add SKILL frontmatter validator"
  model: "composer-2.5"   # or next fallback per chain above
  subagent_type: generalPurpose
  prompt: |
    [Full task text from plan]
    [Context, paths, constraints]
```

---

## Working on skills in `skills/`

1. **New skill:** Copy `template/` → `skills/<your-skill-id>/`, edit `SKILL.md`. Follow **writing-skills** and [skill-creator](skills/skill-creator/SKILL.md) for authoring and description tuning.
2. **Frontmatter:** Valid `name` and `description` (discovery / CSO). Description should state **when** the skill triggers, not only what it contains.
3. **Scope:** One clear purpose per skill; split large domains into reference files under the skill folder.
4. **No emoji** in skill content (project convention).
5. **Do not commit:** `.cursor/`, `.cursorignore`, `.cursorrules`.
6. **README:** If adding a public skill id, update the skills table and install bundles in [README.md](README.md) when appropriate.

---

## Git and commits

- Only commit when the user asks.
- Never commit secrets (`.env` with credentials, tokens).
- Follow the repo’s existing commit message style.
- Do not force-push `main`/`master`.

---

## Installing skills from this repo

```bash
npx skills add https://github.com/phuongnamsoft/skills --skill <skill-id> -y
```

Default agent target for `npx skills add` is `claude-code`; use `-a cursor` (or multiple `-a`) for other agents. See README **Agent target** section.

---

## Quick reference — packaged skills by focus

Rough groupings (full list in README):

- **Planning & process:** `writing-plans`, `executing-plans`, `brainstorming`, `architecture`, `writing-skills`, `system-architect`
- **Agent orchestration:** `dispatching-parallel-agents`, `subagent-driven-development`
- **Meta:** `skill-creator`, `find-skills`, `template`

For domain skills (Laravel, Node, n8n, Telegram, Cosmos, etc.), use README **Browse by focus** and install only what the task needs.

---

## Principles

1. **Read before write** — Match naming, layout, and tone of neighboring skills.
2. **Minimal diffs** — Change only what the task requires.
3. **Skills are instructions** — Prefer actionable steps and checklists over essays.
4. **Verify triggers** — Descriptions must be specific enough that agents discover the skill at the right time.
5. **Workflow gates** — No implementation on creative work until brainstorming + spec approval; plans before multi-step code changes.
