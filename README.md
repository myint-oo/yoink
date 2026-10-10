# yoink

**Your tools, set up your way, by AI.**

Tell your AI to yeet, and it saves how you've set up your tools: theme, font, font size, line height, spacing, shortcuts, extensions, everything. Tell it to yoink, and it sets them all up exactly like that again, as many times as you need.

Like someone else's setup? Take it the same way.

It's like dotfiles, except the AI does the work: no scripts, no symlinks, nothing to maintain.

## Yeet and yoink

**Yeet means save.** Your AI looks at how your tools are set up right now and saves all of it in this repo.

**Yoink means set up.** Your AI reads what's saved in this repo and sets your tools up exactly that way.

Just talk to your AI the way you normally would:

- "yeet" saves your whole setup.
- "yeet my VS Code" saves only VS Code.
- "yoink" sets up everything you saved.
- "yoink my nvim" sets up only nvim.
- "yoink Alex's terminal from github.com/alex/yoink" sets up someone else's terminal the way they have it.

There's nothing to memorize. The AI understands what you mean.

## Getting started

You need the [GitHub CLI](https://cli.github.com) installed and logged in (`gh auth login`).

**1. Make your own private copy**

```
gh repo create yoink --template myint-oo/yoink-template --private --clone && cd yoink
```

**2. Open your AI in that folder and send**

```
yeet
```

The first time, it finds all your apps and their preferences and asks what to keep.

**3. Save it to GitHub**

```
git add -A && git commit -m "my setup" && git push
```

Done.

## Getting your setup back

**1. Get your copy**

```
gh repo clone yoink && cd yoink
```

**2. Open your AI in that folder and send**

```
yoink
```

It shows you what it will set up, waits for your OK, then sets everything up.

## What gets saved

One plain text file per tool, plus `theme.md` for the look you want everywhere:

```
me/
├── theme.md     ← font, size, line height, colors for every tool
├── vscode.md
├── raycast.md
└── nvim.md
```

A file reads like a note to yourself:

```md
# VS Code

Use theme.md for font, size and colors.

## Extensions
- Vim, GitLens, Prettier

## Settings
- Relative line numbers on, minimap off, sidebar on the right.
```

## Safe by default

- The AI tells you what it's about to do and waits for your OK.
- It backs up your current settings before replacing them.
- It never writes down passwords, keys or tokens.
- Before using anything from someone else's setup, it explains what it does.

Works with any AI agent that can read files and run commands: Claude Code, Codex, Cursor, Copilot, Gemini, and others.

---

⭐ If this saved you time, [star the repo](https://github.com/myint-oo/yoink-template).
