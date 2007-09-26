"------------------------------------------------------------------------------
"  Description: Perform btm specific completion & tagging.
"     Language: BTM (Batch to Memory - 4NT, TakeCommand Script)
"	   $Id$
"    Copyright: Copyright (C) 2007 Martin Krischik
"   Maintainer: Martin Krischik
"               John Leo Spetz <jls11@po.cwru.edu>
"      $Author$
"	 $Date$
"      Version: 1.0
"    $Revision$
"     $HeadURL$
"      History: 22.11.2007 MK A new Btm Filetype Bundle
"    Help Page: ft-btm-functions
"------------------------------------------------------------------------------

if version < 700
   finish
endif

let g:btm#Keywords	   = []

" Section: g:btm#Keywords {{{1
"
" Section: add 4NT / TakeCommand command {{{2
"
for Item in ["ACTIVATE", "ALIAS", "ASSOC", "ATTRIB", "BATCOMP", "BDEBUGGER", "BEEP", "BREAK", "BREAKPOINT", "CALL", "CANCEL", "CASE", "CD", "CDD", "CHDIR", "CLS", "COLOR", "COPY", "DATE", "DDEEXEC", "DEBUGSTRING", "DEFAULT", "DEL", "DELAY", "DESCRIBE", "DETACH", "DIR", "DIRHISTORY", "DIRS", "DRAWBOX", "DRAWHLINE", "DRAWVLINE", "EJECTMEDIA", "ENDLOCAL", "ERASE", "ESET", "EVENTLOG", "EXCEPT", "EXIT", "FFIND", "FOR", "FREE", "FTYPE", "FUNCTION", "GLOBAL", "GOSUB", "GOTO", "HEAD", "HELP", "HISTORY", "IFTP", "INKEY", "INPUT", "JABBER", "KEYBD", "KEYS", "KEYSTACK", "LIST", "LOADBTM", "LOG", "MD", "MEMORY", "MKDIR", "MKLINK", "MKLNK", "MOVE", "MSGBOX", "ON", "OPTION", "OSD", "PATH", "PAUSE", "PDIR", "PLAYAVI", "PLAYSOUND", "PLUGIN", "POPD", "POSTMSG", "PRINT", "PRIORITY", "PROMPT", "PUSHD", "QUERYBOX", "QUIT", "RD", "REBOOT", "RECYCLE", "REM", "REN", "RENAME", "RETURN", "REXEC", "RMDIR", "RSHELL", "SCREEN", "SCRIPT", "SCRPUT", "SELECT", "SENDMAIL", "SET", "SETDOS", "SETLOCAL", "SHIFT", "SHORTCUT", "SHRALIAS", "SMPP", "SNMP", "SNPP", "START", "SYNC", "TAIL", "TASKEND", "TASKLIST", "TCTOOLBAR", "TEE", "TEXT", "TIME", "TIMER", "TITLE", "TOUCH", "TRANSIENT", "TREE", "TRUENAME", "TYPE", "UNALIAS", "UNFUNCTION", "UNSET", "VER", "VERIFY", "VOL", "VSCRPUT", "WHICH", "WINDOW", "WMIQUERY", "Y"]
    let g:btm#Keywords += [{
	    \ 'word':  Item,
	    \ 'menu':  'command',
	    \ 'info':  '4NT /TakeCommand command.',
	    \ 'kind':  'k',
	    \ 'icase': 0}]
endfor

" Section: add 4NT / TakeCommand  echo command {{{2
"
for Item in ["ECHO", "ECHOERR", "ECHOS", "ECHOSERR"]
    let g:btm#Keywords += [{
	    \ 'word':  Item,
	    \ 'menu':  'command',
	    \ 'info':  '4NT /TakeCommand echo command.',
	    \ 'kind':  'e',
	    \ 'icase': 0}]
endfor

" Section: add 4NT / TakeCommand conditional command {{{2
"
for Item in ["IF", "IFF", "ENDIFF", "THEN", "ELSE", "ELSEIFF", "SWITCH", "CASE", "ENDSWITCH"]
    let g:btm#Keywords += [{
	    \ 'word':  Item,
	    \ 'menu':  'conditional',
	    \ 'info':  '4NT /TakeCommand conditional command.',
	    \ 'kind':  'c',
	    \ 'icase': 0}]
endfor

" Section: add 4NT / TakeCommand repeat command {{{2
"
for Item in ["FOR", "IN", "DO", "ENDDO"]
    let g:btm#Keywords += [{
	    \ 'word':  Item,
	    \ 'menu':  'repeat',
	    \ 'info':  '4NT /TakeCommand repeat command.',
	    \ 'kind':  'r',
	    \ 'icase': 0}]
