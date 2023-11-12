#!/opt/local/bin/zsh
############################################################# {{{1 ##########
#  Copyright © 2019 … 2020 Martin Krischik «krischik@users.sourceforge.net»
#############################################################################
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or ENDIFFTNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see «http://www.gnu.org/licenses/».
############################################################# }}}1 ##########

setopt No_XTrace
setopt Err_Exit

setopt Err_Exit
setopt No_XTrace

if test ${#} -eq 2; then
    in_Name="${1-Martin Krischik}"
    in_Mail="${2-krischik@users.sourceforge.net}"

    git config "user.name"	    "${in_Name}"
    git config "user.email"	    "${in_Mail}"
    git config "credential.helper"  "store"
    git config "push.default"	    "current"
    git config "pull.rebase"	    "false"
    git config "pull.ff"	    "only"
    git config "merge.ff"	    "false"

    if ! git branch --set-upstream-to="remotes/origin/master" "master"; then
	git checkout --track "remotes/origin/master"
    fi

    if ! git branch --set-upstream-to="remotes/origin/develop" "develop"; then
        if ! git checkout --track "remotes/origin/develop"; then
            git branch   "develop"
            git checkout "develop"
            git push --set-upstream
        fi
    fi

    git flow init
else
   echo '
Git-Setup-Clone Name Email

    Branch  User name
    Branch  User email
'
fi

############################################################ {{{1 ###########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 expandtab :
# vim: set textwidth=0 filetype=zsh foldmethod=marker nospell :
