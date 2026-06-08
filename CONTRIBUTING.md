# Contributing to pumpfun-agent-skill

First off, thanks for considering contributing! Contributions of all kinds are welcome, whether it's:

- 🐛 Reporting a bug or suggesting a feature
- 📝 Improving documentation
- 🧪 Adding new workflows or analysis scripts
- 🔧 Fixing errors in the skill's knowledge base
- 🌐 Translations or locale-specific guidance

## How to contribute

1. **Fork** the repo
2. **Create a branch**: `git checkout -b feat/your-feature`
3. **Make your changes**
4. **Test** — at minimum verify `scripts/check-setup.sh` still passes
5. **Commit** with a clear message
6. **Push** and open a Pull Request

## Guidelines

- Keep `SKILL.md` as the source of truth for agents — references/ and assets/ support it
- Markdown should be readable as plain text (agents parse it raw)
- CLI examples should use `pumpfun` (not raw curl) unless the HTTP endpoint is the point
- Safety guidance is **mandatory** — every trade-related section needs a safety note
- Bonding curve math needs to be correct — verify with actual on-chain data if unsure

## Code style

- `SKILL.md` uses ATX headings (`##`, `###`) with space after `#`
- Reference files: one concept per file
- Shell scripts: `set -euo pipefail`, error messages to stderr
- Tables: pipe-delimited, header separator row required

## For maintainers

- squash-merge PRs
- Keep the tag/branch model simple — `main` is always stable
- Bump version in `SKILL.md` frontmatter on meaningful changes

## Questions?

Open a [Discussion](https://github.com/ardha27/pumpfun-agent-skill/discussions) or tag `@ardha27`.
