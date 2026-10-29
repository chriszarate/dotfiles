---
name: drafts
description: Write drafts for the user to review and edit in their Notes folder, then act on the edited file. Use when asked to draft, write, or prepare a PR description, issue, comment, email, or commit message for review, and when next asked to open, post, send, or publish it.
---

# Drafts for review

The user reviews and edits drafts in their own editor. The file is the source of truth: what you drafted is a starting point, and what you read back after the user's edits is what gets published.

## Writing a draft

Write the draft to `~/Documents/Notes/drafts/agents/<kind>-<id>.md`, creating the folder if needed. Use the PR or issue number when one exists, otherwise the branch with `/` replaced by `-`:

```
pr-171.md
pr-fix-issue-72.md
comment-gutenberg-1234.md
email-license-question.md
```

The file is plain Markdown. If the thing has a title (a PR, an issue, an email subject), put it on the first line as an H1. Everything after that is the body.

```markdown
# Reconnect after a dropped socket

## Summary

...
```

### PR descriptions: what to include

Write for a reviewer's time. Include only what is truly noteworthy:

- **Changes:** describe the changes that matter to a reviewer or a future reader: behavior, design choices, shared code, limits that remain. Leave out routine ones (a helper moved, a comment updated, formatting).
- **Verification:** do not include a testing summary that lists suites and confirms they pass. Mention verification only when it is novel or instructive to other humans and agents, for example a technique that made a race reproducible, a test that is known to fail on the base branch for an unrelated reason, or an approach that was tried and failed and why.

### PR descriptions: disclose AI use

Every PR description gets a "Use of AI Tools" `<details>` element, always at the very bottom, after every other section. Fill in the tool and the model you are actually running as, and say in one sentence what AI was used for in this PR, concretely:

```markdown
<details>
<summary>Use of AI Tools</summary>

AI assistance: Yes
Tool(s): Claude Code
Model(s): Claude Opus 5.5
Used for: Finding the cause, writing the fix and the tests, and drafting this description.

</details>
```

Keep the blank lines inside the element: GitHub renders the contents as Markdown only when they are there.

Tell the user the path. Do not paste the whole draft into the chat. Drafting is never permission to publish.

## Acting on a draft

When the user says to proceed ("open the PR", "post it", "send it"):

1. Read the file again now. Do not rely on what you wrote earlier.
2. Use it exactly as it is. The user's edits are final. Do not restore wording you prefer, fix style, or add sections.
3. If the draft no longer matches the code or the situation, say so and stop. Do not rewrite it.
4. Publish it. The title is the H1 without the `# `; the body is the rest of the file with leading blank lines removed. For example:

   ```bash
   f=~/Documents/Notes/drafts/agents/pr-fix-issue-72.md
   gh pr create --title "$(sed -n '1s/^# //p' "$f")" --body "$(tail -n +2 "$f" | sed '/./,$!d')"
   ```

   If there is no H1, the whole file is the body. Repo, base, and head come from the conversation and the current branch, as usual.

5. Leave the file where it is. Do not delete it.
