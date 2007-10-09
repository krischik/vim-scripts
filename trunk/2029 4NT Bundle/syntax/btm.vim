"------------------------------------------------------------------------------
"  Description: Vim syntax file for Btm
"     Language: BTM (Batch to Memory - 4NT, TakeCommand Script)
"          $Id$
"    Copyright: Copyright (C) 2007 Martin Krischik
"   Maintainer: Martin Krischik <krischik@users.sourceforge.net>
"               John Leo Spetz <jls11@po.cwru.edu>
"      $Author$
"        $Date$
"      Version: 1.1
"    $Revision$
"     $HeadURL$
"      History: 22.11.2007 MK A new Btm Filetype Bundle
"    Help Page: ft-btm-plugin
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

syntax match    btmOperator     transparent    "\.\i\+\." contains=btmDotBoolOp
syntax keyword  btmDotBoolOp    contained      and or xor
syntax match    btmOperator     "=="
syntax match    btmOperator     "!="

syntax keyword btmTodo contained        TODO

" String
syntax cluster  btmVars         contains=btmVariable,btmArgument,btmBIFMatch
syntax region   btmString       start=+"+  end=+"+ contains=@btmVars
syntax match    btmNumber       "\<\d\+\>"

if exists ('g:btm_highlight_identifier')
    syntax match  btmIdentifier "\<\h\w*\>"
endif

if exists ('g:btm_highlight_tabs')
    syntax match btmShowTab     "\t"
    syntax match btmShowTabc    "\t"
    syntax match btmComment     "^\ *rem.*$" contains=btmTodo,btmShowTabc
    syntax match btmComment     "^\ *::.*$" contains=btmTodo,btmShowTabc
else
    syntax match btmComment     "^\ *rem.*$" contains=btmTodo
    syntax match btmComment     "^\ *::.*$" contains=btmTodo
endif

if exists ('g:btm_highlight_unusual_comments')
    " Some people use this as a comment line. In fact this is a Label!
    syntax match btmComment     "^\ *:\ \+.*$" contains=btmTodo
endif

syntax match btmPreProc          '^\%1l::!.*$'

syntax match btmLabelMark       "^\ *:[0-9a-zA-Z_\-]\+\>"
syntax match btmLabelMark       "goto [0-9a-zA-Z_\-]\+\>"lc=5
syntax match btmLabelMark       "gosub [0-9a-zA-Z_\-]\+\>"lc=6

" syntax match btmCmdDivider    ">[>&][>&]\="
syntax match btmCmdDivider      ">[>&]*"
syntax match btmCmdDivider      ">>&>"
syntax match btmCmdDivider      "|&\="
syntax match btmCmdDivider      "%+"
syntax match btmCmdDivider      "\^"

syntax region   btmEcho         start="echo" skip="echo" matchgroup=btmCmdDivider end="%+" end="$" end="|&\=" end="\^$" end=">[>&]*" contains=@btmEchos oneline
syntax cluster  btmEchos        contains=@btmVars,btmEchoCommand,btmEchoParam

for b:Item in g:btm#Keywords
    if b:Item['kind'] == "e"
        execute "syntax keyword btmEchoCommand  contained" . b:Item['word']
    endif
endfor

syntax keyword  btmEchoParam    contained       on off

" this is also a valid Label. I don't use it.
"syntax match btmLabelMark      "^\ *:\ \+[0-9a-zA-Z_\-]\+\>"

