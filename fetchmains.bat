@echo off

rem check for git lfs support
echo Checking for git Large File Storage support...
for /f "delims=" %%a in ('git lfs version^|findstr /B /R /C:"^git-lfs/[0-9\.]* (.*)"') do @set lfsresult=%%a
if  "%lfsresult%" == "" (
  echo Git LFS not installed. see https://git-lfs.github.com/
  exit /b
)
echo LFS installed.

rem checkout "main" for all the submodules then pull
git submodule update
git submodule foreach "git checkout main"
git submodule foreach "git pull --no-rebase"
if %ERRORLEVEL% neq 0 (
  echo Git pull failed. Fix the problem and try again.
  exit /b 1
)
