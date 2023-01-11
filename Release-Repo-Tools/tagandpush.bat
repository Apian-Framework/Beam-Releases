@echo off
rem
rem Creates and pushes a new "release"
rem Assumes all of the local submodules are as they should be for the release.
rem
rem When run with a name for the release,  this script first creates a tag with that name
rem in each of the submodules' repositories, and then pushes them to github
rem Then the script creates a new *branch* with that name in the current repo and
rem pushes the branch.


set RELEASE_TAG=%1
if  "%RELEASE_TAG%" == "" (
  echo usage: tagandpush ^<RELEASE_TAG^>
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
echo Tagging current submodules as %RELEASE_TAG%
git submodule foreach "git tag %RELEASE_TAG%"

echo.
echo Pushing tagged submodules
git submodule foreach "git push --tags"

echo .
echo Creating and pushing release branch  %RELEASE_TAG%
git checkout -b %RELEASE_TAG%
git push --all






