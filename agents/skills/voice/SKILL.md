---
name: voice
description: Rewrite a Markdown file so the prose reads in the user's own voice, using the `voice` helper. Use when asked to put something in their voice, make it sound like them, or de-robot a draft, PR description, post, or note.
---

# Voice

The `voice` helper on PATH rewrites a file's prose to match the user's writing samples. It runs a cheap model outside this session, keeps facts, headings, lists, links, and code, and leaves the file unchanged if the structure check fails.

Do not rewrite the prose yourself. The point of the helper is a fresh model with no memory of how the draft was produced.

## Running it

1. The target must be a file. If the text is only in the conversation, write it to a file first (a draft in `~/Documents/Notes/drafts/agents/` if it is a draft, otherwise a file the user names).
2. Show the change before writing, unless the user said to rewrite in place:

   ```bash
   voice --diff <file>
   ```

3. If the user accepts, write it:

   ```bash
   voice <file>
   ```

`VOICE_BACKEND=codex` runs it on an OpenAI model instead of Claude. `VOICE_MODEL` overrides the model. Use these only when asked.

## What to report

- The path and a one-line note of what kind of change was made.
- If the helper exits with an error, quote the message. Exit 2 means the model changed headings or list structure and the file was left alone; offer `voice --stdout <file>` so the user can see the attempt.

Do not run it on a file the user has already edited by hand unless they ask. Do not run it on commit messages or code.
