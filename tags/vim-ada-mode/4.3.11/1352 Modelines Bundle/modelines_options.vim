"------------------------------------------------------------------------------
"  Description: Options setable by the Modeline bundle
"	   $Id$
"    Copyright: Copyright (C) 2006 Martin Krischik
"   Maintainer:	Martin Krischik
"      $Author$
"	 $Date$
"      Version: 2.0
"    $Revision$
"     $HeadURL$
"      History:	17.09.2007 MK change to bundle use NERD_Commenter when
"		              available  
"	 Usage: copy content into your .vimrc and change options to your
"		likeing.
"    Help Page: tail.txt
"------------------------------------------------------------------------------

echoerr 'It is suggested to copy the content of modeline_options into .vimrc!'
finish " 1}}}

" Section: Modelines options {{{1

   let g:mapleader	   = "<F12>"

" }}}1

" Section: Vimball options {{{1
:set noexpandtab fileformat=unix encoding=utf-8
:.+2,.+4 MkVimball modeline-2.0.vba

modeline_options.vim
plugin/modeline.vim
autoload/modeline.vim

" }}}1

" Section: Tar options {{{1

tar --create --bzip2		 \
   --file="modeline-2.0.tar.bz2" \
   modeline_options.vim		 \
   plugin/modeline.vim		 \
   autoload/modeline.vim	 ;

" }}}1

"------------------------------------------------------------------------------
"   Copyright (C) 2007	Martin Krischik
"
"   Vim is Charityware - see ":help license" or uganda.txt for licence details.
"------------------------------------------------------------------------------
" vim: textwidth=0 nowrap tabstop=8 shiftwidth=3 softtabstop=3 noexpandtab
" vim: foldmethod=marker
