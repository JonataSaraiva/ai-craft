---
name: ai-craft-weekly-review
description: Run the AI Craft weekly review — count friction across recent session files, check which types crossed the 3-in-3 threshold, judge active practices whose window is over, and update PRACTICES.md. Use when the user says "weekly review", "/ai-craft-weekly-review", or asks to go over the AI Craft sessions for the week. Must be run from inside the AI Craft repo.
---

# Weekly review

The once-a-week pass over session files. About twenty minutes. Procedure is METHOD.md §6 —
read it before starting, along with §5 (promotion rules) and §7 (the four numbers).

## Where your judgment helps, and where it does not

**You help with sorting and counting.** Spotting that two friction entries are the same kind
of problem is the one thing here a model is genuinely good at. Do that carefully.

**Everything else follows the rules.** Thresholds, windows and the cap are arithmetic. If
your instinct says a practice deserves promoting early, or that an obviously good rule should
skip the queue — **the rule wins**. Say what you think, then follow the rule anyway. Those
thresholds exist precisely to override in-the-moment judgment, including yours.

## Steps

### 1. Count

Three greps. There is no tooling here and there does not need to be.

Friction by type:

```bash
grep -h "class:" data/sessions/2*.md | sort | uniq -c | sort -rn
```

How many different sessions each type appears in — this is the second half of the 3-in-3
line, and the count above does not tell you:

```bash
for c in rework correction misdirection loop overreach regression blind-spot unclassified; do echo "$c: $(grep -l "class: $c" data/sessions/2*.md 2>/dev/null | wc -l)"; done
```

Entries with no anchor. The two numbers must be equal; if `anchor` is lower, some entry
breaks METHOD.md §3.2 and has to be fixed or deleted:

```bash
echo "class: $(grep -h 'class:' data/sessions/2*.md | wc -l)  anchor: $(grep -h 'anchor:' data/sessions/2*.md | wc -l)"
```

Follow-through, when practices are active:

```bash
grep -h "practices_missed:" data/sessions/2*.md | grep -o "P[0-9]*" | sort | uniq -c
```

Then read the entries themselves. Grep counts labels; it cannot tell you that three entries
filed under different types are really the same problem. That reading is the part that
actually needs you.

If one day these commands stop being enough — too slow, or a question they cannot answer —
write the tool then, and record why. That moment is a result worth keeping, not a chore.

### 2. Sort out `unclassified`

Try to fit each one into an existing type using the tests in METHOD.md §3.1. If it genuinely
does not fit, leave it. If `unclassified` has reached three, tell the user they likely need a
new type — and that adding one requires an amendment file in `log/`, not an edit to
METHOD.md's table on its own.

### 3. Check the threshold

Any type at **3+ occurrences across 3+ distinct sessions** becomes a candidate practice.

For each new candidate, draft the practice with the user. It must have all four things from
METHOD.md §5.2, and the fourth is the one that usually fails:

- one friction type it targets
- what would prove it wrong, and by when
- a free slot
- **specific enough that you can tell later whether you forgot it**

"Be more careful about scope" fails. "Write the list of files I expect to change before
asking for the implementation" passes. If a draft rule cannot be checked afterwards, it is
not ready — keep it in the queue rather than activating something unmeasurable.

### 4. Judge active practices

Only those whose window is over: **at least 14 days and 10 sessions**, whichever comes later.
Do not judge early, even if the answer looks obvious.

Apply METHOD.md §5.3, and check follow-through first:

- follow-through below 0.7 → the practice was barely used, so the result is `unclear`, not
  `dropped`. These two are constantly confused, and confusing them is what would let the
  project claim a rule "didn't work" when it was never really tried.
- friction stopped and the practice now happens without effort → `habit`
- friction came back at about the same rate, with real follow-through → `dropped`

### 5. Update PRACTICES.md

One edit, one commit, with the date. Update:

- the friction tally table
- the active list, the waiting queue, and the finished table
- follow-through counts on each active practice

Dropped practices go in the finished table with the same detail as successful ones.

### 6. Report

Short summary for the user: sessions this week, friction by type, anything that crossed the
line, any practice judged. Counts, not percentages, while numbers are under twenty.

If nothing crossed a threshold and no window closed, say exactly that. A quiet week is a
normal result and does not need to be dressed up as progress.