" //Environment variable can be expanded using notation %var in 4DOS
syntax match btmVariable                "%[0-9a-z_\-]\+" contains=@btmSpecialVars
" //Environment variable can be expanded using notation %var%
syntax match btmVariable                "%[0-9a-z_\-]*%" contains=@btmSpecialVars
" //The following are special variable in 4DOS
syntax match btmVariable                "%[=#]" contains=@btmSpecialVars
syntax match btmVariable                "%??\=" contains=@btmSpecialVars
" //Environment variable can be expanded using notation %[var] in 4DOS
syntax match btmVariable                "%\[[0-9a-z_\-]*\]" contains=@rainbow_parenthsis
" //After some keywords next word should be an environment variable
syntax match btmVariable                "defined\s\i\+"lc=8
syntax match btmVariable                "set\s\{}\i\+"lc=4
" //Parameters to batchfiles take the format %<digit>
syntax match btmArgument                "%\d\>"
" //4DOS allows format %<digit>& meaning batchfile parameters digit and up
syntax match btmArgument                "%\d\>&"
" //Variable used by FOR loops sometimes use %%<letter> in batchfiles
syntax match btmArgument                "%%\a\>"

" //Show 4DOS built-in functions specially
syntax match btmBIFMatch "%@\w\+\["he=e-1 contains=btmBuiltInFunc,@rainbow_parenthsis

for b:Item in g:btm#Keywords
   if b:Item['kind'] == "f"
      execute "syntax keyword btmBuiltInFunc contained " . strpart(b:Item['word'],1) 
    endif
endfor

syntax cluster btmSpecialVars contains=btmBuiltInVar,btmSpecialVar,@rainbow_parenthsis

" //Show specialized variables specially
" syntax match btmSpecialVar contained  "+"
syntax match btmSpecialVar contained    "="
syntax match btmSpecialVar contained    "#"
syntax match btmSpecialVar contained    "??\="

for b:Item in g:btm#Keywords
    if b:Item['kind'] == "c"
        execute "syntax keyword btmConditional "        . b:Item['word']
    elseif  b:Item['kind'] == "r"
        execute "syntax keyword btmRepeat "             . b:Item['word']
    elseif b:Item['kind'] == "o"
        execute "syntax keyword btmOperator "           . b:Item['word']
    elseif b:Item['kind'] == "s"
        execute "syntax keyword btmSpecialVar "         . b:Item['word']
    elseif b:Item['kind'] == "v"
        execute "syntax keyword btmBuiltInVar "         . strpart(b:Item['word'],1)
    elseif b:Item['kind'] == "k"
        execute "syntax keyword btmCommand "            . b:Item['word']
    endif
endfor

" //Commands in 4DOS and/or DOS
syntax match btmCommand "\s?"
syntax match btmCommand "^?"

highlight def link btmOperator          Operator
highlight def link btmLabel             Label
highlight def link btmLabelMark         Label
highlight def link btmCmdDivider        Special
highlight def link btmConditional       Conditional
highlight def link btmDotBoolOp         Boolean
highlight def link btmRepeat            Repeat
highlight def link btmEchoCommand       Keyword
highlight def link btmEchoParam         Keyword
highlight def link btmStatement         Statement
highlight def link btmTodo              Todo
highlight def link btmString            String
highlight def link btmNumber            Number
highlight def link btmComment           Comment
highlight def link btmArgument          Structure
highlight def link btmVariable          Identifier
highlight def link btmEcho              String
highlight def link btmBIFMatch          Type
highlight def link btmBuiltInFunc       Function
highlight def link btmBuiltInVar        Constant
highlight def link btmSpecialVar        Special
highlight def link btmCommand           Keyword
highlight def link btmPreProc           PreProc

" Section: rainbow color {{{1
"
if exists("g:btm_rainbow_color") && g:btm_rainbow_color
    call rainbow_parenthsis#LoadSquare ()
    call rainbow_parenthsis#LoadRound ()
    call rainbow_parenthsis#Activate ()
endif

" Section: tabs {{{1
"
if exists ('g:btm_highlight_tabs') && g:btm_highlight_tabs
    highlight default link btmShowTab   Error
    highlight default link btmShowTabc  Error
endif

" Section: itentifiers {{{1
"
if exists ('g:btm_highlight_identifier') && g:btm_highlight_identifier
    highlight default link btmIdentifier Identifier
endif

" }}}1

finish

"vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
"vim: set textwidth=0 filetype=vim foldmethod=marker nospell :
