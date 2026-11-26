---
name: voice
description: Rewrite Markdown in Chris Zarate's voice when asked to make a draft, PR description, post, or reply sound like him.
---

# Voice

## With shell access

Use the `voice` helper for local Markdown files. It sends the draft and writing samples to a fresh model. It reads samples from `~/Documents/Notes/samples/` or the folder set by `VOICE_SAMPLES`.

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

Report the file path and the change in one sentence. If the helper fails, quote its error. Exit 2 means the model changed headings or list structure. The helper preserves the original file. Use `voice --stdout <file>` to preview another attempt.

Do not run it on a file the user has already edited by hand unless they ask. Do not run it on commit messages or code.

## Without shell access

Apply the [rewrite rules](rewrite.md) directly to the supplied draft. Use a writing sample if the task supplies one. Otherwise use the style in the rules. Compare the result with the draft and correct any change in meaning or Markdown structure. Return the revised Markdown through the output the task specifies.
