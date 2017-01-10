#!/bin/bash
# A part of steam-linux-workarounds
# Copyright (C) Eskild Hustvedt 2016
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
    # The problem is that Gone Home can't handle locales that don't use .
    # as a decimal separator
    launchScriptWorkaround "GoneHome.x86_64" "locale"
    launchScriptWorkaround "GoneHome.x86" "locale"
}
function undoPatch ()
{
    launchScriptWorkaround_undo "GoneHome.x86_64"
    launchScriptWorkaround_undo "GoneHome.x86"
}
