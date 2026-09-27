# dotfiles

## Emacs

`emacs/init.el` is the Emacs init file. On Windows, Emacs reads it as
`%APPDATA%\.emacs` (that is where `~` resolves when `HOME` is not set), so the
file is symlinked there.

To set up the link on a Windows machine, open a normal PowerShell window
(Developer Mode or an elevated shell is required for symlinks) and run:

```powershell
.\install.ps1
```

Run it from a regular terminal, not from a shell inside the Claude desktop app:
that app is a packaged (MSIX) app whose child processes see a virtualized copy
of `AppData\Roaming`, so anything written there never reaches the real folder.
The script checks for this and refuses to run in that case.

Not tracked here, on purpose: `%APPDATA%\.emacs.d\` holds installed packages
(`elpa`), the saved desktop session, auto-save lists and backups. Packages are
listed in `package-selected-packages` inside `init.el`, so on a new machine run
`M-x package-install-selected-packages` to restore them.
