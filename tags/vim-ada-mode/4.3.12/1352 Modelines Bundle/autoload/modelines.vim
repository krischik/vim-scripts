"-------------------------------------------------------------------------------
"  Description: Insert modelines
"   Maintainer: Martin Krischik
"      $Author$
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

setlocal cpoptions-=C

if exists("loaded_nerd_comments")
    "------------------------------------------------------------------------------
    "
    "	Insert Modelines with standart informationss
    "
    function modelines#Insert ()
	let l:Line = line (".")

	call append(
	    \ l:Line + 0,
	    \ "vim: set"				.
	    \ (&wrap ? " " : " no")	 . "wrap"	.
	    \ " tabstop="		 . &tabstop	.
	    \ " shiftwidth="		 . &shiftwidth	.
	    \ " softtabstop="		 . &softtabstop	.
	    \ (&expandtab ? " " : " no") . "expandtab"	.
	    \ " :")
	execute l:Line + 1 . " call NERDComment(0, 'norm')"
	call append(
	    \ l:Line + 1,
	    \ "vim: set"				.
	    \ " textwidth="		. &textwidth	.
	    \ " filetype="		. &filetype	.
	    \ " foldmethod="		. &foldmethod	.
	    \ (&spell ? " " : " no")	. "spell"	.
	    \ " :")
	execute l:Line + 2 . " call NERDComment(0, 'norm')"
    endfunction
else
    "------------------------------------------------------------------------------
    "
    "	Insert Modelines with standart informationss
    "
    function modelines#Insert ()
	let l:Line = line (".")

	call append (
	    \ l:Line + 0,
	    \ substitute (
		\ &commentstring			    ,
		\ "\%s"					    ,
		\ " vim: set"				    .
		\ (&wrap ? " " : " no")	     . "wrap"	    .
		\ " tabstop="		     . &tabstop	    .
		\ " shiftwidth="	     . &shiftwidth  .
		\ " softtabstop="	     . &softtabstop .
		\ (&expandtab ? " " : " no") . "expandtab"  .
		\ " :"					    ,
		\ ""))
	call append (
	    \ l:Line + 1,
	    \ substitute (
		\ &commentstring			    ,
		\ "\%s"					    ,
		\ " vim: set"				    .
		\ " textwidth="		    . &textwidth    .
		\ " filetype="		    . &filetype	    .
		\ " foldmethod="	    . &foldmethod   .
		\ (&spell ? " " : " no")    . "spell"	    .
		\ " :"					    ,
		\ ""))
    endfunction
endif

finish

"-------------------------------------------------------------------------------
" vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
" vim: set textwidth=0 filetype=vim foldmethod=marker nospell :
