#!/bin/bash
# A part of steam-linux-workarounds
# Copyright (C) Eskild Hustvedt 2017
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# This library provides pre-defined common fixes for games.

function launchScriptWorkaround ()
{
    FILE="$1";shift

    if [ ! -e "$FILE.real" ]; then
        mv "$FILE" "$FILE.real"
    fi

    echo '#!/bin/bash' > "$FILE"

    for fix in "$@";do
        case "$fix" in
            locale)
                    echo "export LC_ALL=\"\"" >> "$FILE"
                ;;
            no-steam-runtime)
                    echo "export LD_LIBRARY_PATH=\"\"" >> "$FILE"
                    ;;
            *)
                    echo "WARNING: UNKNOWN FIX: $fix"
                ;;
        esac
    done

    echo "exec \"./$FILE.real\" \"\$@\"" >> "$FILE"
    chmod +x "$FILE"
}

function launchScriptWorkaround_undo
{
    FILE="$1";shift
    [ -e "$FILE.real" ] && mv "$FILE.real" "$FILE"
}
