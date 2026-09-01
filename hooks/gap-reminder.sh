#!/usr/bin/env bash
#
# AI Craft — gap reminder.
#
# Runs on UserPromptSubmit. Claude Code has no timer or idle hook, so this
# approximates one: it stores the time of every prompt, and when a new prompt
# arrives after a long gap it treats that gap as "you were away, the previous
# stretch of work probably ended" and reminds you to log it.
#
# It only reminds. It never writes a session file — a record written without
# the human in the loop only contains the friction the agent chose to admit.
#
# Install: see the hooks entry in ~/.claude/settings.json.

set -u

REPO="${AI_CRAFT_REPO:-$HOME/ai-craft}"
GAP_MINUTES="${AI_CRAFT_GAP_MINUTES:-20}"
STATE="$HOME/.claude/ai-craft-last-prompt"

now=$(date +%s)

last=0
if [ -f "$STATE" ]; then
  last=$(cat "$STATE" 2>/dev/null || echo 0)
fi
case "$last" in ''|*[!0-9]*) last=0 ;; esac

printf '%s' "$now" > "$STATE" 2>/dev/null

# First prompt ever — nothing to compare against.
[ "$last" -eq 0 ] && exit 0

gap=$(( now - last ))
[ "$gap" -lt $(( GAP_MINUTES * 60 )) ] && exit 0

# Already logged since that prompt? Then the previous stretch is accounted for
# and reminding again would just be nagging.
newest=$(ls -t "$REPO"/data/sessions/2*.md 2>/dev/null | head -1)
if [ -n "$newest" ]; then
  logged=$(stat -c %Y "$newest" 2>/dev/null || echo 0)
  case "$logged" in ''|*[!0-9]*) logged=0 ;; esac
  [ "$logged" -gt "$last" ] && exit 0
fi

hours=$(( gap / 3600 ))
mins=$(( (gap % 3600) / 60 ))
if [ "$hours" -gt 0 ]; then human="${hours}h ${mins}m"; else human="${mins}m"; fi

printf '{"systemMessage":"AI Craft: %s since your last prompt, and no session logged since. If that stretch of work is done: /ai-craft-log-session","hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"AI Craft gap detector: %s passed since the previous prompt in this session, and no session file has been written since then. If the previous stretch of work looks finished, offer once to run the ai-craft-log-session skill. Do not run it unprompted, and say nothing about it if the user is plainly mid-task."}}' "$human" "$human"
