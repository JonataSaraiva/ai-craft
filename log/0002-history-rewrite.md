# 0002 — Rewriting history to remove machine paths

**Date:** 2026-08-31
**Status:** accepted

Two files carried an absolute path from the machine this was built on — a Windows username and
folder layout, in the log-session skill and in the gap-reminder hook. They were removed going
forward in the Apache-license commit, but git keeps old commits: the path was still readable in
the published history.

**Decision:** rewrite the history so the path never appears, then delete the GitHub repository
and push the rewritten history to a fresh one.

## What was considered and dropped

**Leave it.** The exposure is a username and a folder layout — no credential, nothing to
rotate, and the GitHub account name is public anyway. The argument for leaving it was that this
project's credibility rests on an unedited log, and rewriting the history of a repository whose
central claim is *"this was written before the data existed, and here is the timestamp"* costs
something real.

That argument lost, and the reason is worth recording: this repository is also a portfolio. What
it shows about how its author works is part of what it is for, and shipping a machine path into
a public repo is not what he wants it to show. The cost is accepted knowingly, and this entry is
the mitigation — the rewrite is documented rather than silent.

**Squash everything into one fresh commit.** Simpler, and it destroys the thing that matters
most: the timestamps and the order of the decisions. Rejected outright.

**Force-push over the existing repository.** Leaves the old objects reachable by SHA on GitHub,
which is exactly what the rewrite was meant to remove. Deleting the repository was the point.

## What changed

- Commit messages, authorship and dates are unchanged. Every commit kept its original
  timestamp, so the preregistration still carries the date it was written.
- Commit SHAs all changed, because the trees changed. Nothing else references them except the
  session record below.
- `data/sessions/2026-08-31-01.md` had two friction entries anchored to `commit 4c5acea`, which
  no longer exists. They now point at `4d7eda6`, the same commit after the rewrite. An anchor
  that points at nothing breaks METHOD.md §3.2, so this was not optional.
- In historical versions of the two files, the machine path reads `~/ai-craft` and
  `$HOME/ai-craft`. Those lines are therefore not byte-identical to what was originally
  committed. Recorded here so the difference is on the record and not a discovery.

## What this cost, plainly

The history is now an edited history. It is accurate about what happened and when, and it is no
longer a literal transcript of what was committed. For a repository that argues from its own
timestamps, that is a real if small debt — paid down by this file existing.
