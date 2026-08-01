#!/bin/bash
cd "$(dirname "$0")"

echo "Checking for changes..."
git add -A

if git diff --cached --quiet; then
  echo "No new edits to commit."
else
  git commit -q -m "Update site $(date +'%Y-%m-%d %H:%M')"
fi

if [ -z "$(git log origin/main..HEAD 2>/dev/null)" ]; then
  echo ""
  echo "No changes to publish — everything is already up to date."
else
  echo "Pushing to GitHub..."
  if git push; then
    echo ""
    echo "Published! Cloudflare will update your live site in a few seconds."
  else
    echo ""
    echo "Something went wrong pushing to GitHub. See the error above."
  fi
fi

echo ""
read -p "Press Enter to close this window..."
