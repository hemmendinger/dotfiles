# Sets up Emacs to use this repo on Windows by writing a one-line stub at
# %APPDATA%\.emacs that loads emacs/init.el from this checkout (Emacs reads
# %APPDATA%\.emacs when HOME is not set). No symlinks, no admin, no Developer
# Mode needed. Safe to re-run.
$ErrorActionPreference = 'Stop'

$repo = $PSScriptRoot
$target = (Join-Path $repo 'emacs/init.el').Replace([char]92, '/')
$emacsHome = $env:APPDATA
$stub = Join-Path $emacsHome '.emacs'
$stubBody = ";; Managed by $repo\install.ps1 -- the real config is in the dotfiles repo.`r`n(load `"$target`")`r`n"

# Refuse to run where AppData\Roaming is virtualized (e.g. a shell spawned by a
# packaged app such as the Claude desktop app): writes there land in the app's
# private cache, not the folder Emacs reads. Detect it with a probe file.
$probeName = '.dotfiles-probe-' + [guid]::NewGuid().ToString('N')
$probe = Join-Path $emacsHome $probeName
[IO.File]::WriteAllText($probe, 'probe')
try {
    $shadow = Get-ChildItem -LiteralPath (Join-Path $env:LOCALAPPDATA 'Packages') -Directory -Force -ErrorAction SilentlyContinue |
        ForEach-Object { Join-Path $_.FullName "LocalCache\Roaming\$probeName" } |
        Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
} finally { [IO.File]::Delete($probe) }
if ($shadow) { throw "AppData\Roaming is virtualized in this shell (probe landed in $shadow). Run install.ps1 from a normal PowerShell window." }

if ((Test-Path -LiteralPath $stub) -and ([IO.File]::ReadAllText($stub) -eq $stubBody)) {
    Write-Output "Stub already in place: $stub"
} else {
    if (Test-Path -LiteralPath $stub) {
        $backup = "$stub.pre-dotfiles"
        Move-Item -LiteralPath $stub -Destination $backup
        Write-Output "Moved existing $stub to $backup (compare it against emacs\init.el before deleting)"
    }
    [IO.File]::WriteAllText($stub, $stubBody, [Text.Encoding]::ASCII)
    Write-Output "Wrote stub $stub -> $target"
}
