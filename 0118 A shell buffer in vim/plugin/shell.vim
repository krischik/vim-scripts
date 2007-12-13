"	   FILE: /user/prince/Vim/Functions/Shell.vim
"	 AUTHOR: Janakiraman .S <prince@india.ti.com>
"		 Martin Krichik
" Last Modified: Sat, 18 Aug 2001 10:34:07 (IST)
"	  Usage: Just source this file.
"		 source Shell.vim
"	LICENSE: No Warranties. Use at  your own risk. Add stuff to taste.
"		 If you like this script type :help uganda<Enter>
"          	 If you want to show appreciation to the author, please
"          	 visit the UDAVUM KARANGAL website http://www.udavumkarangal.org/
"	  NOTES: Written to work with vim 7.0.


if exists("s:loaded_shell")
    finish
else
    let s:loaded_shell=1

    execute "49amenu <silent> Plugin.Buffers.Shell<Tab>" . escape(g:mapleader . "s" , '\') . " :call shell#Init ()<CR>"
    execute "nnoremap <silent> " . escape(g:mapleader . "s" , '\') . "      :call Shell#Init ()<CR>"
    execute "inoremap <silent> " . escape(g:mapleader . "s" , '\') . " <C-O>:call Shell#Init ()<CR>"
endif

finish

" vim: textwidth=78 nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab
" vim: filetype=vim encoding=latin1 fileformat=unix
