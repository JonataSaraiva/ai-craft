# Method

How AI Craft collects data, picks practices, and counts its numbers.

This is the recipe. Another engineer should be able to follow it and get data you can
compare with mine. If a rule here is unclear, that is a bug — open an issue.

---

## 0. The main rule

> **Only say what you can prove.** If there is no evidence, the tool says nothing.

Three findings you can trust beat ten that sound good. Most rules below work by *throwing
data away*, not by collecting more.

---

## 1. What we count: the practice

Not commits. Not sessions. Not "decisions". We count **practices** — rules for working with
a coding agent that you either follow or don't.

Examples of the shape (not a starter list — you have to earn your own from your own data):

- write the acceptance criteria before asking for code
- say which anti-patterns to avoid up front, not during review
- agree on the interface first, then ask for the code behind it
- run a second agent to attack the first agent's output

A practice works as a unit because:

| It is | Meaning |
|---|---|
| Yes or no | you followed it in a session, or you didn't |
| Visible | you can see in the session whether it happened |
| Copyable | another engineer can follow the same rule |
| Testable | it names a problem that should stop happening |

---

## 2. What "maturity" means here

The list of practices you know is **not** your maturity. Anyone can copy a list. Copying it
doesn't make you good, the same way reading about tests doesn't make you good at testing.

Maturity is **how fast you turn a problem into a rule**: how quickly you notice that
something is happening *again* instead of *once*, write a rule against it, and actually keep
using it.

That speed can be counted from dates and numbers alone (§7). Nothing here needs a score.

---

## 3. What you write down: only friction

**Good sessions are not described.** They teach little and take a long time to write up. A
clean session is one line.

You write down friction. Friction is any moment where work had to be redone, redirected, or
fixed.

### 3.1 Types of friction

Every entry gets exactly one type. Each type has a test you can check. If no test matches,
it is not friction and you don't write it down.

| Type | Test |
|---|---|
| `rework` | Code was written, then thrown away or largely rewritten |
| `correction` | You had to step in and change where the agent was going |
| `misdirection` | The agent went the wrong way because your request was unclear |
| `loop` | Three or more failed tries at the same thing before it worked |
| `overreach` | The agent changed more than you asked, or added structure you didn't need |
| `regression` | A change broke something that used to work |
| `blind-spot` | A bug both you and the agent missed, found later |

Two rules about the list:

- **New types are added by amendment only.** If an entry doesn't fit, mark it
  `unclassified` and add a note. If `unclassified` happens three times, that is a sign you
  need a new type — add it through an amendment, not inline.
- **One type per entry.** If something really is two types, write two entries with two
  anchors.

### 3.2 The anchor rule

> **Every entry must point at something real.** A file and line, a commit, or a named
> artifact. No anchor means the entry gets deleted, not fixed.

This rule does most of the work. It is the difference between friction you saw and friction
you remember. It is also why an AI helping you sort entries cannot make things up.

---

## 4. The session file

One Markdown file per session in `data/sessions/`, named `YYYY-MM-DD-NN.md`.

```markdown
---
id: 2026-08-31-01
date: 2026-08-31
model: claude-opus-5
project: <short name>
duration_min: 45
task: <one line, just the facts>
practices_applied: []      # ids of active practices you used
practices_missed: []       # ids you should have used but forgot
friction: []               # see below; empty is fine and common
---

<optional: two or three lines of context. Not required.>
```

Each friction entry:

```yaml
friction:
  - class: rework
    anchor: src/settle.ts:42
    what: <one sentence of fact — what happened, not why it was bad>
```

Rules for the file:

1. **Write it at the end of the session.** Not days later.
2. **`what` is a fact.** No opinions, no severity, no score. Opinions come once a week,
   looking at many sessions — never here.
3. **An empty `friction` list is a real result** and must be saved. If you skip the good
   sessions, every number in §7 becomes wrong.
4. **`practices_missed` is the honest field.** It is what lets you measure whether you
   actually followed a practice, and it is the one you will want to leave empty.

---

## 5. How a practice moves

Four states.

```
        3 times                    slot free              window over
seen ──────────────> candidate ────────────────> active ──────────────> habit
                                                    │                     or
                                                    └───────────────────> dropped
```

### 5.1 seen → candidate

A friction type becomes a candidate when it has:

- **three or more times**, across
- **three or more different sessions**.

Twice is a coincidence. This line is what separates a pattern from a story, and you don't
bend it for a specific case.

### 5.2 candidate → active

A candidate goes active only if all of these are true:

- it names **one** friction type it targets;
- it says **what would prove it wrong**: which friction should stop, and by when;
- there is a **free slot** (see §5.4);
- it is **clear enough that you can tell if you forgot it**. "Be more careful" is not a
  practice. If you can't check afterwards whether you did it, it doesn't count.

### 5.3 active → habit | dropped

You judge an active practice after **at least 14 days and 10 sessions**, whichever comes
later.

| Result | When |
|---|---|
| `habit` | The friction stopped, **and** you used the practice without effort in the last three sessions where it applied |
| `dropped` | The friction came back about as often — the rule was wrong, or aimed at the wrong thing |
| `unclear` | Fewer than five sessions where it applied; run it again or drop it |

`dropped` is a normal result. If nothing ever gets dropped, you are not measuring anything.

### 5.4 The limit: three active practices

> **Never more than three active at once.**

Nobody changes ten habits at the same time. Three is a human limit, not a design choice.
Extra candidates wait in a line. A new candidate can only push out an active one if that
one is `unclear` — never just because it is newer.

This limit is what makes §0 real. Without it the list fills up with mild advice.

---

## 6. The weekly review

Once a week, read the last seven days of session files. About twenty minutes.

1. **Sort.** Fix any `unclassified` entries, or leave and count them.
2. **Count.** How many times each friction type happened, total.
3. **Check the line.** Any type at 3-in-3 becomes a candidate.
4. **Judge active practices.** Only the ones whose window is over. Don't judge early.
5. **Update `PRACTICES.md`.** One commit, with the date.

An AI can help with steps 1 and 2 — spotting that two entries are the same kind of problem
is something models are good at. **Steps 3, 4 and 5 just follow the rules above.** If a
model suggests something that breaks a rule, the rule wins.

---

## 7. The four numbers

All from counts and dates. None of them needs an opinion.

**1. Time to rule** — days between the third time a friction happened and the practice
against it going active. *This is the main signal.* The project's central claim is that this
number goes down over time.

**2. Return rate** — how often a friction type happens per session where it could happen,
before and after the practice went active.

**3. Follow-through** — `used / (used + missed)` for each active practice. Tells apart "the
rule was wrong" from "I never actually did it". Without this you cannot tell them apart, and
that is the easiest way to fool yourself.

**4. Stick rate** — how many active practices became `habit` instead of `dropped`. Shows how
good you are at guessing which rules will help.

Samples will be small for a long time. Use counts, not percentages, until you have more
than twenty of something.

---

## 8. What this method does not do

Listed so it is clear these are choices, not things I forgot.

- **No scores.** No 1–10 quality ratings. Nobody changes anything because of an 8.
- **No judging one session on its own.** A pattern needs several sessions by definition. One
  session can't hold one, so judging each session alone just produces confident noise.
- **No claim about code quality.** This measures how you work with the agent, not the code.
- **No comparison with working without AI.** I don't have that data and won't invent it.
- **No infrastructure.** Files in a git repo. A database makes sense when a question gets
  slow or impossible with `grep` — and that moment is itself a result worth writing down.

---

*Changing this file after data collection starts needs an amendment — see
[PREREGISTRATION.md](PREREGISTRATION.md) §6.*
