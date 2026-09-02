---
name: handoff
description: Start a task in its own git worktree and herdr space as a separate Claude or Codex session the user can watch, prompt, or take over later. Use when asked to hand off, delegate, spin up, or kick off work in another worktree, session, or space, or to run several tasks in parallel. Also the rules for creating or removing worktrees with wt.
---

# Worktrees and herdr spaces

One task is one branch, one worktree, and one herdr space. `wt` (worktrunk) creates and removes all three together. Never use `git worktree add`, `herdr worktree create`, or `herdr worktree remove` directly. They skip the hooks that copy `node_modules`, install dependencies, assign per-branch ports, and open or close the herdr space.

## Finding the space for a worktree

The space opens in the background a moment after `wt` returns. The helper waits for it:

```bash
herdr-worktree pane ~/Code/worktrees/<repo>/<branch>
```

It prints the ID of the space's root pane, which is at a shell prompt and ready for `herdr agent start`. It exits non-zero if no space appears within ten seconds.

To match by hand, compare `.worktree.checkout_path` in `herdr workspace list`.

## Running agent sessions the user can watch

Use this when asked to work on several things in parallel, or to hand a task to another session. Each worker runs as a real interactive session in its own space, so the user can open it, read it, answer prompts, or take over.

First confirm you are inside herdr and load the herdr skill for command details:

```bash
test "${HERDR_ENV:-}" = 1
```

If the herdr skill is not installed, run `herdr integration install claude`.

Then, per task. Use `--kind claude` or `--kind codex` to match the tool you are running in, unless the user asked for the other one:

```bash
wt new fix/issue-72
pane=$(herdr-worktree pane ~/Code/worktrees/<repo>/fix-issue-72)
herdr agent start fix-issue-72 --kind claude --pane "$pane"
herdr agent prompt fix-issue-72 "Fix #72. Commit when done." --wait --timeout 600000
herdr agent read fix-issue-72 --source recent-unwrapped --lines 120
```

Pass the user's request to the worker in their own words. Add only what the worker cannot know: the branch, the worktree path, and any context from the current conversation the task depends on. Do not rewrite the task.

When the user only wants the session started so they can drive it themselves, stop after `herdr agent start` and report the agent name. Do not send a prompt.

Rules:

- Name the agent after the branch so the user can run `herdr agent focus <name>` and `herdr agent prompt <name>`.
- Spaces created from an agent session do not steal the user's focus. Do not focus them yourself unless asked.
- A `blocked` result means the worker is waiting at a permission or question dialog. Report it to the user. Do not answer dialogs on the worker's behalf.
- Leave the worktree and space in place when the work is done. The user reviews there. Remove only when asked, with `wt remove`.
- Do not close spaces, tabs, or panes you did not create.
