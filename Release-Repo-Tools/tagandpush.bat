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

echo.
echo Checking repository.

git diff --no-ext-diff --quiet --exit-code
if %ERRORLEVEL% neq 0 (
  echo Repository has uncommitted changes
  goto done
)

for /f %%a in ('git status --porcelain') do set res="%%a"
if  %res% == "??" (
  echo Repository has untracked files.
  goto done
)


echo.
echo Tagging current submodules as %RELEASE_NAME%
git submodule foreach "git tag %RELEASE_NAME%"

echo.
echo Pushing tagged submodules
git submodule foreach "git push --tags"

echo .
echo Creating and pushing release branch  %RELEASE_NAME%
git checkout -b %RELEASE_NAME%
git checkout main
git merge %RELEASE_NAME%
git push --all

:done