endfor

" Section: add 4NT / TakeCommand operators {{{2
"
for Item in ["NOT", "ERRORLEVEL", "GT", "LT", "EQ", "NE", "GE", "LE", "DEFINED", "EXIST", "ISALIAS", "ISDIR", "DIREXIST", "ISINTERNAL", "ISLABEL", "AND", "OR", "XOR"]
    let g:btm#Keywords += [{
	    \ 'word':  Item,
	    \ 'menu':  'operator',
	    \ 'info':  '4NT /TakeCommand operators.',
	    \ 'kind':  'o',
	    \ 'icase': 0}]
endfor

" Section: add 4NT / TakeCommand System Variables {{{2
"
for Item in ["CDPATH", "CMDLINE", "COLORDIR", "COMSPEC", "FILECOMPLETION", "HISTORYEXCLUSION", "PATH", "PATHEXT", "PROMPT", "RECYCLEEXCLUDE", "TEMP", "TITLEPROMPT", "TMP", "TREEEXCLUDE", "VARIABLEEXCLUDE"]
    let g:btm#Keywords += [{
	    \ 'word':  Item,
	    \ 'menu':  'system variable',
	    \ 'info':  '4NT /TakeCommand system variable.',
	    \ 'kind':  's',
	    \ 'icase': 0}]
endfor

" Section: add 4NT / TakeCommand internal variables {{{2
"
for Item in ["_4ver", "_acstatus", "_afswcell", "_alt", "_ansi", "_batch", "_batchline", "_batchname", "_batchtype", "_battery", "_batterylife", "_batterypercent", "_bdebugger", "_bg", "_boot", "_build", "_capslock", "_cdroms", "_childpid", "_ci", "_cmdline", "_cmdproc", "_cmdspec", "_co", "_codepage", "_column", "_columns", "_country", "_cpu", "_cpuusage", "_ctrl", "_cwd", "_cwds", "_cwp", "_cwps", "_datetime", "_day", "_detachpid", "_disk", "_dname", "_dos", "_dosver", "_dow", "_dowf", "_dowi", "_doy", "_drives", "_dst", "_dvds", "_echo", "_editmode", "errorlevel", "_execstr", "_exit", "_expansion", "_fg", "_ftperror", "_hdrives", "_hlogfile", "_host", "_hour", "_hwprofile", "_idleticks", "_idow", "_idowf", "_iftp", "_iftps", "_imonth", "_imonthf", "_ininame", "_ip", "_isodate", "_kbhit", "_lalt", "_lastdisk", "_lctrl", "_logfile", "_lshift", "_minute", "_month", "_monthf", "_numlock", "_openafs", "_osbuild", "_pid", "_pipe", "_ppid", "_ralt", "_rctrl", "_ready", "_registered", "_row", "_rows", "_rshift", "_scrolllock", "_second", "_selected", "_shell", "_shells", "_shift", "_shralias", "_startpath", "_startpid", "_stdin", "_stdout", "_stderr", "_stzn", "_stzo", "_syserr", "_time", "_transient", "_tzn", "_tzo", "_unicode", "_virtualpc", "_vmware", "_windir", "_winfgwindow", "_winname", "_winsysdir", "_winticks", "_wintitle", "_winuser", "_winver", "_wow64", "_xpixels", "_year", "_ypixels"]
    let g:btm#Keywords += [{
	    \ 'word':  Item,
	    \ 'menu':  'internal variable',
	    \ 'info':  '4NT /TakeCommand internal variable',
	    \ 'kind':  'v',
	    \ 'icase': 1}]
endfor

