# 0001 — First decisions

**Date:** 2026-08-31
**Status:** accepted

The decisions the project starts from. They are together in one file because they were made
together, in one design conversation with a coding agent (Claude Opus 5), before any data
existed. From here on, one decision per file.

Worth noting: that conversation was itself an AI-assisted session, and the tool did not exist
while it was happening. It was recorded at the end, from memory of the session, as
`data/sessions/2026-08-31-01.md`. That makes it the weakest record in the set — a proper
record is written against a method that already existed. It is kept anyway, marked as what
it is.

---

## D1 — Count practices, not decisions

**Considered and dropped:** counting *engineering decisions*, which is what the original
sketch did.

Decisions are hard to draw a line around (one session holds decisions of wildly different
size), hard to compare between sessions, and don't transfer to another person. A practice is
yes-or-no, visible, copyable and testable — see [METHOD.md](../METHOD.md) §1.

This also sharpened what we are actually measuring: maturity as *how fast you turn a problem
into a rule*, not the list of rules you know. Anyone can copy the list. The speed is the
skill.

---

## D2 — Only say what you can prove

**Considered and dropped:** capturing as much signal as possible.

Three findings you can trust beat ten that sound good. This was the user's own idea and it
became the main rule. Almost every rule in METHOD.md is a way of throwing data away: the
anchor rule, the 3-in-3 line, the limit of three active practices.

The cost is accepted on purpose: rare but important one-off events will be missed. At this
sample size, something that happens once is indistinguishable from noise anyway.

---

## D3 — Write down friction only, and judge weekly

**Considered and dropped:** an AI scoring every session with quality numbers and a confidence
value, plus a second AI attacking the first — the original design.

Two things killed it. First, a pattern needs several sessions by definition, so judging one
session alone just produces confident noise. Second, a score like `technical_quality: 8` is
not something you can act on. Nobody changes how they work because of an 8.

So sessions record facts, and judgment happens once a week across many sessions. That removed
the evaluator, the second AI and the whole per-session pipeline in one move — and made the
results more trustworthy, not less.

Recording *only* friction is a deliberate negative bias. Sessions that go well are expensive
to describe and teach little. We accept the bias instead of correcting it.

---

## D4 — No infrastructure

**Considered and dropped:** DynamoDB, S3, an ingestion API and Lambda — all listed as Phase 0
in the original sketch.

None of that answers a question the project has in its first months, and picking a storage
schema early locks in the data model exactly when it is least understood. Files in git are
enough. The honest sign that a database is needed is a question that gets slow or impossible
with `grep` — and that moment is itself worth writing down.

There is a real cost, and it should be said out loud: "serverless on AWS" looks better in a
portfolio than "some markdown files". The call is that an architecture decision made later
*with evidence* is the better artifact — and that building infrastructure on a guess would
break the project's own rule (only say what you can prove) on day one.

---

## D5 — Public from the start, with a frozen preregistration

**Considered and dropped:** building it privately and writing the story once the outcome is
known.

A story written afterwards is worth nothing here — any experienced reader assumes it was
picked to fit the result. The fix costs one file and a git timestamp:
[PREREGISTRATION.md](../PREREGISTRATION.md) states the predictions, how they are measured,
what would prove them wrong, and a promise to publish a negative result — all before any data
exists.

With one person reporting on themselves, that timestamp is the strongest thing available. It
is not blinding and doesn't pretend to be.

**Also decided:** not a paper first. The order is repo → day-15 report → day-90 write-up with
raw data → invite other people to repeat it → a preprint only if they do.

---

## D6 — The name is AI Craft

**Considered and dropped:** *AI Maturity*, the first idea.

"AI maturity model" is already taken — it means enterprise adoption consulting, with company
levels 1 to 5. This project is personal, based on evidence, and about craft in the trade
sense. The name would file it as roughly the opposite of what it is.

*Craft* says the right thing: something that gets sharper with deliberate repetition.
