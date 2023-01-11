@echo off

set RELEASE_TAG=%1
if  "%RELEASE_TAG%" == "" (
  echo usage: tagandpush ^<RELEASE_TAG^>
  exit /b
)

rem check for git lfs support
echo Checking for git Large File Storage support...
for /f "delims=" %%a in ('git lfs version^|findstr /B /R /C:"^git-lfs/[0-9\.]* (.*)"') do @set lfsresult=%%a
if  "%lfsresult%" == "" (
  echo Git LFS not installed. see https://git-lfs.github.com/
  exit /b
)
echo LFS installed.

rem checkout "main" for all the submodules
rem and then pull from origin
echo Updating all submosules to current "main" branch
git submodule update
git submodule foreach "git checkout main"
git submodule foreach "git pull --no-rebase"
if %ERRORLEVEL% neq 0 (
  echo Git pull failed. Fix the problem and try again.
  exit /b 1
)

echo Tagging current version as %RELEASE_TAG%
git submodule foreach "git tag %RELEASE_TAG%"
git submodule foreach "git push --tags"

git tag %RELEASE_TAG%
git push --tags






