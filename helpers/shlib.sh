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

    SCRIPT=""
    for fix in "$@";do
        case "$fix" in
            locale)
                    SCRIPT="$SCRIPT""export LC_ALL=\"\"\n"
                ;;
            no-steam-runtime)
                    read -r -d '' runtimeFix << EOF
# Remove steam-runtime from the games LD_LIBRARY_PATH
_runtimeFilter=""
oldIFS="\$IFS"
IFS=:
for component in \$LD_LIBRARY_PATH; do
    if ! echo "\$component"|grep -q steam-runtime; then
        _runtimeFilter="\$_runtimeFilter\$component:"
    fi
done
# Add workaround libraries if they are present on the system (ie. Arch)
if [ -d /usr/lib/steam ] || [ -d /usr/lib32/steam ]; then
    _runtimeFilter="\$_runtimeFilter/usr/lib/steam:/usr/lib32/steam"
fi
export LD_LIBRARY_PATH="\$_runtimeFilter"
_runtimeFilter=""
# Remove non-overlay preloads (added by the runtime)
for component in \$LD_PRELOAD;do
    if echo "\$component" |grep -q gameoverlay; then
        _runtimeFilter="\$_runtimeFilter\$component:"
    fi
done
export LD_PRELOAD="\$_runtimeFilter"

IFS=\$oldIFS
EOF
                    SCRIPT="$SCRIPT$runtimeFix"
                    ;;
            *)
                    echo "WARNING: UNKNOWN FIX: $fix"
                ;;
        esac
    done
    launchScriptWorkaround_manual "$FILE" "$SCRIPT"
}

function launchScriptWorkaround_manual ()
{
    FILE="$1";shift
    SCRIPT="$1";shift

    if [ ! -e "$FILE.real" ] && [ ! -e "$FILE" ]; then
        echo "Unable to create wrapper script for $FILE: original does not exist"
        return 1
    fi
    if [ ! -e "$FILE.real" ]; then
        mv "$FILE" "$FILE.real"
    fi

    echo "#!/bin/bash" > "$FILE"
    echo -e "$SCRIPT" >> "$FILE"
    echo "exec \"./$FILE.real\" \"\$@\"" >> "$FILE"
    chmod +x "$FILE"

}

function launchScriptWorkaround_undo
{
    FILE="$1";shift
    [ -e "$FILE.real" ] && mv "$FILE.real" "$FILE"
}