" Section: add 4NT / TakeCommand internal function {{{2
"
for Item in ["@ABS", "@AFSCELL", "@AFSMOUNT", "@AFSPATH", "@AFSSYMLINK", "@AFSVOLID", "@AFSVOLNAME", "@AGEDATE", "@ALIAS", "@ALTNAME", "@ASCII", "@ASSOC", "@ATTRIB", "@AVERAGE", "@CAPI", "@CAPS", "@CDROM", "@CEILING", "@CHAR", "@CLIP", "@CLIPW", "@COLOR", "@COMMA", "@COMPARE", "@CONSOLE", "@CONVERT", "@COUNT", "@CRC32", "@CWD", "@CWDS", "@DATE", "@DAY", "@DEC", "@DECIMAL", "@DESCRIPT", "@DEVICE", "@DIGITS", "@DIRSTACK", "@DISKFREE", "@DISKTOTAL", "@DISKUSED", "@DOMAIN", "@DOW", "@DOWF", "@DOWI", "@DOY", "@DRIVETYPE", "@DRIVETYPEEX", "@ENUMSERVERS", "@ENUMSHARES", "@ERRTEXT", "@EVAL", "@EXEC", "@EXECSTR", "@EXETYPE", "@EXPAND", "@EXT", "@FIELD", "@FIELDS", "@FILEAGE", "@FILECLOSE", "@FILEDATE", "@FILENAME", "@FILEOPEN", "@FILEREAD", "@FILES", "@FILESEEK", "@FILESEEKL", "@FILESIZE", "@FILETIME", "@FILEWRITE", "@FILEWRITEB", "@FINDCLOSE", "@FINDFIRST", "@FINDNEXT", "@FLOOR", "@FORMAT", "@FORMATN", "@FSTYPE", "@FTYPE", "@FULL", "@FUNCTION", "@GETDIR", "@GETFILE", "@GETFOLDER", "@GROUP", "@HISTORY", "@IDOW", "@IDOWF", "@IF", "@INC", "@INDEX", "@INIREAD", "@INIWRITE", "@INSERT", "@INODE", "@INSTR", "@INT", "@IPADDRESS", "@IPNAME", "@ISALNUM", "@ISALPHA", "@ISASCII", "@ISCNTRL", "@ISDIGIT", "@ISPRINT", "@ISPUNCT", "@ISSPACE", "@ISXDIGIT", "@JUNCTION", "@LABEL", "@LCS", "@LEFT", "@LEN", "@LFN", "@LINE", "@LINES", "@LINKS", "@LOWER", "@LTRIM", "@MAKEAGE", "@MAKEDATE", "@MAKETIME", "@MAX", "@MD5", "@MIN", "@MONTH", "@NAME", "@NUMERIC", "@OPTION", "@OWNER", "@PATH", "@PERL", "@PING", "@QUOTE", "@RANDOM", "@READSCR", "@READY", "@REGCREATE", "@REGDELKEY", "@REGEX", "@REGEXINDEX", "@REGEXIST", "@REGEXSUB", "@REGQUERY", "@REGSET", "@REGSETENV", "@REMOTE", "@REMOVABLE", "@REPEAT", "@REPLACE", "@REVERSE", "@REXX", "@RIGHT", "@RTRIM", "@RUBY", "@SCRIPT", "@SEARCH", "@SELECT", "@SERIAL", "@SFN", "@SHA1", "@SHA256", "@SHA384", "@SHA512", "@SIMILAR", "@SNAPSHOT", "@STRIP", "@SUBST", "@SUBSTR", "@SUMMARY", "@SYMLINK", "@TIME", "@TIMER", "@TRIM", "@TRUENAME", "@TRUNCATE", "@UNC", "@UNICODE", "@UNIQUE", "@UNQUOTE", "@UNQUOTES", "@UPPER", "@VERINFO", "@WATTRIB", "@WILD", "@WINAPI", "@WINCLASS", "@WINEXENAME", "@WININFO", "@WINMEMORY", "@WINMETRICS", "@WINPOS", "@WINSTATE", "@WINSYSTEM", "@WMI", "@WORD", "@WORDS", "@WORKGROUP", "@XMLPATH", "@YEAR"]
    let g:btm#Keywords += [{
	    \ 'word':  Item,
	    \ 'menu':  'internal function',
	    \ 'info':  '4NT /TakeCommand internal function.',
	    \ 'kind':  'f',
	    \ 'icase': 0}]
endfor

