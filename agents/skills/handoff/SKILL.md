---
name: handoff
description: Start a task in its own git worktree and herdr space as a separate Claude or Codex session the user can watch, prompt, or take over later. Use when asked to hand off, delegate, spin up, or kick off work in another worktree, session, or space, or to run several tasks in parallel. Also the rules for creating or removing worktrees with wt.
---

# Worktrees and herdr spaces

One task is one branch, one worktree, and one herdr space. `wt` (worktrunk) creates and removes all three together. Never use `git worktree add`, `herdr worktree create`, or `herdr worktree remove` directly. They skip the hooks that copy `node_modules`, install dependencies, assign per-branch ports, and open or close the herdr space.

## Running agent sessions the user can watch

Use this to hand off a task to another session (possibly in parallel with other tasks). Each worker runs as a real interactive session in its own space, so the user can open it, read it, answer prompts, or take over.

First confirm you are inside herdr and load the herdr skill for command details:

```bash
test "${HERDR_ENV:-}" = 1
```

If the herdr skill is not installed, run `herdr integration install [agent]` where `[agent]` is "claude", "codex", or the name of the tool you are running in.

Then, per task:

```bash
wt new fix/issue-72
pane=$(herdr-worktree pane ~/Code/worktrees/<repo>/fix-issue-72)
herdr agent start fix-issue-72 --kind [agent] --pane "$pane"
herdr agent prompt fix-issue-72 "[prompt]"
```

For the prompt, provide only what the worker cannot know: the branch, the worktree path, the task, and any context from the current conversation the task depends on.

## Your job ends once the session is running

Confirm three things, then report the agent name and stop:

1. `wt new` created the worktree.
2. `herdr agent start` succeeded and the agent shows up in `herdr agent list`.
3. `herdr agent prompt` was accepted, if you sent one.

Do not watch the worker after that. Do not use `--wait`, `herdr agent wait`, `herdr agent read`, or any loop that polls for progress, and do not report on what the worker is doing or whether it finished. The user watches the session themselves. If a step above fails, report the error and stop; do not retry by hand-rolling the steps `wt` does for you.

Rules:

- Name the agent after the branch so the user can run `herdr agent focus <name>` and `herdr agent prompt <name>`.
- Spaces created from an agent session do not steal the user's focus. Do not focus them yourself unless asked.
- If the user later asks how a worker is doing, `herdr agent read <name>` is fine then. A `blocked` status means the worker is waiting at a permission or question dialog. Report it. Do not answer dialogs on the worker's behalf.
- Leave the worktree and space in place when the work is done. The user reviews there. Remove only when asked, with `wt remove`.
- Do not close spaces, tabs, or panes you did not create.

## Finding the space for a worktree

The space opens in the background a moment after `wt` returns. The helper waits for it:

```bash
herdr-worktree pane ~/Code/worktrees/<repo>/<branch>
```

It prints the ID of the space's root pane, which is at a shell prompt and ready for `herdr agent start`. It exits non-zero if no space appears within ten seconds.

To match by hand, compare `.worktree.checkout_path` in `herdr workspace list`.
