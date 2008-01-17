"-------------------------------------------------------------------------------
"  Description: Insert modelines
"   Maintainer: Martin Krischik
"      $Author$
"               Janakiraman .S <prince@india.ti.com>
"	 $Date$
"	   $Id$
"    Copyright: Copyright (C) 2006 Martin Krischik
" Name Of File: plugin/modelines.vim
" Last Changed: Monday, 09 May 2006
"      Version: 2.0
"    $Revision$
"     $HeadURL$
"	 Usage: copy to plugin directory
"      History: 18.11.2006 MK Bram's suggestion for runtime integration
"		18.11.2006 MK "set: :" syntax for "/* */" languages   
"		17.09.2007 MK change to bundle use NERD_Commenter when
"		              available  
"-------------------------------------------------------------------------------

if version < 700
   finish
endif 

function! shell#Init ()
  if (expand("%:p:t")=="_vimshell.tmp")
    echo "Already there"
    call shell#Init_Syntax()
    call shell#Print_Prompt()
  else
    if ( bufexists ("_vimshell.tmp") )
      let a = bufwinnr("_vimshell.tmp")
      if ( a == -1 )
	sb _vimshell.tmp
	call shell#Init_Syntax()
      else
	execute "normal ".a."\<C-w>w"
      endif
    else
      sp _vimshell.tmp
      call shell#Init_Syntax()
    endif
    call shell#Print_Prompt()
  endif
endfunction

function! shell#Print_Prompt ()
  " If we had quit the window, The buffer might exist but its
  " contents are lost. Making sure there is a prompt in the last line
  " let @a = getline(".")
  let @a = getline("$")
  let foo = escape (@a,"\'")
  execute "let a = matchstr(\'".foo."\',\'".g:PROMPT."\')"
  if ( a == "" )
    if !( getline(".") == "" )
      execute "normal o"."\<Esc>"
    endif
    execute "normal " . "i\<C-R>=g:PROMPT\<CR>\<Esc>"
  else
    " If the line we are on has only the prompt , place the cursor at the end.
    let @a = getline(".")
    let foo = escape (@a,"\'")
    execute "let b = matchstr(\'".foo."\',\'".g:PROMPT."\\s*$\')"
    if !( b == "" )
      normal $
    endif
  endif
  let &modified = 0
endfunction

function! shell#Init_Syntax ()
  if !( exists("g:PROMPT") )
    let g:PROMPT = "{Shell}"
  endif
  execute "syn match VimShellType " . "\"".g:PROMPT."\""
  execute "hi link VimShellType LineNr"
  set wrap
endfunction

function shell#Process_Enter()
  normal 0
  normal "ayy 
  let foo = escape (@a,"\'")
  execute "let a = matchstr(\"".substitute(foo,'"','\\\"',"g")."\",\"".g:PROMPT."\")"
  " execute "let a = matchstr(\'".substitute(foo,'"','\\\"',"g")."\',\'".g:PROMPT."\')"
  " If the line does not match the prompt. It was probably the
  " output of a previously executed command. DONT execute those
  " as commands.
  if ( a == "" )
    echo "Not on the command line"
    normal j
  else
    execute "let @a = substitute(@a,\"".g:PROMPT."\",\"\",\"\")"
    if ( line(".") != line("$") )
      if ( ( @a =~ "\\w" ) && ( &modified == 0 ) )
	normal "aP
	execute "normal "."i\<C-R>=g:PROMPT\<CR>\<Esc>"
      endif
    endif
    " If the command is a cd, Change the working directory.
    let currline = 0
    if ( @a =~ "^cd\\>" )
      let @a = ":".@a
      normal @a
      if ( line(".") == line("$") )
	execute "normal o"."\<Esc>"
      endif
    " If it says clean, Clean up the screen.
    else
      if ( @a =~ "^clear\\>" )
	let @a = "ggdG"
	normal @a
      else
	if ( @a =~ "\\w" )
	  if ( @a =~ 'man' )
	    let currline = line(".")
	  else
	    let currline = 0
	  endif
	  let @a = ":r!".@a
	  normal @a
	  if ( line(".") == line("$") )
	    execute "normal o"."\<Esc>"
	  endif
	  if ( currline )
	    let lastline = line(".")
	    let Oldreport = &report
	    let &report = 10000
	    execute currline.",".lastline.'!col -b'
	    execute currline.",".lastline.'!uniq -u'
	    let &report = Oldreport
	    normal G
	  endif
	else
	  if ( line(".") == line("$") )
	    execute "normal o"."\<Esc>"
	  endif
	endif
      endif
    endif
    call shell#Print_Prompt()
    " if ( currline )
    "   execute currline + 1
    " endif
  endif
endfunction

augroup <SID>VimShellStuff
    autocmd!
    autocmd BufEnter _vimshell.tmp let &swapfile=0
    autocmd BufEnter _vimshell.tmp nnoremap <cr> :call shell#Process_Enter ()<cr>
    autocmd BufLeave _vimshell.tmp nunmap <cr>
    autocmd BufEnter _vimshell.tmp inoremap <cr> <Esc>:call shell#Process_Enter ()<cr>
    autocmd BufLeave _vimshell.tmp iunmap <cr>
    autocmd BufEnter _vimshell.tmp nmap q :hide<CR>
    autocmd BufLeave _vimshell.tmp nunmap q
augroup end

finish

" vim: textwidth=78 nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab
" vim: filetype=vim encoding=latin1 fileformat=unix
