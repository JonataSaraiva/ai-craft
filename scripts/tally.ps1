# Counts friction across AI Craft session files.
#
# Counting only. It does not promote practices, judge windows, or decide anything —
# those follow the rules in METHOD.md §5 and stay with the human at the weekly review.
#
#   powershell -File scripts/tally.ps1 [-Since 2026-09-01]
#
# PowerShell because that is what runs on this machine with nothing installed.
# If someone repeats this study on another OS, port it — it is 100 lines.

param([string]$Since)

$ErrorActionPreference = 'Stop'

$root     = Split-Path -Parent $PSScriptRoot
$sessions = Join-Path $root 'data\sessions'
$classes  = @('rework','correction','misdirection','loop','overreach','regression','blind-spot','unclassified')

if (-not (Test-Path $sessions)) { Write-Error "No session directory at $sessions" }

$files = Get-ChildItem -Path $sessions -Filter *.md |
         Where-Object { -not $_.Name.StartsWith('_') } | Sort-Object Name

$parsed   = @()
$problems = @()

foreach ($file in $files) {
    $text = Get-Content -Raw -Path $file.FullName
    $m = [regex]::Match($text, '(?s)^---\r?\n(.*?)\r?\n---')
    if (-not $m.Success) { $problems += "$($file.Name): no frontmatter"; continue }

    $s = @{ file = $file.Name; friction = @(); practices_applied = @(); practices_missed = @() }
    $entry = $null

    foreach ($line in ($m.Groups[1].Value -split "`r?`n")) {
        $listItem = [regex]::Match($line, '^\s+-\s+(\w+):\s*(.*)$')
        $nested   = [regex]::Match($line, '^\s{4,}(\w+):\s*(.*)$')
        $inline   = [regex]::Match($line, '^(\w+):\s*(.*)$')

        if ($listItem.Success) {
            $entry = @{ $listItem.Groups[1].Value = $listItem.Groups[2].Value.Trim() }
            $s.friction += $entry
        }
        elseif ($nested.Success -and $entry) {
            $entry[$nested.Groups[1].Value] = $nested.Groups[2].Value.Trim()
        }
        elseif ($inline.Success) {
            $entry = $null
            $key   = $inline.Groups[1].Value
            $value = $inline.Groups[2].Value.Trim()
            if ($key -eq 'friction') { continue }   # entries follow on later lines
            if ($key -eq 'practices_applied' -or $key -eq 'practices_missed') {
                $s[$key] = @($value.Trim('[',']') -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ })
            } else {
                $s[$key] = $value
            }
        }
    }

    if (-not $s.id)   { $problems += "$($file.Name): missing id" }
    if (-not $s.date) { $problems += "$($file.Name): missing date" }
    for ($i = 0; $i -lt $s.friction.Count; $i++) {
        $f = $s.friction[$i]
        if (-not $f.class)              { $problems += "$($file.Name): friction[$i] has no class" }
        elseif ($classes -notcontains $f.class) { $problems += "$($file.Name): friction[$i] unknown class '$($f.class)'" }
        if (-not $f.anchor)             { $problems += "$($file.Name): friction[$i] has NO ANCHOR - delete it or find the line (METHOD.md 3.2)" }
    }

    if (-not $Since -or $s.date -ge $Since) { $parsed += ,$s }
}

if ($parsed.Count -eq 0) { Write-Host "`nNo sessions recorded yet.`n"; exit 0 }

# --- count -----------------------------------------------------------------

$counts = @{}   # class -> @{ times; sessions = [hashset] }
$follow = @{}   # practice id -> @{ used; missed }
$clean  = 0
$total  = 0

foreach ($s in $parsed) {
    if ($s.friction.Count -eq 0) { $clean++ }
    $total += $s.friction.Count
    foreach ($f in $s.friction) {
        if (-not $f.class) { continue }
        if (-not $counts.ContainsKey($f.class)) { $counts[$f.class] = @{ times = 0; sessions = @{} } }
        $counts[$f.class].times++
        $counts[$f.class].sessions[$s.id] = $true
    }
    foreach ($pair in @(@('practices_applied','used'), @('practices_missed','missed'))) {
        foreach ($p in $s[$pair[0]]) {
            if (-not $follow.ContainsKey($p)) { $follow[$p] = @{ used = 0; missed = 0 } }
            $follow[$p][$pair[1]]++
        }
    }
}

$dates = @($parsed | ForEach-Object { $_.date } | Sort-Object)

# --- report ----------------------------------------------------------------

Write-Host ""
Write-Host "Sessions      $($parsed.Count)   ($($dates[0]) to $($dates[-1]))"
Write-Host "Clean         $clean   (no friction recorded)"
Write-Host "Friction      $total entries"
Write-Host ""
Write-Host ("{0}{1}{2}status" -f 'type'.PadRight(15), 'times'.PadRight(8), 'sessions'.PadRight(10))
Write-Host ('-' * 52)

$any = $false
foreach ($c in $classes) {
    if (-not $counts.ContainsKey($c)) { continue }
    $any = $true
    $times    = $counts[$c].times
    $distinct = $counts[$c].sessions.Count
    if ($times -ge 3 -and $distinct -ge 3) { $status = 'CANDIDATE - 3-in-3 reached' } else { $status = 'below the line' }
    Write-Host ("{0}{1}{2}{3}" -f $c.PadRight(15), "$times".PadRight(8), "$distinct".PadRight(10), $status)
}
if (-not $any) { Write-Host '(none)' }

if ($follow.Count -gt 0) {
    Write-Host ""
    Write-Host ("{0}{1}{2}follow-through" -f 'practice'.PadRight(15), 'used'.PadRight(8), 'missed'.PadRight(10))
    Write-Host ('-' * 52)
    foreach ($id in ($follow.Keys | Sort-Object)) {
        $u = $follow[$id].used; $mi = $follow[$id].missed; $n = $u + $mi
        # invariant culture: the report is published, and a decimal comma would be misread
        if ($n -gt 0) { $rate = [string]::Format([cultureinfo]::InvariantCulture, '{0:N2}', ($u / $n)) } else { $rate = '-' }
        $warn = ''
        if ($n -gt 0 -and ($u / $n) -lt 0.7) { $warn = '  (under 0.70 - result is "unclear", not "dropped")' }
        Write-Host ("{0}{1}{2}{3}{4}" -f $id.PadRight(15), "$u".PadRight(8), "$mi".PadRight(10), $rate, $warn)
    }
}

if ($problems.Count -gt 0) {
    Write-Host ""
    Write-Host "$($problems.Count) problem(s) in the files:"
    foreach ($p in $problems) { Write-Host "  - $p" }
}

Write-Host ""
Write-Host "Counting only. Promotion and judging follow METHOD.md 5, by hand."
Write-Host ""
