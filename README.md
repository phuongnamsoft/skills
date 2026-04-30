# Agent skills

This repository hosts [Cursor agent skills](https://skills.sh/)—modular packages that extend assistants with specialized workflows, document tooling, and domain guidance. Install them with the [Skills CLI](https://skills.sh/) (`npx skills`), published as [`skills` on npm](https://www.npmjs.com/package/skills).

**Who this is for:** anyone using Cursor (or compatible clients) who wants ready-made skills for Laravel, Node/Nest/Next, databases, testing, documents, n8n, Telegram, SaaS architecture, DevOps, MCP, and more—without copying instructions by hand.

## Contents

- [Prerequisites](#prerequisites)
- [Quick start](#quick-start)
- [Install with the Skills CLI](#install-with-the-skills-cli)
- [Install every skill](#install-every-skill-in-this-repo)
- [Install skills by focus group](#install-skills-by-focus-group)
- [Skills in this repository](#skills-in-this-repository)
- [Browse by focus](#browse-by-focus)
- [Repository layout](#repository-layout)
- [Contributing new skills](#contributing-new-skills)

## Prerequisites

- [Node.js](https://nodejs.org/) (includes `npx`) for `npx skills …` commands.

## Quick start

Add one skill by id (folder name under `skills/`, or `template` at the repo root):

```bash
npx skills add phuongnamsoft/skills@code-review-excellence
```

Equivalent long form:

```bash
npx skills add https://github.com/phuongnamsoft/skills --skill code-review-excellence
```

Non-interactive global install:

```bash
npx skills add https://github.com/phuongnamsoft/skills --skill code-review-excellence -g -y
```

## Install with the Skills CLI

Use [`npx skills`](https://skills.sh/) ([npm](https://www.npmjs.com/package/skills)) to add, discover, and refresh skills. Adding a single skill is covered in [Quick start](#quick-start).

### Agent target

The `add` command accepts **`-a`** / **`--agent`** to install skills into a specific coding agent’s skill directory (for example `claude-code`, `codex`, `cursor`). Pass `-a` multiple times to install to several agents in one run. The full list of agent ids is in the [Supported agents](https://www.npmjs.com/package/skills#supported-agents) table on npm.

**Default:** when you omit `--agent`, the CLI uses **`claude-code`**.

```bash
# Same as omitting --agent (default claude-code)
npx skills add https://github.com/phuongnamsoft/skills --skill code-review-excellence -y

# Target Codex explicitly
npx skills add https://github.com/phuongnamsoft/skills --skill code-review-excellence -y -a codex

# Multiple agents
npx skills add https://github.com/phuongnamsoft/skills --skill code-review-excellence -y -a claude-code -a cursor
```

Append the same `-a <agent>` flags to the `npx skills add` lines in [Install every skill in this repo](#install-every-skill-in-this-repo) and [Install skills by focus group](#install-skills-by-focus-group) when you need a non-default agent.

### Discover and update

```bash
npx skills find [query]
npx skills check
npx skills update
```

## Install every skill in this repo

Append **`-a` / `--agent`** to each `npx skills add` if you need a non-default agent (default: **`claude-code`**); see [Agent target](#agent-target).

### Bash (macOS, Linux, Git Bash on Windows)

Run one command per skill id:

```bash
SKILLS=(
  algorithmic-art
  architecture
  brainstorming
  brainstorming-new
  brand-guidelines
  canvas-design
  claude-api
  code-review-ai-ai-review
  code-review-checklist
  code-review-excellence
  code-reviewer
  database
  database-architect
  database-design
  debug-using-debugbar
  doc-coauthoring
  docker-expert
  docx
  executing-plans
  extract-design-system
  find-skills
  frontend-design
  golang-pro
  internal-comms
  itil-expert
  javascript-mastery
  javascript-pro
  laravel-best-practices
  laravel-expert
  laravel-patterns
  laravel-security
  mcp-builder
  n8n-code-javascript
  n8n-code-python
  n8n-expression-syntax
  n8n-mcp-tools-expert
  n8n-node-configuration
  n8n-validation-expert
  n8n-workflow-patterns
  nestjs-expert
  nextjs-best-practices
  nodejs-backend-patterns
  nodejs-best-practices
  nosql-expert
  pdf
  php-pro
  playwright-best-practices
  playwright-skill
  pptx
  product-manager
  product-manager-toolkit
  react-best-practices
  receiving-code-review
  requesting-code-review
  rust-pro
  saas-multi-tenant
  saas-mvp-launcher
  senior-architect
  senior-frontend
  senior-fullstack
  skill-creator
  slack-gif-creator
  tailwind-design-system
  tailwind-patterns
  technical-writing
  telegram
  telegram-automation
  telegram-bot-builder
  telegram-mini-app
  test-driven-development
  testing-qa
  theme-factory
  typescript-expert
  typescript-pro
  vue-best-practices
  web-artifacts-builder
  webapp-testing
  workflow-orchestration-patterns
  writing-plans
  writing-skills
  xlsx
  template
)

for s in "${SKILLS[@]}"; do
  npx skills add https://github.com/phuongnamsoft/skills --skill "$s" -y
done
```

### PowerShell (Windows)

```powershell
$skills = @(
  'algorithmic-art','architecture','brainstorming','brainstorming-new','brand-guidelines','canvas-design',
  'claude-api','code-review-ai-ai-review','code-review-checklist','code-review-excellence','code-reviewer',
  'database','database-architect','database-design','debug-using-debugbar','doc-coauthoring','docker-expert',
  'docx','executing-plans','extract-design-system','find-skills','frontend-design','golang-pro',
  'internal-comms','itil-expert','javascript-mastery','javascript-pro','laravel-best-practices','laravel-expert',
  'laravel-patterns','laravel-security','mcp-builder','n8n-code-javascript','n8n-code-python','n8n-expression-syntax',
  'n8n-mcp-tools-expert','n8n-node-configuration','n8n-validation-expert','n8n-workflow-patterns','nestjs-expert',
  'nextjs-best-practices','nodejs-backend-patterns','nodejs-best-practices','nosql-expert','pdf','php-pro',
  'playwright-best-practices','playwright-skill','pptx','product-manager','product-manager-toolkit',
  'react-best-practices','receiving-code-review','requesting-code-review','rust-pro','saas-multi-tenant','saas-mvp-launcher',
  'senior-architect','senior-frontend','senior-fullstack','skill-creator','slack-gif-creator',
  'tailwind-design-system','tailwind-patterns','technical-writing','telegram','telegram-automation',
  'telegram-bot-builder','telegram-mini-app','test-driven-development','testing-qa','theme-factory',
  'typescript-expert','typescript-pro','vue-best-practices','web-artifacts-builder','webapp-testing',
  'workflow-orchestration-patterns','writing-plans','writing-skills','xlsx','template'
)
foreach ($s in $skills) {
  npx skills add https://github.com/phuongnamsoft/skills --skill $s -y
}
```

Replace the GitHub URL if you are installing from a fork.

## Install skills by focus group

These bundles match the [Browse by focus](#browse-by-focus) table—if you change ids there, update the arrays here too.

Pick one group (or combine arrays) and run the loop. Same GitHub URL and flags as [Install every skill in this repo](#install-every-skill-in-this-repo); add `-g` for a global install if you use that elsewhere, and `-a` / `--agent` to override the default agent (see [Agent target](#agent-target)).

### Bash (macOS, Linux, Git Bash on Windows)

```bash
REPO="https://github.com/phuongnamsoft/skills"

# Laravel / PHP
SKILLS=(laravel-best-practices laravel-patterns laravel-security laravel-expert php-pro debug-using-debugbar)
for s in "${SKILLS[@]}"; do npx skills add "$REPO" --skill "$s" -y; done

# Node / TypeScript / JavaScript
SKILLS=(nestjs-expert nodejs-best-practices nodejs-backend-patterns nextjs-best-practices typescript-expert typescript-pro javascript-pro javascript-mastery)
for s in "${SKILLS[@]}"; do npx skills add "$REPO" --skill "$s" -y; done

# Other languages
SKILLS=(golang-pro rust-pro)
for s in "${SKILLS[@]}"; do npx skills add "$REPO" --skill "$s" -y; done

# Database & storage
SKILLS=(database database-architect database-design nosql-expert)
for s in "${SKILLS[@]}"; do npx skills add "$REPO" --skill "$s" -y; done

# Testing & quality
SKILLS=(playwright-best-practices playwright-skill webapp-testing testing-qa test-driven-development code-review-excellence code-review-checklist code-reviewer code-review-ai-ai-review receiving-code-review requesting-code-review)
for s in "${SKILLS[@]}"; do npx skills add "$REPO" --skill "$s" -y; done

# Documents & decks
SKILLS=(docx pdf pptx xlsx doc-coauthoring)
for s in "${SKILLS[@]}"; do npx skills add "$REPO" --skill "$s" -y; done

# UI & front end
SKILLS=(vue-best-practices frontend-design web-artifacts-builder canvas-design algorithmic-art brand-guidelines extract-design-system theme-factory tailwind-design-system tailwind-patterns react-best-practices senior-frontend)
for s in "${SKILLS[@]}"; do npx skills add "$REPO" --skill "$s" -y; done

# Planning & process
SKILLS=(writing-plans executing-plans brainstorming brainstorming-new architecture internal-comms technical-writing writing-skills)
for s in "${SKILLS[@]}"; do npx skills add "$REPO" --skill "$s" -y; done

# Product & SaaS
SKILLS=(product-manager product-manager-toolkit saas-multi-tenant saas-mvp-launcher senior-architect senior-fullstack)
for s in "${SKILLS[@]}"; do npx skills add "$REPO" --skill "$s" -y; done

# DevOps, ITSM, orchestration
SKILLS=(docker-expert workflow-orchestration-patterns itil-expert)
for s in "${SKILLS[@]}"; do npx skills add "$REPO" --skill "$s" -y; done

# n8n
SKILLS=(n8n-code-javascript n8n-code-python n8n-expression-syntax n8n-mcp-tools-expert n8n-node-configuration n8n-validation-expert n8n-workflow-patterns)
for s in "${SKILLS[@]}"; do npx skills add "$REPO" --skill "$s" -y; done

# Telegram
SKILLS=(telegram telegram-automation telegram-bot-builder telegram-mini-app)
for s in "${SKILLS[@]}"; do npx skills add "$REPO" --skill "$s" -y; done

# AI & integration
SKILLS=(claude-api mcp-builder slack-gif-creator)
for s in "${SKILLS[@]}"; do npx skills add "$REPO" --skill "$s" -y; done

# Meta
SKILLS=(skill-creator find-skills template)
for s in "${SKILLS[@]}"; do npx skills add "$REPO" --skill "$s" -y; done
```

Copy only the `SKILLS` assignment and `for` loop for the group you need. Running every block in order installs the full set (equivalent to [Install every skill in this repo](#install-every-skill-in-this-repo)).

### PowerShell (Windows)

Set `$REPO` and the skill list, then reuse the same `foreach` pattern as [Install every skill in this repo](#install-every-skill-in-this-repo):

```powershell
$REPO = 'https://github.com/phuongnamsoft/skills'
# Example: Laravel / PHP group (swap for other groups from Browse by focus)
$skills = @('laravel-best-practices','laravel-patterns','laravel-security','laravel-expert','php-pro','debug-using-debugbar')
foreach ($s in $skills) { npx skills add $REPO --skill $s -y }
```

Swap `$skills` for another group’s ids from the table in [Browse by focus](#browse-by-focus).

---

## Skills in this repository

| Skill id | Summary |
| -------- | ------- |
| `algorithmic-art` | Generative / algorithmic art with p5.js (seeded randomness, parameters). |
| `architecture` | Architecture decision records (ADRs), technology trade-offs, design reviews. |
| `brainstorming` | Explore intent, requirements, and design before implementation work. |
| `brainstorming-new` | Structured brainstorming before creative or constructive work (features, architecture, behavior). |
| `brand-guidelines` | Apply Anthropic-style brand colors and typography to artifacts. |
| `canvas-design` | Static visual art (.png / .pdf)—posters, layouts, original visuals. |
| `claude-api` | Build, debug, and optimize Claude API / Anthropic SDK apps (caching, models, migration). |
| `code-review-ai-ai-review` | AI-assisted code review: static analysis, pattern recognition, and modern DevOps-oriented review practice. |
| `code-review-checklist` | Checklist-driven reviews—functionality, security, performance, maintainability. |
| `code-review-excellence` | Constructive PR review, standards, mentoring, collaboration. |
| `code-reviewer` | Deep code review guidance for modern AI-assisted review workflows. |
| `database` | Database development and operations: SQL/NoSQL, design, migrations, optimization, data engineering. |
| `database-architect` | Data layer design from scratch—technology selection, schema modeling, scalable architectures. |
| `database-design` | Schema design, indexing, ORM selection, serverless databases, design trade-offs. |
| `debug-using-debugbar` | Debug and optimize Laravel via Debugbar data (Artisan: requests, collectors, queries, exceptions). |
| `doc-coauthoring` | Structured workflow for docs, proposals, specs, decision docs. |
| `docker-expert` | Containers: optimization, security hardening, multi-stage builds, orchestration, production deployment. |
| `docx` | Create, read, edit Word `.docx` (reports, memos, formatting, tracked changes). |
| `executing-plans` | Run a written implementation plan in a separate session with review checkpoints. |
| `extract-design-system` | Extract design primitives from a public site into starter token files. |
| `find-skills` | Help users discover and install skills from the ecosystem. |
| `frontend-design` | Distinctive, production-grade web UI (components, pages, dashboards). |
| `golang-pro` | Go 1.21+ patterns, concurrency, performance, production microservices. |
| `internal-comms` | Internal communications—status, leadership updates, newsletters, FAQs. |
| `itil-expert` | ITIL 4 / ITIL 5-oriented service management, governance, and digital product practices. |
| `javascript-mastery` | Core JavaScript concepts and deep language understanding (modern JS ecosystem). |
| `javascript-pro` | Modern JavaScript (ES6+), async patterns, browser and Node.js APIs. |
| `laravel-best-practices` | Laravel PHP patterns—controllers, Eloquent, validation, auth, queues, performance, security (rule-backed). |
| `laravel-expert` | Senior Laravel engineering—clean architecture, security, performance, Laravel 10/11+ idioms. |
| `laravel-patterns` | Laravel architecture: routing, Eloquent, services, queues, events, APIs. |
| `laravel-security` | Laravel security: auth, validation, CSRF, uploads, secrets, rate limits. |
| `mcp-builder` | Design MCP servers (FastMCP, Node MCP SDK) for external APIs and tools. |
| `n8n-code-javascript` | JavaScript in n8n Code nodes (`$input`, `$json`, helpers, troubleshooting). |
| `n8n-code-python` | Python in n8n Code nodes (`_input` / `_json` / `_node`, stdlib, platform limits). |
| `n8n-expression-syntax` | Validate and fix n8n `{{}}` expressions, `$json` / `$node`, webhook payloads. |
| `n8n-mcp-tools-expert` | Use n8n-mcp tools effectively—nodes, validation, templates, workflows. |
| `n8n-node-configuration` | Operation-aware n8n node configuration, required fields, common patterns. |
| `n8n-validation-expert` | Interpret and fix n8n validation errors. |
| `n8n-workflow-patterns` | Architectural patterns for reliable n8n workflows. |
| `nestjs-expert` | NestJS: DI, modules, guards, interceptors, pipes, testing, auth, databases. |
| `nextjs-best-practices` | Next.js App Router—Server Components, data fetching, routing patterns. |
| `nodejs-backend-patterns` | Scalable Node.js backends—frameworks, architecture, production readiness. |
| `nodejs-best-practices` | Node.js principles—framework choice, async I/O, security, architecture. |
| `nosql-expert` | NoSQL data modeling, engines, and operational patterns. |
| `pdf` | Read, merge, split, rotate, watermark, forms, OCR on PDFs. |
| `php-pro` | Idiomatic PHP—generators, iterators, SPL, modern OOP, performance-oriented patterns. |
| `playwright-best-practices` | Playwright tests: POM, flaky tests, CI, a11y, APIs, visual testing, and more. |
| `playwright-skill` | Playwright usage with path-aware setup (install locations, commands). |
| `pptx` | Decks and `.pptx`: create, edit, extract, templates, notes. |
| `product-manager` | PM frameworks, templates, SaaS metrics, and strategy (Markdown-first). |
| `product-manager-toolkit` | PM tools and frameworks from discovery through delivery. |
| `react-best-practices` | React and Next.js performance patterns (Vercel-maintained rules for components, data fetching, bundles, rerenders). |
| `receiving-code-review` | Respond to review feedback with verification—avoid blind agreement. |
| `requesting-code-review` | Request review when finishing tasks or before merge to validate requirements. |
| `rust-pro` | Rust 1.75+ async, advanced types, production systems programming. |
| `saas-multi-tenant` | Multi-tenant SaaS—RLS, tenant scoping, PostgreSQL + TypeScript patterns. |
| `saas-mvp-launcher` | Roadmap for planning and building a SaaS MVP—stack, auth, payments, launch. |
| `senior-architect` | Senior architect toolkit—patterns, tooling, and delivery practices. |
| `senior-frontend` | React, Next.js, TypeScript, Tailwind—components, performance, a11y, scaffolding. |
| `senior-fullstack` | Senior fullstack toolkit across frontend and backend. |
| `skill-creator` | Author skills, run evals, benchmark and tune descriptions. |
| `slack-gif-creator` | Animated GIFs tuned for Slack constraints and tooling. |
| `tailwind-design-system` | Design systems with Tailwind—tokens, variants, responsive and accessible UI. |
| `tailwind-patterns` | Tailwind CSS v4—CSS-first config, container queries, tokens, modern layout patterns. |
| `technical-writing` | Technical documentation—specs, architecture, runbooks, APIs. |
| `telegram` | Telegram Bot API—setup, messages, webhooks, keyboards, Node and Python boilerplates. |
| `telegram-automation` | Automate Telegram via MCP-style integrations (messages, media, bots). |
| `telegram-bot-builder` | Production Telegram bots—architecture, UX, scaling, monetization. |
| `telegram-mini-app` | Telegram Mini Apps (TWA)—Web App API, TON, payments, auth, growth. |
| `test-driven-development` | TDD workflow, test design, and testing discipline. |
| `testing-qa` | Testing and QA—unit, integration, E2E, browser automation, quality practices. |
| `theme-factory` | Apply or generate themes (colors/fonts) across slides, docs, HTML. |
| `typescript-expert` | Advanced TypeScript—type-level programming, tooling, migrations, monorepos. |
| `typescript-pro` | TypeScript—generics, strict typing, decorators, enterprise patterns. |
| `vue-best-practices` | Vue 3: Composition API, `<script setup>`, TypeScript, Router, Pinia, Vite. |
| `web-artifacts-builder` | Multi-component Claude HTML artifacts (React, Tailwind, shadcn/ui). |
| `webapp-testing` | Local web apps via Playwright—UI checks, screenshots, logs. |
| `workflow-orchestration-patterns` | Durable workflows with Temporal—design, resilience, distributed systems. |
| `writing-plans` | Turn a spec into an implementation plan before writing code. |
| `writing-skills` | Create, update, and improve agent skills (authoring guidance). |
| `xlsx` | Spreadsheets: `.xlsx`, `.csv`, formulas, charts, cleaning tabular data. |
| `template` | Starter scaffold in `template/`; use `--skill template`. Frontmatter `name` is `template-skill`—your CLI may display that label while the install id remains `template`. |

Skill metadata lives next to each skill in `SKILL.md` (YAML frontmatter with `name` and `description`).

## Browse by focus

Rough groupings—the full table above remains the source of truth for ids.

| Focus | Skill ids |
| ----- | --------- |
| Laravel / PHP | `laravel-best-practices`, `laravel-patterns`, `laravel-security`, `laravel-expert`, `php-pro`, `debug-using-debugbar` |
| Node / TypeScript / JavaScript | `nestjs-expert`, `nodejs-best-practices`, `nodejs-backend-patterns`, `nextjs-best-practices`, `typescript-expert`, `typescript-pro`, `javascript-pro`, `javascript-mastery` |
| Other languages | `golang-pro`, `rust-pro` |
| Database & storage | `database`, `database-architect`, `database-design`, `nosql-expert` |
| Testing & quality | `playwright-best-practices`, `playwright-skill`, `webapp-testing`, `testing-qa`, `test-driven-development`, `code-review-excellence`, `code-review-checklist`, `code-reviewer`, `code-review-ai-ai-review`, `receiving-code-review`, `requesting-code-review` |
| Documents & decks | `docx`, `pdf`, `pptx`, `xlsx`, `doc-coauthoring` |
| UI & front end | `vue-best-practices`, `frontend-design`, `web-artifacts-builder`, `canvas-design`, `algorithmic-art`, `brand-guidelines`, `extract-design-system`, `theme-factory`, `tailwind-design-system`, `tailwind-patterns`, `react-best-practices`, `senior-frontend` |
| Planning & process | `writing-plans`, `executing-plans`, `brainstorming`, `brainstorming-new`, `architecture`, `internal-comms`, `technical-writing`, `writing-skills` |
| Product & SaaS | `product-manager`, `product-manager-toolkit`, `saas-multi-tenant`, `saas-mvp-launcher`, `senior-architect`, `senior-fullstack` |
| DevOps, ITSM, orchestration | `docker-expert`, `workflow-orchestration-patterns`, `itil-expert` |
| n8n | `n8n-code-javascript`, `n8n-code-python`, `n8n-expression-syntax`, `n8n-mcp-tools-expert`, `n8n-node-configuration`, `n8n-validation-expert`, `n8n-workflow-patterns` |
| Telegram | `telegram`, `telegram-automation`, `telegram-bot-builder`, `telegram-mini-app` |
| AI & integration | `claude-api`, `mcp-builder`, `slack-gif-creator` |
| Meta | `skill-creator`, `find-skills`, `template` |

## Repository layout

- `skills/<skill-id>/` — packaged skills (typical `--skill` target).
- `template/` — template skill at repo root (`--skill template`).
- `spec/` — notes; the [Agent Skills specification](https://agentskills.io/specification) lives upstream.
- [`THIRD_PARTY_NOTICES.md`](THIRD_PARTY_NOTICES.md) — attribution for bundled third-party components.

## Contributing new skills

Copy [`template/`](template/) to `skills/<your-skill-id>/`, replace the frontmatter and body in `SKILL.md`, then follow [`skill-creator`](skills/skill-creator/SKILL.md) for authoring, evals, and description tuning. Open a PR when the skill is ready to share.
