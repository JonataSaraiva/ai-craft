---
name: log-session
description: Record an AI Craft session file at the end of a working session. Use when the user says "log this session", "/log-session", "record this for AI Craft", or asks to write up the friction from the session that just happened. Writes one file to the AI Craft data/sessions/ directory following METHOD.md.
---

# Log a session

Write one session file for AI Craft. Takes about a minute. Do it at the end of the session,
while the session is still in context.

## Before you write

Read these two files from the AI Craft repo (default `~/ai-craft`; ask if
it is somewhere else):

- `METHOD.md` §3 and §4 — the friction types and the file format
- `PRACTICES.md` — the currently active practices, so you can fill in
  `practices_applied` and `practices_missed`

## The one thing that matters

You are recording friction that **you** caused. That is a conflict of interest, and the
failure mode is not exaggeration — it is quietly leaving things out.

Two rules that pull in opposite directions, and both are real:

1. **Do not invent friction.** If the session went smoothly, `friction: []` is the correct
   answer and a common one. A padded record is worse than no record.
2. **Do not soften what happened.** If you rewrote code you had just written, that is
   `rework`. If the user stopped you and pointed you elsewhere, that is `correction`. If
   you added structure nobody asked for, that is `overreach`. Write it plainly.

When you are unsure whether something counts, apply the test in METHOD.md §3.1. If no test
matches, leave it out.

## Steps

1. **Work out the file name.** `data/sessions/YYYY-MM-DD-NN.md`, where `NN` is the next
   number for today (check what already exists — `01` if it is the first today).

2. **Fill the header.** `model`, `project`, `duration_min` (estimate from the conversation),
   and `task` — one factual line about what the session was for.

3. **Go back through the session and find the friction.** For each candidate, check it
   against the tests in METHOD.md §3.1 and pick exactly one type.

4. **Anchor every entry.** File and line, a commit hash, or a named artifact. **An entry
   you cannot anchor does not go in the file.** Do not write "somewhere in the auth code".
   Go find the line, or drop the entry.

5. **Write `what` as a fact.** One sentence. What happened, not why it was bad and not what
   should have been done. No severity, no score, no opinion — those come at the weekly
   review, across many sessions.

6. **Fill `practices_applied` and `practices_missed`.** For each practice listed as active
   in `PRACTICES.md`, decide: did it apply to this session? If yes, was it followed or
   forgotten? Forgotten goes in `practices_missed`. This field is the honest one, and it is
   what stops the whole project confirming itself by accident.

7. **Show the user the file before writing it**, and say plainly if you were unsure about
   any entry. They may know about friction you did not notice.

## Format

Copy `data/sessions/_TEMPLATE.md`. Structure:

```markdown
---
id: 2026-09-01-01
date: 2026-09-01
model: claude-opus-5
project: ai-craft
duration_min: 40
task: Build the session logging skill
practices_applied: []
practices_missed: []
friction:
  - class: rework
    anchor: scripts/tally.mjs:31
    what: The first frontmatter parser assumed one friction entry per line and was rewritten.
---
```

## Do not

- Do not score anything, or add fields the template does not have.
- Do not judge whether the session was good. That is not what this file is for.
- Do not update `PRACTICES.md` — that only changes at the weekly review, and only by the
  rules in METHOD.md §5. Promoting a practice straight from one session breaks the 3-in-3
  threshold, which is the main thing keeping this honest.
- Do not skip the file because the session went fine. A clean session is data.
