# Steam Linux Workarounds

Some games on Steam for Linux work poorly on certain distributions, with
newer libraries, certain locales etc. This project intends to provide automated
fixes for these issues, by patching the games - ie. with additional scripts,
symlinks or installing libraries.

**WARNING**: These scripts are distributed in the hope that they will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
more details.

**NOTE**: The scripts have built-in support for reversing changes. Even so,
no guarantee is made that it will work and you may need to reinstall the games
if reversing the changes fails.

## Usage

**Apply all patches**

Run `./apply-patches --all` to apply all available patches

**Undo all patches**

Run `./apply-patches --all --undo` to undo all patches

**Apply a single patch**

Run `./apply-patches GAME` to apply a patch to a single game

**Additional options**

Run `./apply-patches --help` to list all command-line parameters.

## Adding new patches

See [CONTRIBUTING.md](CONTRIBUTING.md)
