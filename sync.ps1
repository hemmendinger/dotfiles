# Syncs this dotfiles checkout with its remote: commits tracked changes, rebases
# onto upstream, pushes. Never adds untracked files. On a rebase conflict it
# aborts and leaves the repo clean for a human. Logs to .sync.log.
# Run it by hand, or from any scheduler you like.
$ErrorActionPreference = 'Stop'
$repo = $PSScriptRoot
$log = Join-Path $repo '.sync.log'
function Log($msg) { Add-Content -LiteralPath $log -Value ("{0} {1}" -f (Get-Date -Format s), $msg); Write-Output $msg }
function Git { & git -C $repo @args 2>&1; if ($LASTEXITCODE -ne 0) { throw "git $($args -join ' ') failed" } }
try {
    & git -C $repo add -u | Out-Null
    & git -C $repo diff --cached --quiet
    if ($LASTEXITCODE -ne 0) {
        Git commit -q -m "Auto-sync from $env:COMPUTERNAME" | Out-Null
        Log "committed local changes"
    }
    Git fetch -q origin | Out-Null
    & git -C $repo rebase -q '@{u}' 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        & git -C $repo rebase --abort 2>&1 | Out-Null
        Log "CONFLICT: rebase onto upstream failed and was aborted; resolve by hand"
        exit 1
    }
    $ahead = [int](& git -C $repo rev-list --count '@{u}..HEAD')
    if ($ahead -gt 0) { Git push -q origin HEAD | Out-Null; Log "pushed $ahead commit(s)" } else { Write-Output "up to date" }
} catch {
    Log "ERROR: $($_.Exception.Message)"
    exit 1
}
