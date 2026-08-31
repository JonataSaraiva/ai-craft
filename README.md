# AI Craft

Measuring whether an engineer actually gets better at building software with coding agents —
and if so, how fast.

**Status:** the tool is built, no data collected yet. One person. Nothing is proven.

---

## The question

Since coding agents became how I write software, I feel like I get better every week. Most of
it seems to come from small, boring rules: better prompts, naming the anti-patterns up front,
agreeing on the interface before asking for the code behind it, using a second agent to attack
the first one's work.

I have not tested that feeling. It could be real skill, or it could be getting comfortable and
mistaking that for getting better — from the inside they feel the same. So: a tool instead of
a feeling.

## The claim

> Maturity is not the list of practices you know. Anyone can copy a list. Maturity is **how
> fast you turn a problem into a rule** — how quickly you notice something is happening
> *again* instead of *once*, write a rule against it, and actually keep using it.

That speed can be counted from dates and numbers. No quality scores anywhere.

## How it works

- Sessions record **friction only** — anything that had to be redone, redirected or fixed:
  rework, corrections, wrong turns, loops. A session that went fine is one line. Every entry
  has to point at a file, a line or a commit. No pointer, no entry.
- A kind of friction that happens **three times across three sessions** becomes a candidate
  rule.
- **Never more than three rules active at once.** Nobody changes ten habits at a time, and
  this limit is what stops the list filling up with mild advice.
- Every rule says **what would prove it wrong**, and gets judged after at least 14 days and 10
  sessions. Rules that get dropped are published just like the ones that work.

Main rule: **only say what you can prove.** Three findings you can trust beat ten that sound
good.

Full recipe in [METHOD.md](METHOD.md).

## Why the preregistration matters

[PREREGISTRATION.md](PREREGISTRATION.md) says what I expect to find, how I will measure it,
what would prove me wrong, why the whole thing could be wrong anyway, and a promise to publish
the result even if it is negative. It was written **before** any data existed, and it is
frozen. The git timestamp is the proof.

With one person reporting on themselves, that is the strongest guarantee available. It is not
a substitute for other people repeating this.

If 90 days show no measurable improvement, that is the result and it goes at the top.

## What is here

| Path | What it is |
|---|---|
| [METHOD.md](METHOD.md) | The recipe. Written so someone else can follow it. |
| [PREREGISTRATION.md](PREREGISTRATION.md) | Frozen. Predictions and what would prove them wrong. |
| [PRACTICES.md](PRACTICES.md) | The list: active, waiting, finished. |
| `data/sessions/` | Raw session files. |
| `log/` | Notebook — every design decision, dated, including the bad ones. |
| `.claude/skills/` | Two Claude Code skills: `log-session` writes the session file at the end of a session, `weekly-review` runs the weekly pass. |
| `scripts/tally.ps1` | Counts friction across session files. Counting only — it decides nothing. |

## Plan

| When | What |
|---|---|
| Day 15 | Does the tool actually get used, and does it produce anything |
| Day 90 | First real report, with the raw data |
| After | An invitation to repeat it. An order of practices based on one person is a guess, not a standard. |

---

*The project watches itself being built: every session spent building AI Craft is a session
AI Craft records.*
