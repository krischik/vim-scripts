"------------------------------------------------------------------------------
"  Description: Vim filetype plugin file
"     Language: BTM (Batch to Memory - 4NT, TakeCommand Script)
"	   $Id$
"   Maintainer: Martin Krischik <krischik@users.sourceforge.net>
"               Bram Moolenaar <Bram@vim.org>
"      $Author$
"	 $Date$
"      Version: 4.5
"    $Revision$
"     $HeadURL$
"      History: 08.07.2007 MK.
"    Help Page: ft-ada-plugin
"------------------------------------------------------------------------------
" btm filetype plugin file

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin") || version < 700
  finish
endif

" Behaves mostly like dosbatch
runtime! ftplugin/dosbatch.vim ftplugin/dosbatch_*.vim ftplugin/dosbatch/*.vim

" Section: File-Option {{{1
"
setlocal encoding=utf-8
setlocal wrap
setlocal smartcase
setlocal ignorecase

" Section: Comments {{{1
"
setlocal commentstring=::\ %s
setlocal complete=.,w,b,u,t,i

" Section: Tagging {{{1
"
setlocal iskeyword+=- 

" Section: Completion {{{1
"
setlocal omnifunc=syntaxcomplete#Complete
setlocal completefunc=btm#User_Complete

if exists ("g:btm_extended_completion")
   if mapcheck ('<C-N>','i') == ''
      inoremap <unique> <buffer> <C-N> <C-R>=btm#Completion("\<lt>C-N>")<cr>
   endif
   if mapcheck ('<C-P>','i') == ''
      inoremap <unique> <buffer> <C-P> <C-R>=btm#Completion("\<lt>C-P>")<cr>
   endif
   if mapcheck ('<C-X><C-]>','i') == ''
      inoremap <unique> <buffer> <C-X><C-]> <C-R>=<SID>btm#Completion("\<lt>C-X>\<lt>C-]>")<cr>
   endif
   if mapcheck ('<bs>','i') == ''
      inoremap <silent> <unique> <buffer> <bs> <C-R>=btm#Insert_Backspace ()<cr>
   endif
endif

" Section: Folding {{{1
"
setlocal foldmethod=marker

finish " 1}}}

"vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 expandtab :
"vim: set textwidth=0 filetype=vim foldmethod=marker nospell :
