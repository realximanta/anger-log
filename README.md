# 😡 Anger Log

A tiny Git-powered anger tracker for Termux.

Every time I get angry or someone gets angry at me, I tap a single Termux shortcut. The script automatically records the current time, commits the change, and pushes it to this repository.

## Structure

```
anger-log/
├── README.md
├── 25-06-26.md
├── 26-06-26.md
├── 27-06-26.md
└── ...
```

Each day gets its own Markdown file.

Example:

```md
# 08:14
# 10:36
# 16:09
# 23:24
```

Each line represents one anger event.

## Features

- 📅 Automatic daily log files (`dd-mm-yy.md`)
- 🕒 Records the exact time of every event
- ⚡ One-tap execution using Termux:Widget
- 📂 Git version history
- ☁️ Automatic GitHub commit & push
- 📜 Permanent timeline of anger events

## Why?

Instead of forgetting emotional moments, this repository keeps a simple timeline. Over weeks or months, it becomes easy to identify patterns, frequency, and changes over time.

---

*"Every tap becomes a timestamp. Every timestamp becomes a story."*
