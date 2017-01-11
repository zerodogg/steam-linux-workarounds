# Contributing to Steam Linux Workarounds

Steam Linux Workarounds has to be a community effort. Pull requests are
most welcome. This file documents how patches are written.

## Tree layout

Each patch has two files in ./patches, one .json that provides some basic
metadata used by `apply-patches` and one .sh that contains the script itself.
The files must have the same name, with the exception of the format-suffix.
(ie. Game.json and Game.sh).

### JSON-metadata

Right now the JSON-metadata only contains a single key "directoryName" which is
the name of the game directory as located in the steamapps/common directory of
a Steam installation.

### Scripts

The scripts are bash-scripts. They do nothing if executed directly. Each script
must have one function named `performPatch` and one function named `undoPatch`.
As their names indicate, these are used to apply a patch and undo an applied
patch. It must be possible to execute them multiple times (ie. undoPatch must
succeed even if the patch is not applied, and performPatch must succeed even if
the patch has already been applied).

`apply-patches` makes several guarantees about the execution environment:

* It is executed from the installation directory of the game (i.e.
  ~/.steam/root/steamapps/common/game)
* You have access to all functions from helpers/shlib.sh

## Builtin helpers

In `helpers/shlib.sh` there are some predefined helpers that can be used to
apply very common fixes to games (ie. disable the runtime for a game or
set the locale to C). If one matches the game, you can use those to not have
to write apply/undo logic yourself, otherwise you will have to write custom
logic. For an example of builtin logic see `patches/GoneHome.sh`, and for an
example of custom logic see `patches/Evoland.sh`.
