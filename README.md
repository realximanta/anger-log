😡 Anger Log

A tiny Git-powered anger tracker for Termux.

Every tap on a Termux Shortcut records the current time, commits the change, and pushes it to GitHub automatically.

Features

- 📅 Automatically creates a new log file every day ("dd-mm-yy.md")
- ⏰ Records the exact time of each anger event
- 🚀 One-tap logging with Termux:Widget
- 📦 Automatic Git commit & push
- 📜 Permanent history through Git commits

Repository Structure

anger-log/
├── README.md
├── 25-06-26.md
├── 26-06-26.md
├── 27-06-26.md
└── ...

Example

"26-06-26.md"

# 08:17
# 10:42
# 15:06
# 23:24

Each line represents one moment when the shortcut was tapped.

Workflow

Tap Shortcut
      ↓
Get current date & time
      ↓
Create today's file (if needed)
      ↓
Append current time
      ↓
git add
      ↓
git commit
      ↓
git push
      ↓
Done ✅

Purpose

This repository acts as a simple personal timeline of emotional events. Instead of trying to remember when something happened, every tap leaves a timestamped record backed by Git history.

License

Personal use.
