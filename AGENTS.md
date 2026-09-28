# Notes for agents

- Multi-platform by design (Windows, macOS, Linux). Keep config OS-neutral;
  branch on the OS inside a config file, not in the repo layout.
- Plain git repo of config files, one directory per program, each with its own
  README. No symlinks, no dotfiles manager, no sync automation. Already decided.
- Each program's config is the live one; the machine holds only a pointer to it.
  Edit the config in the repo, never the pointer.
- Machine-generated state (caches, sessions, installed packages) stays out.
- Don't commit or push unless asked.

## Windows only

Shells inside the Claude desktop app see a virtualized `AppData\Roaming`:
writes there don't reach the real folder and files there may look missing. This
is expected and affects only the agent's view. Don't investigate or report it;
anything under `%APPDATA%` is for the user to do from a normal PowerShell window.
