@echo off
REM ============================================================
REM  McButler - one-click commit & push to GitHub (contest entry)
REM  BEFORE YOU RUN:
REM    1. Install Git for Windows (https://git-scm.com)
REM    2. Edit REPO_URL below -> your PUBLIC repo URL
REM    3. Login: use GitHub token for HTTPS, or set up SSH key
REM  Then double-click this file (or run: push.bat)
REM ============================================================
set "REPO_URL=https://github.com/<your-github-username>/mcd-butler.git"

git init
git add .
git commit -m "feat: McButler - McDonald's all-in-one butler Skill (contest entry)"
git remote remove origin 2>nul
git remote add origin %REPO_URL%
git branch -M main
git push -u origin main

echo.
echo ============================================================
echo  Pushed. Next: open an Issue in the official repo to register:
echo  https://github.com/M-China/mcd-developer-innovation-challenge/issues
echo  (copy the text from ISSUE.md)
echo ============================================================
pause
