# Agent configuration

Shared setup for the coding agents. `AGENTS.md` is the one set of instructions
both Claude Code and Codex read; `bin/setup-links.sh` links it into each of
their home directories under whatever name they expect.

## Commands and skills

`commands/` and `skills/` hold work that should follow you between machines,
written once rather than once per agent.

- `commands/*.md` are slash commands. Only Claude Code reads these today, from
  `~/.claude/commands`.
- `skills/<name>/` are skills, each a directory with a `SKILL.md` inside. Both
  agents read these, from `~/.claude/skills` and `~/.codex/skills`.

Setup links each command and skill individually rather than replacing the
whole directory. The agents keep their own generated files in those same
directories — Codex maintains `~/.codex/skills/.system`, for one — and a
symlinked directory would hide them.

Both directories start empty. The `.gitkeep` files are there because git does
not track empty directories.
