#!/data/data/com.termux/files/usr/bin/bash

# Exit immediately if any command fails.
set -e

# ===========================
# Configuration
# ===========================

# Local Git repository.
REPO="$HOME/anger-log"

# Git branch to push to.
BRANCH="main"

# ===========================
# Current date & time
# ===========================

# Example: 25-06-26
TODAY=$(date +"%d-%m-%y")

# Example: 21:35
NOW=$(date +"%H:%M")

# Today's log file.
TODAY_FILE="$TODAY.md"

# Daily statistics file.
TRACK_FILE="track.md"

# ===========================
# Verify repository exists
# ===========================

# Stop immediately if the folder isn't a Git repository.
[ -d "$REPO/.git" ] || {
    termux-toast "Repository not found!"
    exit 1
}

# Enter repository.
cd "$REPO"

# ===========================
# First-run setup
# ===========================

# Create README.md only once.
[ -f README.md ] || echo "# Anger Log" > README.md

# Create today's log if missing.
touch "$TODAY_FILE"

# Create track.md if missing.
touch "$TRACK_FILE"

# ===========================
# Record anger event
# ===========================

# Append the current time.
echo "# $NOW" >> "$TODAY_FILE"

# Count total anger events today.
COUNT=$(grep -c '^#' "$TODAY_FILE")

# ===========================
# Update track.md
# ===========================

# Remove today's previous summary.
grep -v "^# $TODAY\.md |" "$TRACK_FILE" > .track.tmp || true

# Replace the old track file.
mv .track.tmp "$TRACK_FILE"

# Write today's updated count.
echo "# $TODAY.md | $COUNT" >> "$TRACK_FILE"

# ===========================
# Stage changes
# ===========================

git add "$TODAY_FILE" "$TRACK_FILE"

# Nothing changed?
if git diff --cached --quiet; then
    termux-toast "Nothing to commit"
    exit 0
fi

# ===========================
# Commit
# ===========================

git commit -m "😡 $TODAY $NOW"

# ===========================
# Push to GitHub
# ===========================

if git push origin "$BRANCH"; then
    termux-toast "😡 Logged ($COUNT)"
else
    termux-toast "Push failed"
    exit 1
fi
