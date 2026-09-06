# 0003 — The reminder silenced itself

**Date:** 2026-09-06
**Status:** accepted

The gap-reminder hook worked. It fired 8 times across three days of real work on another
project, correctly detecting gaps from 26 minutes to 23 hours. The user never heard about it
once.

The hook sends two things: a `systemMessage` shown in the UI, and an `additionalContext` string
injected into the agent's context. The second one said:

> If the previous stretch of work **looks finished**, offer once to run the ai-craft-log-session
> skill. Do not run it unprompted, and **say nothing about it if the user is plainly mid-task**.

The user was mid-audit every single time. The agent judged the moment inconvenient, 8 times out
of 8, and stayed silent — following the instruction exactly. Checking the transcript of that
session: zero mentions of AI Craft in any assistant reply.

**The defect is the wording, not the mechanism.** The reminder was written with two discretionary
escape hatches, aimed at not being annoying. Together they made it invisible. A reminder that
asks the agent whether now is a good time will always be told no, because there is always work
in progress — that is what a working session is.

## The fix

The instruction is now directive rather than discretionary: report the gap in one line at the
end of the next reply, whatever the user is doing, and explicitly *do not* decide on the user's
behalf that the moment is bad. Running the skill still requires the user to ask.

## What it cost

Three days of real sessions on another project, 1100+ recorded events, went unlogged.

**Correction, same day:** this entry first said those sessions could not be recovered. That was
wrong, and the user caught it. The session was still open and had never been compacted, and the
transcript sits on disk with the file paths from every Edit and Write call in it — so the
anchors the method requires are all still there. The reasoning behind the mistake is worth
keeping: human memory fading was treated as the data being gone, when a transcript is data. That
distinction is the whole reason the anchor rule exists, and it got inverted.

What the delay actually costs is fidelity, not existence. Records written four days later are
second-hand, and METHOD.md §4 rule 1 says a record is written at the end of its session. Those
files are therefore marked in the body as reconstructed, so the weekly review can weigh them
accordingly. If reconstruction ever becomes routine rather than a one-off repair, that needs an
amendment, not a habit.

## Worth keeping in view

This is the second design error in a row with the same shape: over-correcting against a small
risk and destroying the function. First a tally script built before grep had failed; now a
reminder tuned so hard against nagging that it never speaks. Two occurrences, and the method
needs three across three sessions before that becomes a candidate practice — so it stays an
observation for now, which is exactly what the threshold is for.
