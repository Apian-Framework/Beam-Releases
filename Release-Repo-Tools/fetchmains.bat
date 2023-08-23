@echo off
rem
rem Checks out and pulls the 'main' branch of every submodule.
rem This is almost always what you want to do if you want to create and a "what it's all
rem like now" branch of the -release repo.
rem
rem  ** Usage **
rem
rem a)  First you call this, which fetches all of the current "main" submodule branches
rem
rem b) Then ensure that the main [foo]-releases repo is on its main branch
rem
rem c) Then stage and commit all of the changes to the -release repo (the submodule updates you fetched)
rem
rem d) Then call "tagandpush", which will inform you if there are any uncommited changes. If so, fix 'em.
rem 
rem e) call "tagandpush" again and it'll create the tags and push the new branch to the main repo.
rem
rem if you want want some specfic other version of one or more of the submodule you'll need
rem to check it/tmen out befrore tagandpush

rem check for git lfs support
rem this is only necessary because of the big binary assets in the Beam.Unity repo.
rem
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
