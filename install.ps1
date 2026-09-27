# Links this repo's Emacs config into place on Windows:
#   %APPDATA%\.emacs  ->  <repo>\emacs\init.el
# Emacs on Windows reads ~/.emacs, and with HOME unset (the normal case when
# Emacs is started from the Start menu) ~ resolves to %APPDATA%. If you set
# HOME for Emacs, change $emacsHome below.
# Needs Developer Mode enabled or an elevated shell. Uses mklink because
# Windows PowerShell 5.1's New-Item cannot create symlinks under Developer
# Mode without elevation.
$ErrorActionPreference = 'Stop'

$target = Join-Path $PSScriptRoot 'emacs\init.el'
$emacsHome = $env:APPDATA
$link = Join-Path $emacsHome '.emacs'

# Refuse to run where AppData\Roaming is virtualized, e.g. in a shell spawned
# by a packaged (MSIX) app such as the Claude desktop app. Such shells write to
# <package>\LocalCache\Roaming instead of the real folder Emacs reads, and
# symlinks created there do not even resolve. Detect it by writing a probe file
# and looking for it in every package's overlay folder.
$probeName = '.dotfiles-probe-' + [guid]::NewGuid().ToString('N')
$probe = Join-Path $emacsHome $probeName
[IO.File]::WriteAllText($probe, 'probe')
try {
    $shadow = Get-ChildItem -LiteralPath (Join-Path $env:LOCALAPPDATA 'Packages') -Directory -Force -ErrorAction SilentlyContinue |
        ForEach-Object { Join-Path $_.FullName "LocalCache\Roaming\$probeName" } |
        Where-Object { Test-Path -LiteralPath $_ } |
        Select-Object -First 1
} finally {
    [IO.File]::Delete($probe)
}
if ($shadow) {
    throw "AppData\Roaming is virtualized in this shell (the probe landed in $shadow). Run install.ps1 from a normal PowerShell window."
}

if (Test-Path -LiteralPath $link) {
    $item = Get-Item -LiteralPath $link -Force
    if ($item.LinkType -eq 'SymbolicLink' -and "$($item.Target)" -eq $target) {
        Write-Output "Already linked: $link -> $target"
        return
    }
    $backup = "$link.pre-dotfiles"
    Move-Item -LiteralPath $link -Destination $backup
    Write-Output "Moved existing $link to $backup"
}

cmd /c mklink "$link" "$target" | Out-Null
if ($LASTEXITCODE -ne 0) { throw "mklink failed with exit code $LASTEXITCODE" }

# Make sure the link actually resolves before declaring success.
try { [void](Get-Content -LiteralPath $link -TotalCount 1 -ErrorAction Stop) }
catch { throw "Created $link but it does not resolve: $($_.Exception.Message.Trim())" }
Write-Output "Linked $link -> $target"
