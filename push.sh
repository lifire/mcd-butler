#!/usr/bin/env bash
# ============================================================
#  McButler - one-click commit & push to GitHub (contest entry)
#  BEFORE YOU RUN:
#    1. Edit REPO_URL below -> your PUBLIC repo URL
#    2. Make sure Git is installed and you are logged in
#       (GitHub token for HTTPS, or set up SSH key)
#  Usage:  bash push.sh
# ============================================================
set -u
REPO_URL="https://github.com/<your-github-username>/mcd-butler.git"

git init
git add .
git commit -m "feat: McButler - McDonald's all-in-one butler Skill (contest entry)"
git remote remove origin 2>/dev/null
git remote add origin "$REPO_URL"
git branch -M main
git push -u origin main

echo ""
echo "============================================================"
echo " Pushed. Next: open an Issue in the official repo to register:"
echo " https://github.com/M-China/mcd-developer-innovation-challenge/issues"
echo " (copy the text from ISSUE.md)"
echo "============================================================"
