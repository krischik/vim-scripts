"-------------------------------------------------------------------------------
"  Description: Quick Font changer
"          $Id$
"    Copyright: Copyright (C) 2006 Martin Krischik
"   Maintainer: Martin Krischik
"      $Author$
"        $Date$
"      Version: 1.5
"    $Revision$
"     $HeadURL$
"      History: 01.11.2006 MK Sun Solaris Support 
"	 Usage: copy to plugin directory.
"-------------------------------------------------------------------------------

if exists("g:loaded_fonts") || 
    \ ! has ("gui_running")
    finish
else
    let g:loaded_fonts=1

    if has ("vms") || has ("gui_motif")
	let g:Font_L1="-misc-fixed-medium-r-normal-*-14-*-*-*-c-*-iso8859-1"
	let g:Font_L2="-misc-fixed-medium-r-normal-*-18-*-*-*-c-*-iso8859-1"
	let g:Font_L3="-misc-fixed-medium-r-normal-*-20-*-*-*-c-*-iso8859-1"
	let g:Font_U1="-misc-fixed-medium-r-normal-*-14-*-*-*-c-*-iso10646-1"
	let g:Font_U2="-misc-fixed-medium-r-normal-*-18-*-*-*-c-*-iso10646-1"
	let g:Font_U3="-misc-fixed-medium-r-normal-*-20-*-*-*-c-*-iso10646-1"
	let g:Font_S1="132 60"
	let g:Font_S2="96 45"
	let g:Font_S3="96 42"
    elseif has ("gui_win32")
	let g:Font_L1="Bitstream_Vera_Sans_Mono:h9:cANSI"
	let g:Font_L2="Bitstream_Vera_Sans_Mono:h11:cANSI"
	let g:Font_L3="Bitstream_Vera_Sans_Mono:h13:cANSI"
	let g:Font_U1="Bitstream_Vera_Sans_Mono:h9:cDEFAULT"
	let g:Font_U2="Bitstream_Vera_Sans_Mono:h11:cDEFAULT"
	let g:Font_U3="Bitstream_Vera_Sans_Mono:h13:cDEFAULT"
	let g:Font_S1="132 60"
	let g:Font_S2="96 45"
	let g:Font_S3="96 42"
    elseif has ("gui_gtk")
	let g:Font_L1="Bitstream Vera Sans Mono 9"
	let g:Font_L2="Bitstream Vera Sans Mono 11"    
	let g:Font_L3="Bitstream Vera Sans Mono 13"
	let g:Font_U1=g:Font_L1
	let g:Font_U2=g:Font_L2
	let g:Font_U3=g:Font_L3
	let g:Font_S1="132 48"
	let g:Font_S2="96 42"
	let g:Font_S3="96 38"
    elseif has ("gui_kde")
	let g:Font_L1="Bitstream Vera Sans Mono/9/-1/5/50/0/0/0/1/0"
	let g:Font_L2="Bitstream Vera Sans Mono/11/-1/5/50/0/0/0/1/0"
	let g:Font_L3="Bitstream Vera Sans Mono/13/-1/5/50/0/0/0/1/0"
	let g:Font_U1=g:Font_L1
	let g:Font_U2=g:Font_L2   
	let g:Font_U3=g:Font_L3
	let g:Font_S1="132 49"
	let g:Font_S2="96 40"
	let g:Font_S3="96 35"
    else
	let g:Font_L1="-bitstream-bitstream vera sans mono-medium-r-normal-*-14-*-100-100-m-*-iso8859-1"
	let g:Font_L2="-bitstream-bitstream vera sans mono-medium-r-normal-*-16-*-100-100-m-*-iso8859-1"
	let g:Font_L3="-bitstream-bitstream vera sans mono-medium-r-normal-*-18-*-100-100-m-*-iso8859-1"
	let g:Font_U1="-bitstream-bitstream vera sans mono-medium-r-normal-*-14-*-100-100-m-*-iso10646-1"
	let g:Font_U2="-bitstream-bitstream vera sans mono-medium-r-normal-*-16-*-100-100-m-*-iso10646-1"
	let g:Font_U3="-bitstream-bitstream vera sans mono-medium-r-normal-*-18-*-100-100-m-*-iso10646-1"
	let g:Font_S1="132 60"
	let g:Font_S2="96 45"
	let g:Font_S3="96 42"
    endif

    function s:Set_Font (Size)
	if a:Size != 0
	    let g:Font_Size=a:Size
	end
	if &encoding == "utf-8"
	    let &guifont=g:Font_U{g:Font_Size}	      
	else
	    let &guifont=g:Font_L{g:Font_Size}
	endif	     
	if a:Size != 0
	    execute "winsize" g:Font_S{g:Font_Size}
	end
    endfunction Set_Font

    autocmd EncodingChanged * :call s:Set_Font (0)

    if &diff
	autocmd GUIEnter * :call s:Set_Font (1)
    else
	autocmd GUIEnter * :call s:Set_Font (2)
    endif

    if exists('g:mapleader')
	execute "nnoremap <unique> " . escape(g:mapleader . "1" , '\') .	  " :call <SID>Set_Font (1) <CR>"
	execute "nnoremap <unique> " . escape(g:mapleader . "2" , '\') .	  " :call <SID>Set_Font (2) <CR>"
	execute "nnoremap <unique> " . escape(g:mapleader . "3" , '\') .	  " :call <SID>Set_Font (3) <CR>"
	execute "inoremap <unique> " . escape(g:mapleader . "1" , '\') . " <C-O>:call <SID>Set_Font (1) <CR>"
	execute "inoremap <unique> " . escape(g:mapleader . "2" , '\') . " <C-O>:call <SID>Set_Font (2) <CR>"
	execute "inoremap <unique> " . escape(g:mapleader . "3" , '\') . " <C-O>:call <SID>Set_Font (3) <CR>"

	execute "48amenu Plugin.Font.Small<Tab>"  . escape(g:mapleader . "1" , '\') . " :call <SID>Set_Font (1)<CR>"
	execute "48amenu Plugin.Font.Medium<Tab>" . escape(g:mapleader . "2" , '\') . " :call <SID>Set_Font (2)<CR>"
	execute "48amenu Plugin.Font.Large<Tab>"  . escape(g:mapleader . "3" , '\') . " :call <SID>Set_Font (3)<CR>"
    endif

    finish
endif

"-------------------------------------------------------------------------------
" vim: textwidth=0 nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab
" vim: filetype=vim encoding=latin1 fileformat=unix
