@echo off
rem
rem Creates and pushes a new "release"
rem Assumes all of the local submodules are as they should be for the release.
rem
rem When run with a name for the release,  this script first creates a tag with that name
rem in each of the submodules' repositories, and then pushes them to github
rem Then the script creates a new *branch* with that name in the current repo and
rem pushes the branch.


set RELEASE_NAME=%1
if  "%RELEASE_NAME%" == "" (
  echo usage: tagandpush ^<RELEASE_NAME^>
  exit /b
)

rem check for git lfs support
rem LFS is only necessary because the Beam.Unity repo contains big binary resource files.
echo Checking for git Large File Storage support...
for /f "delims=" %%a in ('git lfs version^|findstr /B /R /C:"^git-lfs/[0-9\.]* (.*)"') do @set lfsresult=%%a
if  "%lfsresult%" == "" (
  echo Git LFS not installed. see https://git-lfs.github.com/
  exit /b
)
echo LFS installed.

rem I didn't have a lot of success checking to see if the repo was had
rem uncommitted changes or untracked files rem programatically
rem (using `git status --porcelain` and `git diff`)
rem so I decided it was better anyway just to show the status and ask

echo.
echo Checking repository status:
echo.
git status
echo.

set /p PROCEED="OK to proceed? (y/N): "
if NOT "%PROCEED%" == "y"  exit /b

echo.
echo Tagging current submodules as %RELEASE_NAME%
git submodule foreach "git tag %RELEASE_NAME%"

echo.
echo Pushing tagged submodules
git submodule foreach "git push --tags"

echo .
echo Creating release branch  %RELEASE_NAME%, merging into main, and pushing it all.
git checkout -b %RELEASE_NAME%
git switch main
git merge %RELEASE_NAME%
git push --all


