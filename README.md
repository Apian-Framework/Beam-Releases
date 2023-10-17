# Beam-Releases

**A collection of versioned git submodules of all of the repos needed for working releases of Beam**

Apian has an awful lot of moving parts, and almost all of them are currently in development. For this reason Beam and other apps are currently built using project (source) references to the various Apian pieces, rather than Nuget package references. While using a single "monorepo" might be a good idea, I'm not sure my git-fu is strong enough to manage something like that. So I'm going with separate package repositories.

Working on the code with things this way works fine for me or anyone else who has already cloned all of the necessary Apian repos locally, but it's really a pain for anyone who just wants to "have a look" and maybe build and the Beam CLI and Unity demo applications.

This repository is my attempt at a solution. Cloning just it is all that is necessary to examine and build all of the different releases of Beam. I find that development within git submodules is a fragile and hairy affair, so I don't recommend doing it in this repo - but looking and building and running are easy.

As an extra added bonus, if someone is interested in creating an Apian app (which is kinda the point to all of this) but has no interest in working on the Apian codebase itself, a clone of this repo can be used to satisfy all of their project's build references.

---

## Installation

### .NET
The Apian Framework runs under the open-source cross-platform .NET 6.0 (or newer) environment, so you will first have to install it. There are many tutorials on the web describing how to do this for almost any platform, but I usually find it easiest to simply go straight to the source:

[Get .NET from MicroSoft](https://dotnet.microsoft.com/download)

### git LFS
The `Beam.Unity` project - which is probably what you are looking to build - makes use of `git lfs` (Large File Storage) to sensibly manage large binary files. LFS support if not installed by default in `git` so you will need to make sure that you have it installed.

To find out, enter:

`git lfs --version`

If `lfs` is installed you will see something like:
```
git-lfs/2.11.0 (GitHub; windows amd64; go 1.14.2; git 48b28d97)
```

if not, it will be more like:
```
fatal: 'lfs' appears to be a git command, but we were not
able to execute it. Maybe git-lfs is broken?
```

If it is not installed then you will need to follow the instructions at https://git-lfs.com/ to download and install it on your system.


### Beam-Releases
Once you have .NET installed, clone this repository and its submodules (make sure to use `--recurse-submodules`)

`git clone --recurse-submodules https://github.com/Apian-Framework/Beam-Releases.git`

**Important:** Make sure `git lfs` is installed before you do this (see above.)  If LFS support is not installed the clone will appear to proceed to completion _without any sort of warning or error message_. Any large binary files, however, will have in their place small text "placeholder" files and attempts to load or build the `Beam.Unity` project will result in "missing assembly" errors.

If you want to make sure this hasn't happened check the DLLs (in `Beam-Releases\Beam.Unity\Assets\Plugins\Nethereum` for instance) and make sure they are larger than a few hundred bytes in size.

---

## Selecting a Release

Immediately after you clone it, the repository will have the `main` branch checked out, which generally corresponds to he most recent release. To see a list of the releases available, use the command

`git branch -a`

to list all of the branches. Initially the list will contain `main` and all of the available remote branches. Setting the release version is just a matter of switching to a particular branch. So, to switch to the branch `remotes/origin/REL_230112b` you would execute:

`git switch --recurse-submodules REL_230112b`

and git will create a local tracking branch corresponding to the remote one and make it current.

*Note:* Because these "releases" are really just collections of particular versions of the various repos and don't correspond to any overall feature or bug-fix changes, the version names do not follow the semver format. Most of them simply represent that date. `REL_230112b`, for instance, is the 2nd release for January 11, 2023.

---

## Building Beam.Cli

To build the console version of Beam you will first need to open a terminal. Unfortunately, .NET doesn't (yet?) have the concept of a default project for a solution, so you either have to specify a project file in your commands, or actually be in the directory containing the project file. The latter is usually easier, so:

`cd Beam.CLI/src/BeamCli`

To make sure everything is in place, you can restore all of the dependencies:

`dotnet restore`

or actually just try running the app:

`dotnet run -- --help`

will list the options. To learn more about them check out the [Beam.Cli readme](https://github.com/Apian-Framework/Beam.Cli#readme)

---

## Building Beam.Unity

To build Beam under Unity 3D you will have to have a licensed copy of Unity on you development machine.

The project references for  Unity are all in `Beam.Unity/packages/manifest.json` and by default expect all of the dependencies to be in folders "beside" `Beam.Unity`. Since that's how they are organized in this repository all you should need to do is to start Unity Hub and open the Beam.Unity folder as a project.

---

## Using this repository to satisfy project references in your own builds

TBD (Hint: uses `Directory.Build.props`)
