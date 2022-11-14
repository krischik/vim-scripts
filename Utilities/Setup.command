#!/bin/echo usage: source
########################################################### {{{1 ###########
#   Copyright © 2005 … 2013  Martin Krischik
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License
#   as published by the Free Software Foundation; either version 2
#   of the License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
############################################################################
#  $Author: krischik $
#  $Revision: 6762 $
#  $Date: 2015-01-16 15:19:00 +0100 (Fr, 16. Jan 2015) $
#  $Id: Setup.command 6762 2015-01-16 14:19:00Z krischik $
#  $HeadURL: svn+ssh://krischik@svn.code.sf.net/p/uiq3/code/trunk/Java/src/main/scripts/Setup.command $
########################################################### }}}1 ###########

fpath=(~/.functions ${fpath})

typeset -f -u realFile

typeset -x -g		     opt="/opt/local"
typeset -x -g		    WORK=$(realFile "/Work")
typeset -x -g	    PROJECT_NAME="${PROJECT_NAME-Vim}"

typeset -x -g	       Workspace=$(realFile "${Workspace-${WORK}/Workspaces/${PROJECT_NAME}}")
typeset -x -g	    PROJECT_HOME=$(realFile "${PROJECT_HOME-${WORK}/Projects/${PROJECT_NAME}}")

path=(${PROJECT_HOME}/Utilities ${path})

fpath=(${PROJECT_HOME}/Utilities ${fpath})

function lxpm ()
{
    if test -z "${1}"; then
	${VIM}/../../MacOS/Vim -g --servername ${PROJECT_NAME} 1>/dev/null 2>/dev/null &
    else
	${VIM}/../../MacOS/Vim -g --servername ${PROJECT_NAME} --remote-silent "${@}" 1>/dev/null 2>/dev/null &
    fi;
    return;
} # lxpm

############################################################ {{{1 ###########
# vim: set wrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
# vim: set textwidth=0 filetype=zsh fileencoding=utf8 foldmethod=marker nospell :
