#!/data/data/com.termux/files/usr/bin/bash

# ==========================================
# Anger Log
# ------------------------------------------
# Every execution:
#   • Records the current time in today's log
#   • Updates today's total count in track.md
#   • Commits & pushes to GitHub
# ==========================================

set -e

# ==========================================
# CONFIGURATION
# ==========================================

REPO="$HOME/anger-log"
BRANCH="main"

# ==========================================
# CURRENT DATE & TIME
# ==========================================

TODAY=$(date +"%d-%m-%y")
NOW=$(date +"%H:%M")

TODAY_FILE="$TODAY.md"
TRACK_FILE="track.md"

# ==========================================
# CHECK REPOSITORY
# ==========================================

if [ ! -d "$REPO/.git" ]; then
    termux-toast "Repository not found!"
    exit 1
fi

cd "$REPO"

# ==========================================
# CREATE README (FIRST RUN ONLY)
# ==========================================

if [ ! -f README.md ]; then
cat > README.md <<EOF
# Anger Log

Every tap records one anger event.

Each day has its own file.

track.md stores the daily totals.
EOF
fi

# ==========================================
# CREATE TRACK FILE (FIRST RUN ONLY)
# ==========================================

touch "$TRACK_FILE"

# ==========================================
# CREATE TODAY'S FILE
# ==========================================

touch "$TODAY_FILE"

# ==========================================
# APPEND CURRENT TIME
# ==========================================

echo "# $NOW" >> "$TODAY_FILE"

# ==========================================
# COUNT TODAY'S TOTAL EVENTS
# ==========================================

COUNT=$(grep -c "^#" "$TODAY_FILE")

# ==========================================
# UPDATE track.md
#
# If today's entry exists:
#   Replace it
#
# Otherwise:
#   Append it
# ==========================================

if grep -q "^# $TODAY.md |" "$TRACK_FILE"; then

    sed -i "s/^# $TODAY.md | .*/# $TODAY.md | $COUNT/" "$TRACK_FILE"

else

    echo "# $TODAY.md | $COUNT" >> "$TRACK_FILE"

fi

# ==========================================
# STAGE FILES
# ==========================================

git add "$TODAY_FILE" "$TRACK_FILE" README.md

# ==========================================
# COMMIT
# ==========================================

git commit -m "😡 $TODAY $NOW" >/dev/null 2>&1 || {
    termux-toast "Nothing to commit"
    exit 0
}

# ==========================================
# PUSH
# ==========================================

if git push origin "$BRANCH" >/dev/null 2>&1; then
    termux-toast "Logged 😡 ($COUNT)"
else
    termux-toast "Push failed!"
fi
