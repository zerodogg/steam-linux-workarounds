#!/bin/bash
# A part of steam-linux-workarounds
# Copyright (C) Eskild Hustvedt 2017
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
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
    launchScriptWorkaround_manual "CivBE" "export LD_PRELOAD='./libcxxrt.so:/usr/\$LIB/libstdc++.so.6' ./CivBE.real"
    return 0
}
function undoPatch ()
{
    launchScriptWorkaround_undo "CivBE"
    return 0
}

