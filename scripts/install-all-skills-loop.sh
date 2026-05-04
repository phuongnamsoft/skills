#!/usr/bin/env bash
# Loop forever: create .tmp-install, install every skill with `npx skills add`
# into that directory (CLI project layout under .tmp-install), then remove .tmp-install.
# Stop with Ctrl+C (SIGINT) or SIGTERM — the temp directory is removed on exit.
#
# Environment (optional):
#   SKILLS_REPO   — git URL or local path (default: https://github.com/phuongnamsoft/skills)
#   SKILLS_ADD_FLAGS — extra args for `npx skills add`, e.g. "-a claude-code" for a single agent
#
# Usage (from repo root):
#   bash scripts/install-all-skills-loop.sh
#   SKILLS_REPO="$PWD" SKILLS_ADD_FLAGS="-a claude-code" bash scripts/install-all-skills-loop.sh

set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_INSTALL="${ROOT}/.tmp-install"
REPO="${SKILLS_REPO:-https://github.com/phuongnamsoft/skills}"

cleanup() {
  rm -rf "${TMP_INSTALL}"
}
trap 'cleanup; exit 130' INT TERM

echo "Loop: mkdir → npx skills add (all skills) → rm .tmp-install"
echo "Repo: ${REPO}"
echo "Temp: ${TMP_INSTALL}"
echo "Stop: Ctrl+C (temp dir will be removed)"
echo

while true; do
  mkdir -p "${TMP_INSTALL}"
  (
    cd "${TMP_INSTALL}" || exit 1
    # shellcheck disable=SC2086
    npx skills add "${REPO}" --skill '*' -y ${SKILLS_ADD_FLAGS:-}
  ) || echo "Warning: npx skills add exited with status $?" >&2
  rm -rf "${TMP_INSTALL}"
done
