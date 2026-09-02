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
