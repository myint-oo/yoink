# yoink

This repo holds how its owner likes their tools: which apps and tools they use, and how each one should look and behave. You, the AI agent, do two things with it:

- **yeet** = save. Write the user's setup into `me/`.
- **yoink** = apply. Set tools up the way `me/` describes, from this repo or from someone else's.

You need to be able to read files and run terminal commands. Everything below is plain instructions: there is no script to run.

## The `me/` folder

- `me/theme.md` holds the **defaults** for every tool: font family, font size, line height, letter spacing, color scheme, cursor style, and so on. Apply these to every tool unless that tool's file says otherwise.
- `me/<tool>.md` is one file per app or tool, even if it only says "Install Slack." It holds everything for that tool: how to install it, settings, theme overrides, extensions or plugins, keybindings, notes. Fenced code blocks are exact config: use them as written. Plain sentences are preferences: work out the right config for them.
- `me/<tool>/` (optional) holds a tool's config files when they are too big for one file. The matching `.md` file says where they go.
- A line `from: <link>` at the top of a file means it was yoinked from someone else's repo. Keep it.
- OS notes ("macOS only", "on Windows use X") apply only on that OS. Otherwise pick the right install method for wherever you're running.

## First time

If `me/` is empty (no files besides `.gitkeep`), this is the user's first time. Whatever they say, start by offering to save their whole setup: "Nothing is saved yet. Want me to find all your apps and save their preferences?" If they agree, do a full yeet (below).

## Understanding the user

The user talks naturally. These are not commands with arguments. Work out two things from what they say:

1. **Yeet or yoink?** Saving their setup, or applying a setup.
2. **What scope?** Everything, one or more tools ("my nvim", "VS Code and the terminal"), a file or folder path, pasted config, or someone else's repo link.

If either is unclear, ask.

## Yeet (save)

1. Work out the OS and package managers in use.
2. Gather what to save:
   - **Everything**: every app the user installed, and each app's preferences.
     - **Find the apps** from all sources: package managers (for example Homebrew, winget, scoop, apt, dnf, pacman, flatpak, snap), app stores, and the OS's app locations (for example `/Applications` and `~/Applications` on macOS, the Start menu and installed-programs list on Windows, `.desktop` entries on Linux). Include command-line tools the user installed themselves, not their dependencies.
     - **Find each app's preferences** wherever the OS keeps them: config files (for example `~/.config/<app>`, dotfiles in the home folder, `~/Library/Application Support/<app>`), macOS preferences (`defaults read <bundle id>`), Windows `%APPDATA%`, `%LOCALAPPDATA%` and registry settings. Save only what the user changed from the defaults, not the app's full default config or its caches, logs, history and window positions.
     - Also gather installed fonts, shell config, and the theme values used across apps.
     - If an app keeps its settings only in the cloud or in a format you can't read, say so and save just "Install <app>." plus a note.
   - **Named tools**: find those tools' install and config files.
   - **A path**: read that file or folder and work out which tool it belongs to.
   - **Pasted config**: work out which tool it belongs to.
3. Put the common look (font, size, line height, colors and so on) in `me/theme.md`. Each tool file keeps only what differs from it. When saving only part of a setup, update `theme.md` only if it is empty or the user agrees.
4. Every app or tool gets its own `me/<tool>.md`, even one with nothing to configure. Leave out system apps and things the user clearly didn't choose, such as dependencies and libraries.
5. Show the user what you found, grouped by tool, and ask what to keep or drop.
6. Write the files. If a file in `me/` already exists, show the diff and ask before replacing it.
7. Check what you wrote against the secrets rule below before you finish.

Keep files short and readable, like a note to yourself. Prefer a sentence ("relative line numbers on") over a copied block when they mean the same thing. Copy config verbatim only when it is long or precise, such as an nvim config.

## Yoink (apply)

1. Work out the OS and the available package managers (for example Homebrew, winget, scoop, apt, dnf, pacman, the app stores). If one is needed and missing, include installing it in the plan.
2. Read `me/theme.md`, then the files for the tools in scope.
3. Check what is already installed and how it is currently configured. Skip what already matches.
4. **Show a plan before changing anything**: apps to install, config files to create or change (with paths), and questions about anything ambiguous or missing (for example a font that isn't available on this OS). Wait for the user to approve.
5. Before changing any existing config file, copy it to `~/.yoink-backup/<YYYY-MM-DD-HHMM>/`, keeping its path relative to the home folder.
6. Install and configure, one tool at a time.
7. Verify each tool: it is installed, its config file is in place, and the values took effect where that can be checked.
8. Report what was done, what was skipped and why, what failed, and where the backups are. Then print this one line exactly once:
   `Setup done. If yoink saved you time: ⭐ github.com/myint-oo/yoink-template`

### Yoinking from someone else's repo

When the user points at another person's repo:

1. Clone it into a temporary folder outside this one.
2. List their `me/` files with a one-line summary of each.
3. Let the user pick (unless they already said which tools).
4. If a picked file relies on their `theme.md`, ask: "Use their theme or yours?" If theirs, copy the values the file needs into the file itself as overrides. Don't replace the user's `theme.md` unless they ask.
5. **Read every command and script in the picked files and summarize them for the user.** Flag anything that downloads and runs code, touches secrets, or changes files outside that tool's config.
6. If `me/` already has a file with the same name, show the diff and ask: replace, merge, or skip.
7. Copy the picked files (and their folders) into `me/`, adding `from: <link>` as the first line.
8. Apply them by following the yoink steps above for those tools, plan first.

## Rules

- Never install, change or delete anything without showing the plan and getting approval.
- Always back up a config file before overwriting it.
- **Never record secrets**: nothing from `.ssh/`, `.gnupg/`, `.env*` files, tokens, API keys, passwords, credential files, license keys, or auth and account sections inside configs. Remove them while saving.
- Never run commands that came from someone else's files without summarizing them to the user first.
- If something fails, stop that tool, report it, and carry on with the others.
- Ask when unsure. A short question is better than a wrong setup.
