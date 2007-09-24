"------------------------------------------------------------------------------
"  Description: Options setable by the rainbow_parenthsis plugin
"	   $Id$
"    Copyright: Copyright (C) 2006 Martin Krischik
"   Maintainer:	Martin Krischik (krischik@users.sourceforge.net)
"      $Author$
"	 $Date$
"      Version: 3.0
"    $Revision$
"     $HeadURL$
"      History:	17.11.2006 MK rainbow_parenthsis_Options
"               01.01.2007 MK Bug fixing
"	 Usage: copy content into your .vimrc and change options to your
"		likeing.
"    Help Page: rainbow_parenthsis.txt
"------------------------------------------------------------------------------

echoerr 'It is suggested to copy the content of ada_options into .vimrc!'
finish " 1}}}

" Section: rainbow_parenthsis options {{{1

" }}}1

" Section: Vimball options {{{1
:set noexpandtab fileformat=unix encoding=utf-8
:.+2,.+4 MkVimball rainbow_parenthsis-3.0.vba

rainbow_parenthsis_options.vim
autoload/rainbow_parenthsis.vim
plugin/rainbow_parenthsis.txt


" }}}1

" Section: Tar options {{{1

tar --create --bzip2		 \
   --file="rainbow_parenthsis-3.0.tar.bz2"	 \
   rainbow_parenthsis_options.vim		 \
   autoload/rainbow_parenthsis.vim		 \
   plugin/rainbow_parenthsis.vim		 ;

" }}}1

"------------------------------------------------------------------------------
"   Copyright (C) 2006	Martin Krischik
"
"   Vim is Charityware - see ":help license" or uganda.txt for licence derainbow_parenthsiss.
"------------------------------------------------------------------------------
" vim: textwidth=0 nowrap tabstop=8 shiftwidth=3 softtabstop=3 noexpandtab
" vim: foldmethod=marker