" Section: add  4NT / TakeCommand configuration option {{{2
"
for Item in ["4StartPath", "AddFile", "AliasExpand", "AmPm", "ANSI", "AppendToDir", "AutoCancel", "AutoRun", "Backspace", "BatchEcho", "BeepFreq", "BeepLength", "BeginLine", "BGColorRGB", "CDDWinColors", "CDDWinHeight", "CDDWinLeft", "CDDWinTop", "CDDWinWidth", "ClearKeyMap", "ColorDir", "CMDExtensions", "CommandEscape", "CommandSep", "CompleteHidden", "CompletePaths", "ConsoleColumns", "ConsoleRows", "Copy", "CopyPrompt", "CUA", "CursorIns", "CursorOver", "Debug", "DebuggerTransparency", "DecimalChar", "Del", "DelayedExpansion", "DelGlobalQuery", "DelHistory", "DelToBeginning", "DelToEnd", "DelWordLeft", "DelWordRight", "DescriptionMax", "DescriptionName", "Descriptions", "DirHistory", "DirWinOpen", "Down", "DuplicateBugs", "EditMode", "Editor", "EndHistory", "EndLine", "EraseLine", "EscapeChar", "EvalMax", "EvalMin", "ExecLine", "ExecWait", "ExitFile", "FGColorRGB", "FileCompletion", "FirewallHost", "FirewallPassword", "FirewallType", "FirewallUser", "FTPCFG", "FTPTimeout", "FuzzyCD", "Help", "HelpWord", "HideConsole", "HistCopy", "HistDups", "HistFile", "HistLogName", "HistLogOn", "HistMin", "HistMove", "History", "HistWinOpen", "HistWrap", "HTTPTimeout", "IBeamCursor", "InactiveTransparency", "Include", "INIQuery", "InputColors", "Ins", "JabberPassword", "JabberServer", "JabberUser", "LastHistory", "Left", "LFNToggle", "LineToEnd", "ListBack", "ListboxBarColors", "ListContinue", "ListColors", "ListExit", "ListFind", "ListFindRegex", "ListFindRegexReverse", "ListFindReverse", "ListHex", "ListHighBit", "ListInfo", "ListInverseColors", "ListNext", "ListOpen", "ListPrevious", "ListPrint", "ListRowStart", "ListStatBarColors", "ListUnicode", "ListWrap", "LocalAliases", "LocalDirHistory", "LocalFunctions", "LocalHistory", "LogAll", "LogErrors", "LogName", "LogOn", "MailAddress", "MailPassword", "MailPort", "MailServer", "MailUser", "NextFile", "NextHistory", "NextINIFile", "NoClobber", "NormalEditKey", "NormalKey", "NormalListKey", "NormalPopupKey", "NTFSDescriptions", "ParameterChar", "PassiveFTP", "Paste", "PathExt", "PauseOnError", "Perl", "PopFile", "PopupWinBegin", "PopupWinColors", "PopupWinDel", "PopupWinEdit", "PopupWinEnd", "PopupWinExec", "PopupWinHeight", "PopupWinLeft", "PopupWinTop", "PopupWinWidth", "PrevFile", "PrevHistory", "Proxy", "ProxyPassword", "ProxyPort", "ProxyUser", "RecycleBin", "RegularExpressions", "RepeatFile", "REXX", "Right", "RLocalHost", "RLocalUser", "RLocalPort", "Ruby", "SaveDirCase", "SaveHistory", "ScreenBufSize", "ScreenColumns", "ScreenRows", "ScrollDown", "ScrollPgDn", "ScrollPgUp", "ScrollUp", "SelectColors", "SelectStatBarColors", "ServerCompletion", "SettingChange", "SHChangeNotify", "SSLPort", "SSLProvider", "SSLStartMode", "StartupFile", "StatusBarOn", "StatusBarText", "StdColors", "SwapScrollKeys", "SwitchChar", "TabStops", "TCStartPath", "TFTPTimeout", "ThousandsChar", "TimeServer", "ToolBarOn", "ToolBarText", "Transparency", "TreePath", "UnicodeOutput", "UnixPaths", "Up", "UpdateTitle", "VariableExpand", "Win32SFNSearch", "WindowHeight", "WindowState", "WindowWidth", "WindowX", "WindowY", "WordLeft", "WordRight", "Wow64FsRedirection", "ZoneID"]
    let g:btm#Keywords += [{
	    \ 'word':  Item,
	    \ 'menu':  'config',
	    \ 'info':  '4NT / TakeCommand configuration option.',
	    \ 'kind':  't',
	    \ 'icase': 0}]
endfor

" Section: Insert Completions {{{1
"
" Section: btm#User_Complete(findstart, base) {{{2
"
" This function is used for the 'complete' option.
"
function btm#User_Complete(findstart, base)
   if a:findstart == 1
      "
      " locate the start of the word
      "
      let line = getline ('.')
      let start = col ('.') - 1
      while start > 0 && line[start - 1] =~ '\i\|'''
	 let start -= 1
      endwhile
      return start
   else
      "
      " look up matches
      "
      let l:Pattern = '^' . a:base . '.*$'
      "
      " add keywords
      "
      for Tag_Item in g:btm#Keywords
	 if l:Tag_Item['word'] =~? l:Pattern
	    if complete_add (l:Tag_Item) == 0
	       return []
	    endif
	    if complete_check ()
	       return []
	    endif
	 endif
      endfor
      return []
   endif
endfunction btm#User_Complete

" }}}1

lockvar! g:btm#Keywords

finish " 1}}}

"------------------------------------------------------------------------------
"   Copyright (C) 2006	Martin Krischik
"
"   Vim is Charityware - see ":help license" or uganda.txt for licence details.
"------------------------------------------------------------------------------
" vim: textwidth=0 wrap tabstop=8 shiftwidth=3 softtabstop=3 noexpandtab
" vim: foldmethod=marker
