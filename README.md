# Agent skills

This repository hosts [Cursor agent skills](https://skills.sh/)—modular packages that extend assistants with specialized workflows, document tooling, and domain guidance.

## Install with the Skills CLI

Use the [Skills CLI](https://skills.sh/) (`npx skills`) to add skills into your environment.

### One skill from this repo

Point at the GitHub URL and pass the skill id (folder name under `skills/`, or `template` at the repo root):

```bash
npx skills add https://github.com/phuongnamsoft/skills --skill code-review-excellence
```

You can also use the shorthand form when the registry resolves `owner/repo@skill`:

```bash
npx skills add phuongnamsoft/skills@code-review-excellence
```

Optional flags (non-interactive / global install):

```bash
npx skills add https://github.com/phuongnamsoft/skills --skill code-review-excellence -g -y
```

### Discover and update

```bash
npx skills find [query]
npx skills check
npx skills update
```

### Install every skill in this repo

Run one command per skill id (copy-paste the block for your shell):

```bash
SKILLS=(
  algorithmic-art
  architecture
  brainstorming
  brand-guidelines
  canvas-design
  claude-api
  code-review-excellence
  debug-using-debugbar
  doc-coauthoring
  docx
  executing-plans
  extract-design-system
  find-skills
  frontend-design
  internal-comms
  laravel-best-practices
  laravel-patterns
  laravel-security
  mcp-builder
  pdf
  playwright-best-practices
  pptx
  receiving-code-review
  requesting-code-review
  skill-creator
  slack-gif-creator
  technical-writing
  theme-factory
  vue-best-practices
  web-artifacts-builder
  webapp-testing
  writing-plans
  xlsx
  template
)

for s in "${SKILLS[@]}"; do
  npx skills add https://github.com/phuongnamsoft/skills --skill "$s" -y
done
```

---

## Skills in this repository

| Skill id | Summary |
| -------- | ------- |
| `algorithmic-art` | Generative / algorithmic art with p5.js (seeded randomness, parameters). |
| `architecture` | Architecture decision records (ADRs), technology trade-offs, design reviews. |
| `brainstorming` | Explore intent, requirements, and design before implementation work. |
| `brand-guidelines` | Apply Anthropic-style brand colors and typography to artifacts. |
| `canvas-design` | Static visual art (.png / .pdf)—posters, layouts, original visuals. |
| `claude-api` | Build and tune Claude API / Anthropic SDK apps (caching, models, migration). |
| `code-review-excellence` | Constructive PR review, standards, mentoring, collaboration. |
| `debug-using-debugbar` | Debug and optimize Laravel via Debugbar data (Artisan: find requests, collectors, queries, exceptions). |
| `doc-coauthoring` | Structured workflow for docs, proposals, specs, decision docs. |
| `docx` | Create, read, edit Word `.docx` (reports, memos, formatting, tracked changes). |
| `executing-plans` | Run a written implementation plan in a separate session with review checkpoints. |
| `extract-design-system` | Extract design primitives from a public site into starter token files. |
| `find-skills` | Help users discover and install skills from the ecosystem. |
| `frontend-design` | Distinctive, production-grade web UI (components, pages, dashboards). |
| `internal-comms` | Internal communications—status, leadership updates, newsletters, FAQs. |
| `laravel-patterns` | Laravel architecture: routing, Eloquent, services, queues, events, APIs. |
| `laravel-security` | Laravel security: auth, validation, CSRF, uploads, secrets, rate limits. |
| `mcp-builder` | Design MCP servers (FastMCP, Node MCP SDK) for external APIs and tools. |
| `pdf` | Read, merge, split, rotate, watermark, forms, OCR on PDFs. |
| `playwright-best-practices` | Playwright tests: POM, flaky tests, CI, a11y, APIs, visual testing, and more. |
| `pptx` | Decks and `.pptx`: create, edit, extract, templates, notes. |
| `receiving-code-review` | Respond to review feedback with verification—avoid blind agreement. |
| `requesting-code-review` | Request review when finishing tasks or before merge to validate requirements. |
| `skill-creator` | Author skills, run evals, benchmark and tune descriptions. |
| `slack-gif-creator` | Animated GIFs tuned for Slack constraints and tooling. |
| `technical-writing` | Technical documentation—specs, architecture, runbooks, APIs. |
| `theme-factory` | Apply or generate themes (colors/fonts) across slides, docs, HTML. |
| `vue-best-practices` | Vue 3: Composition API, `<script setup>`, TypeScript, Router, Pinia, Vite. |
| `web-artifacts-builder` | Multi-component Claude HTML artifacts (React, Tailwind, shadcn/ui). |
| `webapp-testing` | Local web apps via Playwright—UI checks, screenshots, logs. |
| `writing-plans` | Turn a spec into an implementation plan before writing code. |
| `xlsx` | Spreadsheets: `.xlsx`, `.csv`, formulas, charts, cleaning tabular data. |
| `template` | Starter skill scaffold (`template/`); replace name and description for new skills. Declared as `template-skill` in frontmatter—use whichever id your CLI expects for this folder. |

Skill metadata lives next to each skill in `SKILL.md` (YAML frontmatter with `name` and `description`).

---

## Repository layout

- `skills/<skill-id>/` — packaged skills (each folder is a typical `--skill` target).
- `skills/skills/find-skills/` — `find-skills` (same CLI id: `find-skills`).
- `template/` — template skill at repo root.
- `spec/` — agent skills specification notes.
