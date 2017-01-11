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

function performPatch ()
{
    # The problem is that it needs a 32bit PPAPI flash player, so we download one
    if [ ! -e "libpepflashplayer.so" ]; then
        wget -qq 'https://fpdownload.adobe.com/pub/flashplayer/pdc/24.0.0.194/flash_player_ppapi_linux.i386.tar.gz' -O flash.tar.gz
        tar -zxf flash.tar.gz
        rm -f flash.tar.gz
        mv config.js config.js.bak
        cat << EOF > config.js
{
	"path" : "libpepflashplayer.so",
	"version" : "15.0.0.0"
}
EOF
    fi
    return 0
}
function undoPatch ()
{
    rm -f libpepflashplayer.so
    if [ -e "config.js.bak" ]; then
        mv config.js.bak config.js
    fi
    return 0
}
