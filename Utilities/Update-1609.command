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

pushd "1609 Ada Bundle"
  gcp --verbose --archive --update "ada_options.vim"  "${HOME}/vimfiles/bundles/.cache/.vimrc/.dein/"
  gcp --verbose --archive --update "autoload/"*.vim   "${HOME}/vimfiles/bundles/.cache/.vimrc/.dein/autoload/"
  gcp --verbose --archive --update "compiler/"*.vim   "${HOME}/vimfiles/bundles/.cache/.vimrc/.dein/compiler/"
  gcp --verbose --archive --update "doc/"*.txt        "${HOME}/vimfiles/bundles/.cache/.vimrc/.dein/doc/"
  gcp --verbose --archive --update "ftdetect/"*.vim   "${HOME}/vimfiles/bundles/.cache/.vimrc/.dein/ftdetect/"
  gcp --verbose --archive --update "ftplugin/"*.vim   "${HOME}/vimfiles/bundles/.cache/.vimrc/.dein/ftplugin/"
  gcp --verbose --archive --update "indent/"*.vim     "${HOME}/vimfiles/bundles/.cache/.vimrc/.dein/indent/"
  gcp --verbose --archive --update "plugin/"*.vim     "${HOME}/vimfiles/bundles/.cache/.vimrc/.dein/plugin/"
  gcp --verbose --archive --update "syntax/"*.vim     "${HOME}/vimfiles/bundles/.cache/.vimrc/.dein/syntax/"
popd

############################################################ {{{1 ###########
# vim: set nowrap tabstop=8 shiftwidth=2 softtabstop=2 expandtab :
# vim: set textwidth=0 filetype=zsh foldmethod=marker nospell :
