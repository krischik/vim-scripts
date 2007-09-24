"------------------------------------------------------------------------------
"  Description: Vim Vim syntax file
"     Language: BTM (Batch to Memory - 4NT, TakeCommand Script)
"	   $Id$
"   Maintainer: Martin Krischik <krischik@users.sourceforge.net>
"               John Leo Spetz <jls11@po.cwru.edu>
"      $Author$
"	 $Date$
"      Version: 4.5
"    $Revision$
"     $HeadURL$
"      History: 08.07.2007 MK.
"    Help Page: ft-ada-plugin
"------------------------------------------------------------------------------
" Vim syntax file

"//Issues to resolve:
"//- Boolean operators surrounded by period are recognized but the
"//  periods are not highlighted.  The only way to do that would
"//  be separate synmatches for each possibility otherwise a more
"//  general \.\i\+\. will highlight anything delimited by dots.
"//- After unary operators like "defined" can assume token type.
"//  Should there be more of these?

if exists("b:current_syntax") || version < 700
    finish
endif

let b:current_syntax = "btm"

syntax case ignore

syntax keyword btmStatement	call off
syntax keyword btmConditional	if iff endiff then else elseiff not errorlevel
syntax keyword btmConditional	gt lt eq ne ge le
syntax match btmConditional transparent    "\.\i\+\." contains=btmDotBoolOp
syntax keyword btmDotBoolOp contained      and or xor
syntax match btmConditional	"=="
syntax match btmConditional	"!="
syntax keyword btmConditional	defined errorlevel exist isalias
syntax keyword btmConditional	isdir direxist isinternal islabel
syntax keyword btmRepeat		for in do enddo

syntax keyword btmTodo contained	TODO

" String
syntax cluster btmVars contains=btmVariable,btmArgument,btmBIFMatch
syntax region  btmString	start=+"+  end=+"+ contains=@btmVars
syntax match btmNumber     "\<\d\+\>"

"syntax match  btmIdentifier	"\<\h\w*\>"

" If you don't like tabs
"syntax match btmShowTab "\t"
"syntax match btmShowTabc "\t"
"syntax match  btmComment		"^\ *rem.*$" contains=btmTodo,btmShowTabc

" Some people use this as a comment line
" In fact this is a Label
"syntax match btmComment		"^\ *:\ \+.*$" contains=btmTodo

syntax match btmComment		"^\ *rem.*$" contains=btmTodo
syntax match btmComment		"^\ *::.*$" contains=btmTodo

syntax match btmLabelMark		"^\ *:[0-9a-zA-Z_\-]\+\>"
syntax match btmLabelMark		"goto [0-9a-zA-Z_\-]\+\>"lc=5
syntax match btmLabelMark		"gosub [0-9a-zA-Z_\-]\+\>"lc=6

" syntax match btmCmdDivider ">[>&][>&]\="
syntax match btmCmdDivider ">[>&]*"
syntax match btmCmdDivider ">>&>"
syntax match btmCmdDivider "|&\="
syntax match btmCmdDivider "%+"
syntax match btmCmdDivider "\^"

syntax region btmEcho start="echo" skip="echo" matchgroup=btmCmdDivider end="%+" end="$" end="|&\=" end="\^" end=">[>&]*" contains=@btmEchos oneline
syntax cluster btmEchos contains=@btmVars,btmEchoCommand,btmEchoParam
syntax keyword btmEchoCommand contained	echo echoerr echos echoserr
syntax keyword btmEchoParam contained	on off

" this is also a valid Label. I don't use it.
"syntax match btmLabelMark		"^\ *:\ \+[0-9a-zA-Z_\-]\+\>"

" //Environment variable can be expanded using notation %var in 4DOS
syntax match btmVariable		"%[0-9a-z_\-]\+" contains=@btmSpecialVars
" //Environment variable can be expanded using notation %var%
syntax match btmVariable		"%[0-9a-z_\-]*%" contains=@btmSpecialVars
" //The following are special variable in 4DOS
syntax match btmVariable		"%[=#]" contains=@btmSpecialVars
syntax match btmVariable		"%??\=" contains=@btmSpecialVars
" //Environment variable can be expanded using notation %[var] in 4DOS
syntax match btmVariable		"%\[[0-9a-z_\-]*\]"
" //After some keywords next word should be an environment variable
syntax match btmVariable		"defined\s\i\+"lc=8
syntax match btmVariable		"set\s\i\+"lc=4
" //Parameters to batchfiles take the format %<digit>
syntax match btmArgument		"%\d\>"
" //4DOS allows format %<digit>& meaning batchfile parameters digit and up
syntax match btmArgument		"%\d\>&"
" //Variable used by FOR loops sometimes use %%<letter> in batchfiles
syntax match btmArgument		"%%\a\>"

" //Show 4DOS built-in functions specially
syntax match btmBIFMatch "%@\w\+\["he=e-1 contains=btmBuiltInFunc

syntax cluster btmSpecialVars contains=btmBuiltInVar,btmSpecialVar

" //Show specialized variables specially
" syntax match btmSpecialVar contained	"+"
syntax match btmSpecialVar contained	"="
syntax match btmSpecialVar contained	"#"
syntax match btmSpecialVar contained	"??\="

for b:Item in g:wlsadmin#Keywords
   if b:Item['kind'] == "f"
      execute "syntax keyword btmBuiltInFunc contained . b:Item['word']
   endif
   if b:Item['kind'] == "k"
      execute "syntax keyword btmCommand "      . b:Item['word']
   endif
   if b:Item['kind'] == "s"
      execute "syntax keyword btmSpecialVar "   . b:Item['word']
   endif
   if b:Item['kind'] == "v"
      execute "syntax keyword btmBuiltInVar "   . b:Item['word']
   endif
endfor

" //Commands in 4DOS and/or DOS
syntax match btmCommand	"\s?"
syntax match btmCommand	"^?"

highlight def link btmLabel		Special
highlight def link btmLabelMark		Special
highlight def link btmCmdDivider	Special
highlight def link btmConditional	btmStatement
highlight def link btmDotBoolOp		btmStatement
highlight def link btmRepeat		btmStatement
highlight def link btmEchoCommand	btmStatement
highlight def link btmEchoParam		btmStatement
highlight def link btmStatement		Statement
highlight def link btmTodo		Todo
highlight def link btmString		String
highlight def link btmNumber		Number
highlight def link btmComment		Comment
highlight def link btmArgument		Identifier
highlight def link btmVariable		Identifier
highlight def link btmEcho		String
highlight def link btmBIFMatch		btmStatement
highlight def link btmBuiltInFunc	btmStatement
highlight def link btmBuiltInVar	btmStatement
highlight def link btmSpecialVar	btmStatement
highlight def link btmCommand		btmStatement

"optional highlighting
"highlight default link btmShowTab	Error
"highlight default link btmShowTabc	Error
"highlight default link btmIdentifier   Identifier

endif

"vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 expandtab :
"vim: set textwidth=0 filetype=vim foldmethod=marker nospell :
