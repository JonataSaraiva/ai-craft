# Preregistration

**Written:** 2026-08-31
**Subject:** one engineer (me)
**Data starts:** the first session recorded after the commit that adds this file
**Check-ins:** day 15 and day 90
**Status:** frozen

> This file is never edited. Changes go in a new amendment file (§6). The commit date on
> this file is the only thing that makes the claims below a real prediction instead of a
> story told afterwards. Editing it would throw that away.

---

## 1. Why

Since coding agents became how I write software, I feel like I get better every week. Most
of it seems to come from small, boring rules: better prompts, naming the anti-patterns up
front, agreeing on the interface before the code, using a second agent to attack the first.

I have not tested that feeling. It could be real skill. It could also be getting comfortable
and mistaking that for getting better. From the inside those feel the same. That is why I am
building a tool instead of trusting the feeling.

**The question:** can that improvement be measured, and does it apply to anyone but me?

---

## 2. What gets measured

Full details in [METHOD.md](METHOD.md). Short version: sessions record **friction only**, and
every entry must point at a file, line or commit. A friction type that happens three times
across three sessions becomes a candidate **practice**. Never more than three practices
active at once. Each one says what would prove it wrong, and gets judged after at least 14
days and 10 sessions.

The four numbers — time to rule, return rate, follow-through, stick rate — are defined in
METHOD.md §7 and come from counts and dates only.

---

## 3. Predictions

Each one says how it is measured and what would prove it wrong. Those conditions are
binding: if one is met, I report it as wrong. I don't rewrite the prediction to fit.

### H1 — Friction repeats in a few known types

Problems in AI-assisted sessions come back as a small set of recognisable types, instead of
being different every time.

- **Measure:** after 30 sessions, what share of friction entries belong to a type that has
  happened 3 or more times.
- **I predict:** at least 50%.
- **Wrong if:** under 30% — meaning most problems happen only once. That would mean the list
  of types in METHOD.md §3.1 is wrong, or problems are just too personal to group. Either
  way the rest of the method falls apart.

### H2 — A practice reduces the problem it targets

Adopting a rule aimed at a friction type makes that type happen less.

- **Measure:** for each of the first three practices, how often the friction happened per
  relevant session, before and after.
- **I predict:** it goes down for at least 2 of the first 3.
- **Wrong if:** it goes down for 1 or fewer, **and follow-through was at least 0.7**. That
  condition matters: a rule I never actually followed tests nothing. Those cases get reported
  separately instead of counting as evidence either way.

### H3 — Time to rule goes down (the main claim)

Over time, the gap between a problem showing up and me having a rule against it gets shorter.

- **Measure:** time to rule (METHOD.md §7) for each cycle, in date order, over 90 days.
- **I predict:** it goes down.
- **Wrong if:** flat or going up across the cycles I get in 90 days.
- **Said up front:** 90 days will probably give only 4 to 8 cycles. That is far too few to
  claim a trend with any weight. So H3 will be reported as **a hint at best**, and "not
  enough cycles to tell" is one of the honest answers. I am saying this now so a small sample
  can't be dressed up as a finding later.

### H4 — The order generalises

The order in which engineers pick up these practices is partly shared, not fully personal.

- **Cannot be tested with one person.** It is written here so the intention is on record, and
  so any later claim about other people is clearly a later claim.
- **Testable when** at least 5 other people have run this for 30+ days.

---

## 4. How I will report

Fixed now, so I can't pick the flattering version later.

**Day 15 — does it work at all.** Not a test of anything. Reports: how many sessions I
recorded, how many friction entries, how many I threw out for having no anchor, which types
hit the line, which practices went active. The question is *am I actually using this tool*,
not *am I getting better*.

**Day 90 — first real report.** H1 and H2 tested. H3 reported with the sample-size warning
from §3. Raw session files published with it.

**Rules for reporting:**

- All four numbers, including the bad ones.
- Counts, not percentages, while I have fewer than 20 of something.
- Dropped practices get the same space as successful ones.
- No new prediction added after seeing the data, except as a dated amendment — and anything
  added that way is a guess, not a test.

---

## 5. Why this could be wrong

Written now so I can't present these later as discoveries.

**One person.** Nothing here applies to anyone else until someone repeats it.

**I report on myself.** `practices_missed` is the field I am most likely to under-report, and
it is exactly the field that stops H2 from being confirmed by accident. The anchor rule stops
me inventing friction, but it does nothing about friction I never noticed. Nothing in the
design catches that.

**Measuring changes the thing.** Watching your own work changes how you work. Writing down
friction makes friction stand out, which probably speeds up the very improvement I'm trying
to measure. This isn't a flaw to remove — it may be the whole mechanism. But it means a good
result can't tell apart "I got better" from "measuring made me better". Both are useful.
They are not the same claim, and the report must not mix them.

**The work itself changes.** Projects and task types change over 90 days. Less friction might
just mean easier work. Recording `project` per session helps a bit. It does not fix it.

**The model changes.** The models improve during the study. Improvement I credit to myself
might belong to the vendor. Recording `model` per session lets me look at this. With one
person I cannot control for it.

**I designed the tool, I am the subject, and I read the results.** There is no way to blind
this. What I have instead is this file, the anchor rule, and publishing the raw data. That is
weaker than blinding, and I'm not pretending otherwise.

---

## 6. Amendments

METHOD.md can change. This file cannot. Any change to the method after data starts goes in
`log/amendment-NN.md`, saying what changed, why, on what date, and whether the older data can
still be compared.

Amendments made *after* seeing data related to a prediction are labelled as such. Telling
apart "planned" from "decided afterwards" is the whole point of writing this file.

---

## 7. I will publish a negative result

The day-90 report goes out either way.

If there is no measurable improvement, that is the result and it goes at the top. It would
mean either that the improvement is real but this tool can't see it, or that what I feel is
comfort rather than skill. Both are more interesting than a weak claim of progress, and both
are more useful to someone deciding whether measuring their own work is worth the trouble.

---

## 8. When I stop

The project stops — publicly, with a written post-mortem — if any of these happen:

- fewer than 20 sessions recorded in the first 45 days. That means the tool costs too much to
  use, which is itself a result about self-measurement;
- H1 proven wrong at day 30. The thing I chose to count is the wrong thing, and the method
  doesn't stand;
- writing things down starts to change the work enough to matter, and I say so plainly.

Stopping for a reason I wrote down in advance is a result. Quietly giving up is not.
