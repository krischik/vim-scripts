"------------------------------------------------------------------------------
"  Description: Options setable by the Btm bundle
"     Language: BTM (Batch to Memory - 4NT, TakeCommand Script)
"          $Id$
"    Copyright: Copyright (C) 2007 Martin Krischik
"   Maintainer: Martin Krischik
"               John Leo Spetz <jls11@po.cwru.edu>
"      $Author$
"        $Date$
"      Version: 1.0
"    $Revision$
"     $HeadURL$
"      History: 22.11.2007 MK A new Btm Filetype Bundle 
"        Usage: copy content into your .vimrc and change options to your
"               likeing.
"    Help Page: ft_btm.txt
"------------------------------------------------------------------------------

echoerr 'It is suggested to copy the content of btm_options into .vimrc!'
finish " 1}}}

" Section: btm options {{{1

   let g:mapleader                        = "<F12>"
   let g:btm_highlight_identifier         = 1
   let g:btm_highlight_tabs               = 0
   let g:btm_highlight_unusual_comments   = 0
   let g:dosbatch_syntax_for_btm          = 0

" }}}1

" Section: Vimball options {{{1

:set noexpandtab fileformat=unix encoding=utf-8
:.+2,.+5 MkVimball btm-2.0.vba

btm_options.vim
autoload\btm.vim
ftplugin\btm.vim
syntax\btm.vim

" }}}1

" Section: Tar options {{{1

tar --create --bzip2          \
   --file="btm-2.0.tar.bz2"   \
   btm_options.vim            \
   autoload\btm.vim           \
   ftplugin\btm.vim           \
   syntax\btm.vim             ;

" }}}1

" Section: Svn options {{{1

svn copy                                                                               \
   https://vim-scripts.googlecode.com/svn/trunk/4NT%20Bundle/modelines_options.vim     \
   https://vim-scripts.googlecode.com/svn/tags/4NT%20Bundle 1.0/modelines_options.vim  \
   -m "Tag Version 1.0 of BTM Bundle";
   
" }}}1

"------------------------------------------------------------------------------
"   Copyright (C) 2007  Martin Krischik
"
"   Vim is Charityware - see ":help license" or uganda.txt for licence details.
"------------------------------------------------------------------------------
" vim: textwidth=0 nowrap tabstop=8 shiftwidth=3 softtabstop=3 expandtab
" vim: foldmethod=marker
