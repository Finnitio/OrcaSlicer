## Agent skills

Local-only setup for a fork contributing upstream to OrcaSlicer/OrcaSlicer. Never commit agent-skill files (`CLAUDE.local.md`, `.agent/`, `.scratch/`; `.agent/` is versioned on orphan branch `agent-config`); they're excluded via `.git/info/exclude`.

### Issue tracker

Local markdown under `.scratch/<feature>/`. See `.agent/docs/agents/issue-tracker.md`.

### Triage labels

Default five roles (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`) as `Status:` lines. See `.agent/docs/agents/triage-labels.md`.

### Domain docs

Single-context: `.agent/CONTEXT.md` + `.agent/docs/adr/` (create them there, not in the repo root). See `.agent/docs/agents/domain.md`.

## Shell commands (match the allowlist in `.agent/rules.json` + `~/.claude-config/rules.json`)

- Edit code with Edit/Write, never `python - <<EOF` scripts.
- Stay in the repo root. No `cd` into subfolders, no shell variables for paths (`S=...; $S/x`).
- Write new outputs to a fresh folder instead of `rm -rf`.
- PowerShell: `& build/tests/...`, `& .\scripts\run_clang_tidy.ps1`, `ctest ...`. Prefix with `$env:Path = ...` when needed, not `Set-Location`.
- Build with the VS cmake by full path, never Strawberry's (it breaks the generator) and no `$env:Path` filtering: `& "C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe" --build build --config Release --target fff_print_tests -- -m`.
- PowerShell: write `Where-Object`/`ForEach-Object` in full, never the `?`/`%` aliases. Keep one simple pipeline per call.
- Bash: run scratch scripts as `.scratch/...`. Keep compound commands to allowlisted parts (no `echo`, `date` filler).

## Upstream contribution workflow

Remotes: `origin` = fork `Finnitio/OrcaSlicer` (push here), `upstream` = `OrcaSlicer/OrcaSlicer` (PR target; never push).
Overrides the global "commit to main" rule. In this repo, commit on the feature branch only.

Current feature: **better bridging for shallow slopes** on branch `feat/shallow-slope-bridging` (from `upstream/main`). Spec and tickets go in `.scratch/shallow-slope-bridging/`.

1. **Branch**: `git fetch upstream && git switch -c feat/<name> upstream/main`. Never work on `main`.
2. **Plan**: `/grill-with-docs` → `/to-spec` → `/to-tickets`. Read the relevant `docs/HLSD/` first.
3. **Build**: `/tdd` or `/implement`. Add Catch2 tests per `tests/AGENTS.md` (slicing changes usually go in `tests/fff_print`). Gate new behavior behind an option so the defaults and existing profiles and 3mf files stay unchanged.
4. **Commit**: Conventional Commits, small and focused. Never `git add -f`, and never stage the excluded agent files.
5. **Pre-PR**: `git fetch upstream && git rebase upstream/main`, build, run `ctest`, `scripts\run_clang_tidy.ps1`, then `/code-review` since `upstream/main`. If the design isn't evident from code, add or update `docs/HLSD/<subsystem>.md`. Check that the diff (`git diff upstream/main --stat`) contains only feature files.
6. **PR**: `git push -u origin feat/<name>`, then `gh pr create --repo OrcaSlicer/OrcaSlicer --base main --head Finnitio:feat/<name>`. Ask the user before opening the PR.
