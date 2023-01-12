# Beam-Releases

**A collection of versioned git submodules of all of the repos needed for working releases of Beam**

Apian has an awful lot of moving parts, and almost all of them are currently in development. For this reason Beam and other apps are currently built using project (source) references to the various Apian pieces, rather than nuget package references. WHile using a single "monorepo" might be a good idea, I'm not sure my git-fu is strong enough to manage something like that. So I'm going with separate package repositories.

Working on the code with things this works fine for me or anyone else who has already cloned all of the necessary Apian repos locally, but it's really a pain for anyone who just wants to "have a look" and maybe build and the Beam CLI and Unity applications.

This repository is my attempt at a solution. Cloning just it is all that is necessary to examine and build all of the different releases of Beam. I find that development is git submodules is a fragile and hairy affair, so I don't recommend doing it in this repo, but looking and building and running are easy.

As an extra added bonus, if someone is interested in creating an Apian app (which is kinda the point to all of this) but has no interest in working on the Apian codebase itself, a clone of this repo can be used to satisfy all of their project's build references.

## Installation

The Apian Framework runs under the open-source cross-platform .NET 6.0 (or newer) environment, so you will first have to install it. There are many tutorials on the web describing how to do this for almost any platform, but I usually find it easiest to simply go straight to the source:

[Get it from MicroSoft](https://dotnet.microsoft.com/download)

Once you have that installed, clone this repository and its submodules (make sure to use `--recurse submodules` )

`git clone --recurse-submodules https://github.com/Apian-Framework/Beam-Releases.git`

