"------------------------------------------------------------------------------
"  Description: Perform btm specific completion & tagging.
"     Language: BTM (Batch to Memory - 4NT, TakeCommand Script)
"	   $Id$
"    Copyright: Copyright (C) 2007 Martin Krischik
"   Maintainer: Martin Krischik
"               John Leo Spetz <jls11@po.cwru.edu>
"      $Author$
"	 $Date$
"      Version: 1.1
"    $Revision$
"     $HeadURL$
"      History: 22.11.2007 MK A new Btm Filetype Bundle
"    Help Page: ft-btm-functions
"------------------------------------------------------------------------------

if version < 700
   finish
endif

" Section: Setup keywords {{{1
"
let g:btm#Keywords = []

" Prepare window position restoring command:
if (strlen(@%))
    let s:Go_Back= 'buffer! ' . bufnr("%")
else
    let s:Go_Back = 'enew!'
endif

setlocal nomodeline
enew!
execute "read " . expand('<sfile>:p')
let s:Buffer = bufnr("%")
setlocal modeline noswapfile modifiable

norm zR

norm gg

let s:Start_Line = search ('\C^=\{3,}\s\+START_KEYWORDS') + 1
let s:End_Line   = search ('\C^=\{3,}\s\+END_KEYWORDS') - 1
let s:Lines      = getline (s:Start_Line, s:End_Line)

for s:I in s:Lines
   let s:Keyword = matchlist(s:I, '\(\S\)\s\{}\(\S\{}\)\s\{}\(\S\{}\)\s\{}\(.*\)')
   let g:btm#Keywords += [{
      \ 'word':  s:Keyword[3],
      \ 'menu':  s:Keyword[2],
      \ 'info':  s:Keyword[4],
      \ 'kind':  s:Keyword[1],
      \ 'icase': 1}]
endfor

execute s:Go_Back
execute 'bwipeout! ' . s:Buffer

unlet s:Go_Back
unlet s:Buffer
unlet s:Start_Line
unlet s:End_Line
unlet s:Lines

unlet s:Keyword
unlet s:I


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

=== START_KEYWORDS
c	command	CASE	Batch file switch / case
c	command	ELSE	Conditional command execution
c	command	ELSEIFF	Conditional command execution
c	command	ENDIFF	Conditional command execution
c	command	ENDSWITCH	Batch file switch / case
c	command	IF	Conditional command execution
c	command	IFF	Conditional command execution
c	command	SWITCH	Batch file switch / case
c	command	SWITCH	Batch file switch / case
c	command	THEN	Conditional command execution
e	command	ECHO	Echo a message
e	command	ECHOERR	Echo a message to stderr
e	command	ECHOS	Echo a message with no CR/LF
e	command	ECHOSERR	Echo with no CR/LF to stderr
f	internal_function	@ABS	Absolute value of number
f	internal_function	@AFSCELL	OpenAFS cell name
f	internal_function	@AFSMOUNT	OpenAFS mount point
f	internal_function	@AFSPATH	Path in OpenAFS: 1, otherwise 0
f	internal_function	@AFSSYMLINK	OpenAFS symbolic link
f	internal_function	@AFSVOLID	OpenAFS volume ID
f	internal_function	@AFSVOLNAME	OpenAFS volume name
f	internal_function	@AGEDATE	Converts an age into date and time
f	internal_function	@ALIAS	Value of an alias
f	internal_function	@ALTNAME	Short name for the file.
f	internal_function	@ASCII	Set of ASCII-s for characters in string
f	internal_function	@ASSOC	File association
f	internal_function	@ATTRIB	Test or return file attributes
f	internal_function	@AVERAGE	Average of a list of numbers
f	internal_function	@CAPI	Call a _cdecl function in a DLL
f	internal_function	@CAPS	Capitalize first character of each word
f	internal_function	@CDROM	CD-ROM drive: 1, otherwise 0
f	internal_function	@CEILING	Smallest integer not less than a number
f	internal_function	@CHAR	Character string, given a set of ASCII-s
f	internal_function	@CLIP	Specified line from clipboard
f	internal_function	@CLIPW	Write string to the clipboard
f	internal_function	@COLOR	RGB value of a color
f	internal_function	@COMMA	Insert commas into a number (thousands separators)
f	internal_function	@COMPARE	Two files are identical: 1, otherwise 0
f	internal_function	@CONSOLE	Identify console sessions
f	internal_function	@CONVERT	Convert value from input base to output base
f	internal_function	@COUNT	Number of times a character appears in a string
f	internal_function	@CRC32	File CRC
f	internal_function	@CWD	Current Working Directory of specified drive
f	internal_function	@CWDS	Current Working Directory of specified drive, with trailing backslash
f	internal_function	@DATE	Convert date to number of days
f	internal_function	@DAY	Day of month for date
f	internal_function	@DEC	Decrement a numeric value by 1
f	internal_function	@DECIMAL	Decimal portion of a number
f	internal_function	@DESCRIPT	File description
f	internal_function	@DEVICE	Character device: 1, otherwise 0
f	internal_function	@DIGITS	String is all digits: 1, otherwise 0
f	internal_function	@DIRSTACK	Directory stack entry
f	internal_function	@DISKFREE	Free disk space
f	internal_function	@DISKTOTAL	Total disk space
f	internal_function	@DISKUSED	Used disk space
f	internal_function	@DOMAIN	Domain name of a computer
f	internal_function	@DOW	Short name of day of week for date
f	internal_function	@DOWF	Full name of day of week for date
f	internal_function	@DOWI	Day of week number for date
f	internal_function	@DOY	Day of year for date
f	internal_function	@DRIVETYPE	Type of a drive
f	internal_function	@DRIVETYPEEX	Type of a drive
f	internal_function	@ENUMSERVERS	Identify server names on a network
f	internal_function	@ENUMSHARES	Identify sharenames on a server
f	internal_function	@ERRTEXT	Windows error description
f	internal_function	@EVAL	Arithmetic calculations
f	internal_function	@EXEC	Execute a command and return its exit code
f	internal_function	@EXECSTR	Execute a command and return the first output line
f	internal_function	@EXETYPE	Application type
f	internal_function	@EXPAND	All names that match filename
f	internal_function	@EXT	File extension
f	internal_function	@FIELD	Extract a field from a string
f	internal_function	@FIELDS	Count fields in a string
f	internal_function	@FILEAGE	File age (date and time)
f	internal_function	@FILECLOSE	Close a file handle
f	internal_function	@FILEDATE	File date
f	internal_function	@FILENAME	File name and extension
f	internal_function	@FILEOPEN	Open a file handle
f	internal_function	@FILEREAD	Read next line from a file handle
f	internal_function	@FILES	Number of files matching a wildcard
f	internal_function	@FILESEEK	Move a file handle pointer to specified file position
f	internal_function	@FILESEEKL	Move a file handle pointer to a specified line
f	internal_function	@FILESIZE	Total size of files matching a wildcard
f	internal_function	@FILETIME	File time
f	internal_function	@FILEWRITE	Write next line to a file handle
f	internal_function	@FILEWRITEB	Write data to a file handle
f	internal_function	@FINDCLOSE	Closes the search handle.
f	internal_function	@FINDFIRST	Find first matching file
f	internal_function	@FINDNEXT	Find next matching file
f	internal_function	@FLOOR	Largest integer not larger than a number
f	internal_function	@FORMAT	Formats data string according to format string
f	internal_function	@FORMATN	Format a numeric value
f	internal_function	@FSTYPE	File system type (FAT, NTFS, CDFS, etc.)
f	internal_function	@FTYPE	Open command string for file type
f	internal_function	@FULL	Full file name with path
f	internal_function	@FUNCTION	Definition of a function
f	internal_function	@GETDIR	Prompt for a directory name.
f	internal_function	@GETFILE	Prompt for a path and file name.
f	internal_function	@GETFOLDER	Folder name from tree view.
f	internal_function	@GROUP	User is member of group: 1, otherwise 0
f	internal_function	@HISTORY	A line or word from the command history
f	internal_function	@IDOW	Short local name of day of week for date
f	internal_function	@IDOWF	Full local name of day of week for date
f	internal_function	@IF	Evaluates a conditional expression
f	internal_function	@INC	Increment a numeric value by 1
f	internal_function	@INDEX	Offset of string2 within string1
f	internal_function	@INIREAD	Return an entry from an .INI file
f	internal_function	@INIWRITE	Write an entry in an .INI file
f	internal_function	@INODE	File Inode (in hex)
f	internal_function	@INSERT	Inserts string1 into string2
f	internal_function	@INSTR	Extract a substring
f	internal_function	@INT	Integer part of a number
f	internal_function	@IPADDRESS	Returns the numeric IP for a host name
f	internal_function	@IPNAME	Returns the host name for a numeric IP address
f	internal_function	@ISALNUM	Test for alphanumeric characters
f	internal_function	@ISALPHA	Test for alphabetic characters
f	internal_function	@ISASCII	Test for ASCII characters
f	internal_function	@ISCNTRL	Test for control characters
f	internal_function	@ISDIGIT	Test for decimal digits
f	internal_function	@ISPRINT	Test for printable characters
f	internal_function	@ISPUNCT	Test for punctuation characters
f	internal_function	@ISSPACE	Test for white space characters
f	internal_function	@ISXDIGIT	Test for hexadecimal digits
f	internal_function	@JUNCTION	Directory referenced by the junction
f	internal_function	@LABEL	Volume label
f	internal_function	@LCS	Longest common sequence in two strings
f	internal_function	@LEFT	Left end of string
f	internal_function	@LEN	Length of a string
f	internal_function	@LFN	Long name for a short filename
f	internal_function	@LINE	Specified line from a file
f	internal_function	@LINES	Count of lines in a file
f	internal_function	@LINKS	Number of NTFS hard links for the file
f	internal_function	@LOWER	Convert string to lower case
f	internal_function	@LTRIM	Left trim specified characters.
f	internal_function	@MAKEAGE	Convert date and time to age
f	internal_function	@MAKEDATE	Convert number of days to date
f	internal_function	@MAKETIME	Convert number of seconds to time
f	internal_function	@MAX	Largest integer in the list
f	internal_function	@MD5	MD5 hash of a string or file
f	internal_function	@MIN	Smallest integer in the list
f	internal_function	@MONTH	Month for date
f	internal_function	@NAME	File name without path or extension
f	internal_function	@NUMERIC	Test if a string is numeric
f	internal_function	@OPTION	Current directive value
f	internal_function	@OWNER	Return file owner
f	internal_function	@PATH	File path without name
f	internal_function	@PERL	Evaluate a Perl expression
f	internal_function	@PING	Response time from a host
f	internal_function	@QUOTE	Double quote the argument if necessary
f	internal_function	@RANDOM	Generate a random integer
f	internal_function	@READSCR	Read characters from the screen
f	internal_function	@READY	Drive ready: 1, otherwise 0
f	internal_function	@REGCREATE	Create registry subkey
f	internal_function	@REGDELKEY	Delete a registry key and its subkeys
f	internal_function	@REGEX	Match a regular expression
f	internal_function	@REGEXINDEX	Return the offset of a regular expression match
f	internal_function	@REGEXIST	Test if a registry key exists
f	internal_function	@REGEXSUB	Return nth matching regular expression group
f	internal_function	@REGQUERY	Read value from registry
f	internal_function	@REGSET	Write value to registry
f	internal_function	@REGSETENV	Write value to registry and broadcast change.
f	internal_function	@REMOTE	Remote (network) drive: 1, otherwise 0
f	internal_function	@REMOVABLE	Removable drive: 1, otherwise 0
f	internal_function	@REPEAT	Repeat a character
f	internal_function	@REPLACE	Replace string1 with string2 in text
f	internal_function	@REVERSE	Reverse a string
f	internal_function	@REXX	Value of executing an expression by REXX
f	internal_function	@RIGHT	Right end of string.
f	internal_function	@RTRIM	Removes specified trailing characters.
f	internal_function	@RUBY	Evaluate a Ruby expression
f	internal_function	@SCRIPT	Evaluate expression in an active scripting engine.
f	internal_function	@SEARCH	Path search
f	internal_function	@SELECT	Menu selection
f	internal_function	@SERIAL	Serial number of a disk
f	internal_function	@SFN	Short name for a long filename
f	internal_function	@SHA1	SHA1 checksum for the file
f	internal_function	@SHA256	SHA2-256 checksum for the file
f	internal_function	@SHA384	SHA2-384 checksum for the file
f	internal_function	@SHA512	SHA2-512 checksum for the file
f	internal_function	@SIMILAR	Compare two strings for similarity
f	internal_function	@SNAPSHOT	Save a window or desktop as a BMP
f	internal_function	@STRIP	Strips all characters in char from string
f	internal_function	@SUBST	Substitute a string within another string
f	internal_function	@SUBSTR	Extract a substring
f	internal_function	@SUMMARY	Query or set the NTFS SummaryInformation stream
f	internal_function	@SYMLINK	Target of a symbolic link
f	internal_function	@TIME	Convert a time of day to number of seconds
f	internal_function	@TIMER	Get split time from timer.
f	internal_function	@TRIM	Remove blanks from a string
f	internal_function	@TRUENAME	Find true name of a file
f	internal_function	@TRUNCATE	Truncate file at current position
f	internal_function	@UNC	UNC name of a file
f	internal_function	@UNICODE	Numeric UNICODE value for a character
f	internal_function	@UNIQUE	Create file with unique name
f	internal_function	@UNQUOTE	Remove double quotes from a filename
f	internal_function	@UNQUOTES	Remove leading and trailing double quotes
f	internal_function	@UPPER	Convert string to upper case
f	internal_function	@VERINFO	Executable file version information
f	internal_function	@WATTRIB	Test or return file attributes
f	internal_function	@WILD	Compares strings using wildcards
f	internal_function	@WINAPI	Call a Windows API function
f	internal_function	@WINCLASS	Title of first window with classname
f	internal_function	@WINEXENAME	Executable name for window
f	internal_function	@WININFO	Current system information
f	internal_function	@WINMEMORY	Windows memory information
f	internal_function	@WINMETRICS	Windows system metrics
f	internal_function	@WINPOS	Window position
f	internal_function	@WINSTATE	Current state of window
f	internal_function	@WINSYSTEM	Set/get windows system parameters
f	internal_function	@WMI	Query WMI
f	internal_function	@WORD	Extract a word from a string
f	internal_function	@WORDS	Count words in a string
f	internal_function	@WORKGROUP	Workgroup name of a computer
f	internal_function	@XMLPATH	Return text of XML element
f	internal_function	@YEAR	Year for date
k	command	ACTIVATE	Activate or set window state
k	command	ALIAS	Define or display aliases
k	command	ASSOC	Windows file associations
k	command	ATTRIB	Change or display file attributes
k	command	BATCOMP	Batch file compression
k	command	BDEBUGGER	Batch file debugger
k	command	BEEP	Beep the speaker
k	command	BREAK	Define or display Ctrl-C state
k	command	BREAKPOINT	Set a batch debugger breakpoint
k	command	CALL	Call another batch file
k	command	CANCEL	End batch file processing
k	command	CD	Display or change directory
k	command	CDD	Change drive and directory
k	command	CHCP	Display or change code page
k	command	CHDIR	Display or change directory
k	command	CLS	Clear the display window
k	command	COLOR	Change the display colors
k	command	COPY	Copy files and/or directories
k	command	DATE	Display or change date
k	command	DDEEXEC	Send DDE command
k	command	DEBUGSTRING	Send text to system debugger
k	command	DEL	Delete files and/or directories
k	command	DELAY	Wait for specified time
k	command	DESCRIBE	Display or change descriptions
k	command	DETACH	Start app detached
k	command	DIR	Display files and/or directories
k	command	DIRHISTORY	Display directory history list
k	command	DIRS	Display directory stack
k	command	DO	Create batch file loops
k	command	DRAWBOX	Draw a box
k	command	DRAWHLINE	Draw a horizontal line
k	command	DRAWVLINE	Draw a vertical line
k	command	EJECTMEDIA	Eject a removable drive
k	command	ENDLOCAL	Restore from a	SETLOCAL
k	command	ERASE	Delete files and/or directories
k	command	ESET	Edit variables or aliases
k	command	EVENTLOG	Write Windows event log
k	command	EXCEPT	Exclude files from a command
k	command	EXIT	Exit the command processor
k	command	FFIND	Search for files or text
k	command	FOR	Repeat a command
k	command	FREE	Display disk space
k	command	FTYPE	Display or edit file types
k	command	FUNCTION	Create or edit user functions
k	command	GLOBAL	Run command in subdirectories
k	command	GOSUB	Call batch subroutines
k	command	GOTO	Branch in a batch file
k	command	HEAD	Display beginning of file
k	command	HELP	Help for internal commands
k	command	HISTORY	Display or change history
k	command	IFTP	Open FTP connection
k	command	INKEY	Get a single keystroke
k	command	INPUT	Get a text string
k	command	JABBER	Send an IM
k	command	KEYBD	Set keyboard toggles
k	command	KEYS	Enable or disable history list
k	command	KEYSTACK	Send keystrokes to app
k	command	LIST	Display content of files
k	command	LOADBTM	Load batch file as .BTM
k	command	LOG	Save log of commands
k	command	MD	Create subdirectories
k	command	MEMORY	Display memory statistics
k	command	MKDIR	Create subdirectories
k	command	MKLNK	Create NTFS hard or soft link
k	command	MOVE	Move files or directories
k	command	MSGBOX	Popup message box
k	command	ON	Batch file error trapping
k	command	OPTION	Configure command processor
k	command	OSD	Display floating text
k	command	PATH	Set or display PATH
k	command	PAUSE	Wait for input
k	command	PDIR	User-formatted DIR
k	command	PLAYAVI	Display an .AVI file
k	command	PLAYSOUND	Play a sound file
k	command	PLUGIN	Load or unload plugin DLL
k	command	POPD	Restore from directory stack
k	command	POSTMSG	Send a message to a Window
k	command	PRINT	Print a file
k	command	PRIORITY	Set process priority
k	command	PROMPT	Change command line prompt
k	command	PUSHD	Save directory to stack
k	command	QUERYBOX	Popup input box
k	command	QUIT	Exit batch file
k	command	RD	Remove subdirectory
k	command	REBOOT	Reboot system
k	command	RECYCLE	Display or empty recycle bin
k	command	REM	Remark
k	command	REN	Rename files or directories
k	command	RENAME	Rename files or directories
k	command	RETURN	Return from GOSUB
k	command	REXEC	Remotely execute commands
k	command	RMDIR	Remove subdirectory
k	command	RSHELL	Remotely execute commands
k	command	SCREEN	Position cursor
k	command	SCRPUT	Write directly to screen
k	command	SELECT	Select files for a command
k	command	SENDMAIL	Send email
k	command	SET	Set or display environment variables
k	command	SETDOS	Set or display command processor options
k	command	SETLOCAL	Save environment, aliases and functions
k	command	SHIFT	Shift batch file parameters
k	command	SHORTCUT	Create a Windows shortcut
k	command	SHRALIAS	Share aliases
k	command	SMPP	Simple message transfer
k	command	SNMP	Send SNMP traps
k	command	SNPP	Send message to pager
k	command	START	Start a new session
k	command	SYNC	Synchronize directories
k	command	TAIL	Display end of file
k	command	TASKEND	End a task
k	command	TASKLIST	Display Windows task list
k	command	TCTOOLBAR	Edit Toolbar
k	command	TEE	Pipe "tee-fitting"
k	command	TEXT	Display text in batch file
k	command	TIME	Set or display time
k	command	TIMER	Stopwatch
k	command	TITLE	Set window title
k	command	TOUCH	Change file timestamps
k	command	TRANSIENT	Toggle shell transient mode
k	command	TREE	Display directory tree
k	command	TRUENAME	Display true pathname
k	command	TYPE	Display files
k	command	UNALIAS	Remove aliases
k	command	UNFUNCTION	Remove user-defined functions
k	command	UNSET	Remove environment variable
k	command	VER	Display version
k	command	VERIFY	Display or set disk verification
k	command	VOL	Display or set disk volume label
k	command	VSCRPUT	Write text vertically
k	command	WHICH	Display command information
k	command	WINDOW	Window management
k	command	WMIQUERY	WMI queries
k	command	Y	Pipe "y-fitting"
k	command DATETIME	Repeat a command
k	command ENDDO	Repeat a command
k	command FOREVER	Repeat a command
k	command IN	Repeat a command
k	command ITERATE	Repeat a command
k	command LEAVE	Repeat a command
k	command UNTIL	Repeat a command
k	command WHILE	Repeat a command
o	operator	AND		Logical And
o	operator	DEFINED		Variable is defined
o	operator	DIREXIST	Directroy exits
o	operator	EQ		Equal
o	operator	ERRORLEVEL	Last Error
o	operator	EXIST		File exits
o	operator	GE		Greater Equal
o	operator	GT		Greater Then
o	operator	ISALIAS		Is Alias
o	operator	ISDIR		Is Directory
o	operator	ISINTERNAL	Is internal command
o	operator	ISLABEL		Is lable
o	operator	LE		Less Equal
o	operator	LT		Less Then
o	operator	NE		Not Equal
o	operator	NOT		Logical Not
o	operator	OR		Logical Or
o	operator	XOR		Exlusive Or
s	system_variable CDPATH	Directory navigation search list
s	system_variable CMDLINE	Command line after full expansion
s	system_variable COLORDIR	Directory colorization specification
s	system_variable COMSPEC	Command processor specification
s	system_variable FILECOMPLETION	File completion control variable
s	system_variable HISTORYEXCLUSION	List of commands excluded from the command history
s	system_variable PATH	Executable program location search list
s	system_variable PATHEXT	Ordered search list of extensions of executable programs
s	system_variable PROMPT	Command prompt format specification
s	system_variable RECYCLEEXCLUDE	List of files excluded from the recycle bin
s	system_variable TEMP	Directory for temporary files
s	system_variable TITLEPROMPT	Command processor window title bar specification
s	system_variable TMP	Directory for temporary files
s	system_variable TREEEXCLUDE	List of directories excluded from JPSTREE.IDX
s	system_variable VARIABLEEXCLUDE	Variables to exclude from SET list
t	config	//4StartPath	(4NT) Set location of 4START and 4EXIT 
t	config	//ANSI	Enables ANSI X3.64 support
t	config	//AddFile	Keeps filename completion entry and adds another
t	config	//AliasExpand	Expands aliases on command line
t	config	//AmPm	Time display format
t	config	//AppendToDir	Appends trailing "\" to directory names in filename completion
t	config	//AutoCancel	If yes, ^C will cancel batch files without a prompt
t	config	//AutoRun	Run programs in AutoRun registry key
t	config	//BGColorRGB	(TC) Set the default background color as an RGB value
t	config	//Backspace	Deletes the character to the left of the cursor
t	config	//BatchEcho	Default echo state for batch files
t	config	//BeepFreq	Default beep frequency
t	config	//BeepLength	Default beep length
t	config	//BeginLine	Moves the cursor to the start of the line
t	config	//CDDWinColors	Colors for directory search window.
t	config	//CDDWinHeight	Initial height of the extended directory search window
t	config	//CDDWinLeft	Initial position of the left border of the extended directory search window
t	config	//CDDWinTop	Initial position of the top border of the extended directory search window
t	config	//CDDWinWidth	Initial width of the extended directory search window
t	config	//CMDExtensions	Enable or disable CMD.EXE-compatible command extensions
t	config	//CUA	(TC) Key set used for cut, copy, and paste
t	config	//ClearKeyMap	Clear default key mappings
t	config	//ColorDir	Directory colors
t	config	//CommandEscape	Allows direct entry of a keystroke
t	config	//CommandSep	Multiple command separator character
t	config	//CompleteHidden	Enable / disable return of hidden files from filename completion
t	config	//CompletePaths	Search PATH during filename completion
t	config	//ConsoleColumns	(TC) Sets the width of the console mode screen buffer
t	config	//ConsoleRows	(TC) Sets the height of the console mode screen buffer
t	config	//Copy	Copies highlighted text to the keyboard
t	config	//CopyPrompt	Enable or disable confirmation prompt for  COPY and MOVE
t	config	//CursorIns	Cursor width in insert mode
t	config	//CursorOver	Cursor width in overstrike mode
t	config	//Debug	Set debugging options
t	config	//DebuggerTransparency	Transparency of the debugger window
t	config	//DecimalChar	Select decimal separator for @EVAL, etc.
t	config	//Del	Deletes the character at the cursor
t	config	//DelGlobalQuery	Enable or disable confirmation prompt with DEL /Q
t	config	//DelHistory	Deletes a history list entry
t	config	//DelToBeginning	Deletes from the cursor to the start of the line
t	config	//DelToEnd	Deletes from the cursor to the end of the line
t	config	//DelWordLeft	Deletes the word to the left of the cursor
t	config	//DelWordRight	Deletes the word to the right of the cursor
t	config	//DelayedExpansion	Enable or disable CMD.EXE-style delayed expansion
t	config	//DescriptionMax	Maximum length of file descriptions
t	config	//DescriptionName	Name of file to hold file descriptions
t	config	//Descriptions	Enable / disable description processing
t	config	//DirHistory	Set size of Directory History
t	config	//DirWinOpen	Opens the directory history window
t	config	//Down	Moves the cursor or scrolls the display down
t	config	//DuplicateBugs	Duplicate well-known CMD.EXE bugs
t	config	//EditMode	Editing mode (insert / overstrike)
t	config	//Editor	(TC) Program to run for "Editor" menu choice
t	config	//EndHistory	Displays the last entry in the history list
t	config	//EndLine	Moves the cursor to the end of the line
t	config	//EraseLine	Deletes the entire line
t	config	//EscapeChar	Select escape character.
t	config	//EvalMax	Maximum precision displayed by @EVAL
t	config	//EvalMin	Minimum precision displayed by @EVAL
t	config	//ExecLine	Executes or accepts a line
t	config	//ExecWait	Forces the command processor to wait for external programs to complete
t	config	//ExitFile	Enable or disable 4EXIT / TCEXIT
t	config	//FGColorRGB	(TC) Set the default foreground color as an RGB value
t	config	//FTPCFG	Specifies the location of the file containing the ftp user names and passwords
t	config	//FTPTimeout	Timeout (inactivity) period for FTP / FTPS operations
t	config	//FileCompletion	Select files selected for file completion
t	config	//FirewallHost	Firewall server name
t	config	//FirewallPassword	Password for firewall authentication
t	config	//FirewallType	Type of firewall
t	config	//FirewallUser	Username for firewall authentication
t	config	//FuzzyCD	Enables or disables extended directory searches
t	config	//HTTPTimeout	Timeout (inactivity) period for HTTP / HTTPS operations
t	config	//Help	Invokes this help system
t	config	//HelpWord	Invokes help for the word at the cursor
t	config	//HideConsole	(TC) Hide the console window after running a character-mode application
t	config	//HistCopy	Copy recalled commands to end of history
t	config	//HistDups	Controls entry/retention of duplicate history entries
t	config	//HistFile	Persistent history file name
t	config	//HistLogName	History log file name
t	config	//HistLogOn	Turns on history logging when the command processor starts
t	config	//HistMin	Minimum command length to save
t	config	//HistMove	Move recalled commands to end of history
t	config	//HistWinOpen	Opens the command history window
t	config	//HistWrap	Behavior of the command history list
t	config	//History	Set size of Command History
t	config	//IBeamCursor	(TC) Set text cursor style
t	config	//INIQuery	Query for each line in the .INI file
t	config	//InactiveTransparency	(TC) Set the transparency level when out of focus
t	config	//Include	Include text from another file in the current .INI file
t	config	//InputColors	Input colors
t	config	//Ins	Toggles insert / overstrike mode
t	config	//JabberPassword	User password for Jabber server
t	config	//JabberServer	Jabber server name
t	config	//JabberUser	Jabber user name
t	config	//LFNToggle	Toggles between long and short filenames
t	config	//LanguageDLL	Set localized language DLL
t	config	//LastHistory	Returns last history entry
t	config	//Left	Moves the cursor or scrolls the display left
t	config	//LineToEnd	Copies a line to the end of the history, then executes it.
t	config	//ListBack	Returns to the previous file
t	config	//ListColors	Colors used in the LIST display
t	config	//ListContinue	Go to the next file
t	config	//ListExit	Exits the current file
t	config	//ListFind	Prompts and searches for a string
t	config	//ListFindRegex	Prompt and search for a regular expression
t	config	//ListFindRegexReverse	Prompt and search backwards for a regular expression
t	config	//ListFindReverse	Prompts and searches backwards
t	config	//ListHex	Toggles between hexadecimal and character display modes
t	config	//ListHighBit	Toggles LIST's "strip high bit" option
t	config	//ListInfo	Displays information about the current file
t	config	//ListInverseColors	(4NT) Set the color to use in LIST for search matches
t	config	//ListNext	Finds the next matching string
t	config	//ListOpen	Displays the "open file" dialog
t	config	//ListPrevious	Finds the previous matching string
t	config	//ListPrint	Prints the file on the default printer
t	config	//ListRowStart	Starting row number for LIST and FFIND
t	config	//ListStatBarColors	(4NT)	Color for LIST status bar
t	config	//ListUnicode	Toggles Unicode display mode
t	config	//ListWrap	Toggles LIST's wrap option
t	config	//ListboxBarColors	(4NT) Colors of popup list boxes.
t	config	//LocalAliases	Local vs. global aliases
t	config	//LocalDirHistory	Local vs. global directory history
t	config	//LocalFunctions	Local vs. global functions
t	config	//LocalHistory	Local vs. global history
t	config	//LogAll	(TC) Log all output
t	config	//LogErrors	Send error messages to the log file
t	config	//LogName	Name the log file
t	config	//LogOn	Turns on command logging when the command processor starts
t	config	//MailAddress	Email address of user
t	config	//MailPassword	Password for SMTP authentication
t	config	//MailPort	SMTP port number
t	config	//MailServer	Your SMTP server name
t	config	//MailUser	User name for SMTP authentication
t	config	//NTFSDescriptions	Store descriptions in NTFS SummaryInformation stream
t	config	//NextFile	Gets the next matching filename
t	config	//NextHistory	Recalls the next command from the history
t	config	//NextINIFile	.INI file for all secondary shells
t	config	//NoClobber	Overwrite protection for output redirection
t	config	//NormalEditKey	Deassigns a command line editing key
t	config	//NormalKey	Deassigns a key
t	config	//NormalListKey	Deassigns a LIST window key
t	config	//NormalPopupKey	Deassigns a popup window key
t	config	//ParameterChar	Alias / batch file parameter character
t	config	//PassiveFTP	Enable or disable passive mode for FTP calls
t	config	//Paste	Pastes line from clipboard
t	config	//PathExt	Enable or disable the PATHEXT variable
t	config	//PauseOnError	(4NT) Force pause after displaying error message
t	config	//Perl	Enable or disable internal Perl support
t	config	//PopFile	Opens the filename completion window
t	config	//PopupWinBegin	Moves to the first line of the popup window
t	config	//PopupWinColors	(TC) Colors for most popup windows
t	config	//PopupWinDel	Deletes a line from within the popup window
t	config	//PopupWinEdit	Moves a line from the popup window to the prompt
t	config	//PopupWinEnd	Moves to the last line of the popup window
t	config	//PopupWinExec	Selects the current item and closes the popup window
t	config	//PopupWinHeight	Initial height of popup windows
t	config	//PopupWinLeft	Initial position of left border of popup windows
t	config	//PopupWinTop	Initial position of top border of popup windows
t	config	//PopupWinWidth	Initial width of popup windows
t	config	//PrevFile	Gets the previous matching filename
t	config	//PrevHistory	Recalls the previous command from the history
t	config	//Proxy	Sets name of HTTP Proxy server
t	config	//ProxyPassword	HTTP proxy password for Basic authentication
t	config	//ProxyPort	Sets port number of HTTP Proxy server
t	config	//ProxyUser	HTTP proxy user name for Basic authentication
t	config	//REXX	Enable or disable internal REXX support
t	config	//RLocalHost	Set name of local host for REXEC and RSHELL
t	config	//RLocalPort	Set the port to bind to for REXEC and RSHELL
t	config	//RLocalUser	Set name of the user on the local machine for RSHELL
t	config	//RecycleBin	Sets whether deleted files go to the Recycle Bin
t	config	//RegularExpressions	Sets the regular expression syntax type
t	config	//RepeatFile	Repeats previous match during filename completion
t	config	//Right	Moves the cursor or scrolls the display right
t	config	//Ruby	Enable or disable the internal Ruby support
t	config	//SHChangeNotify	Notify the system shell when changing files or directories
t	config	//SSLPort	Sets the port number for FTP SSL service
t	config	//SSLProvider	Sets the name of the security provider
t	config	//SSLStartMode	Specifies how to start SSL negotiation
t	config	//SaveDirCase	Control preservation of original upper/lower case name when changing directories.
t	config	//SaveHistory	Saves the command line without executing it
t	config	//ScreenBufSize	(TC) Size of screen buffer
t	config	//ScreenColumns	(TC) Virtual screen width
t	config	//ScreenRows	(TC) Virtual screen height
t	config	//ScrollDown	(TC) Scroll the buffer down one line.
t	config	//ScrollPgDn	(TC) Scroll the buffer down one page.
t	config	//ScrollPgUp	(TC) Scroll the buffer up one page.
t	config	//ScrollUp	(TC) Scroll the buffer up one line.
t	config	//SelectColors	Colors used in the SELECT display
t	config	//SelectStatBarColors	(4NT) Color used by SELECT status bar
t	config	//ServerCompletion	Sets server name completion options
t	config	//SettingChange	Monitor WM_SETTINGCHANGE message
t	config	//StartupFile	Enable or disable 4START / TCSTART execution
t	config	//StatusBarOn	(TC) Set status bar mode at startup
t	config	//StatusBarText	(TC) Point size of status bar text
t	config	//StdColors	Standard display colors
t	config	//SwapScrollKeys	(TC) Switch to 4NT-style history and scrolling keys
t	config	//SwitchChar	Set the default switch character
t	config	//TCStartPath	(TC) Path for TCSTART and TCEXIT
t	config	//TFTPTimeout	Timeout (inactivity) period for TFTP operations
t	config	//TabStops	Sets the tab positions for output.
t	config	//ThousandsChar	Thousands separator for @EVAL, etc.
t	config	//TimeServer	URL of time server
t	config	//ToolBarOn	(TC) Set tool bar mode at startup
t	config	//ToolBarText	(TC) Point size of tool bar text
t	config	//Transparency	(TC) Default transparency for Take Command window
t	config	//TreePath	Path for directory database JPSTREE.IDX
t	config	//UnicodeOutput	Use Unicode for output redirection
t	config	//UnixPaths	Enable or disable forward slash in command paths
t	config	//Up		Moves the cursor or scrolls the display up
t	config	//UpdateTitle	Prevents or allows updating of the command processor window title
t	config	//VariableExpand	Expand variables at the command line
t	config	//Win32SFNSearch	Search for short and long file names
t	config	//WindowHeight	Initial height of the command processor window
t	config	//WindowState	Initial state for the command processor window
t	config	//WindowWidth	Initial width of the command processor window
t	config	//WindowX	Initial position of the left border of the command processor window
t	config	//WindowY	Initial position of the top border of the command processor window
t	config	//WordLeft	Moves the cursor left one word
t	config	//WordRight	Moves the cursor right one word
t	config	//Wow64FsRedirection	Enable or disable Windows 64 remapping of windows\system32
t	config			//ZoneID	Enable or disable ZoneID security
v	internal_variable	_4ver		Command processor version
v	internal_variable	_acstatus	AC line status
v	internal_variable	_afswcell	OpenAFS workstation cell
v	internal_variable	_alt		Alt key depressed: 1, else 0
v	internal_variable	_ansi		ANSI X3.64 status
v	internal_variable	_batch		Batch nesting level
v	internal_variable	_batchline	Line number in current batch file.
v	internal_variable	_batchname	Full path and filename of current batch file.
v	internal_variable	_batchtype	Type of the current batch file
v	internal_variable	_battery	Battery status
v	internal_variable	_batterylife	Remaining battery life, seconds
v	internal_variable	_batterypercent	Remaining battery life, %
v	internal_variable	_bdebugger	Batch debugger active: 1, else 0
v	internal_variable	_bg		Background color at cursor position
v	internal_variable	_boot		Boot drive letter, without a colon
v	internal_variable	_build		Build number
v	internal_variable	_capslock	CapsLock on: 1, else 0
v	internal_variable	_cdroms		List of the CD-ROM drives
v	internal_variable	_childpid	Process ID of most recent child process
v	internal_variable	_ci		Current text cursor shape in insert mode
v	internal_variable	_cmdline	Current command line
v	internal_variable	_cmdproc	Command processor name
v	internal_variable	_cmdspec	Full pathname of command processor
v	internal_variable	_co		Current text cursor shape in overstrike mode
v	internal_variable	_codepage	Current code page number
v	internal_variable	_column		Current cursor column
v	internal_variable	_columns	Virtual screen width
v	internal_variable	_country	Current country code
v	internal_variable	_cpu		CPU type
v	internal_variable	_cpuusage	CPU time usage (percent)
v	internal_variable	_ctrl		Ctrl key depressed: 1, else 0
v	internal_variable	_cwd		Current drive and directory
v	internal_variable	_cwds		Current drive and directory with trailing \
v	internal_variable	_cwp		Current directory
v	internal_variable	_cwps		Current directory with trailing \
v	internal_variable	_date		Current date
v	internal_variable	_datetime	Current date and time, yyyyMMddhhmmss
v	internal_variable	_day		Current day of the month
v	internal_variable	_detachpid	Process ID of most recent detached process
v	internal_variable	_disk		Current drive
v	internal_variable	_dname		Name of the description file.
v	internal_variable	_dos		Operating system type 
v	internal_variable	_dosver		Operating system version
v	internal_variable	_dow		Current day of the week, English, short
v	internal_variable	_dowf		Current day of the week, English, full
v	internal_variable	_dowi		Current day of the week as an integer
v	internal_variable	_doy		Current day of the year
v	internal_variable	_drives		List of the existing drives
v	internal_variable	_dst		Daylight savings time: 1, else 0
v	internal_variable	_dvds		List of the DVD drives
v	internal_variable	_echo		Echo turned on: 1, else 0
v	internal_variable	_editmode	0 if in overstrike mode, 1 if in insert mode
v	internal_variable	_execstr	@EXECSTR return code
v	internal_variable	_exit		Reason for exiting command processor
v	internal_variable	_expansion	SETDOS /X value
v	internal_variable	_fg		Foreground color at cursor position
v	internal_variable	_ftperror	Last FTP error code
v	internal_variable	_hdrives	List of the fixed drives
v	internal_variable	_hlogfile	Current history log file name
v	internal_variable	_host		Host name of local computer.
v	internal_variable	_hour		Current hour
v	internal_variable	_hwprofile	Windows hardware profile if defined
v	internal_variable	_idleticks	Milliseconds since the last user input
v	internal_variable	_idow		Current day of the week, local language, short
v	internal_variable	_idowf		Current day of the week, local language, full
v	internal_variable	_iftp		IFTP session active: 1, else 0
v	internal_variable	_iftps		IFTPS session active: 1, else 0
v	internal_variable	_imonth		Current month name, local language, short
v	internal_variable	_imonthf	Current month name, local language, full
v	internal_variable	_ininame	Full pathname of the current INI file
v	internal_variable	_ip		IP address(es) of local computer.
v	internal_variable	_isodate	Current date in ISO 9601 format
v	internal_variable	_kbhit		Keyboard input character is waiting: 1, else 0
v	internal_variable	_lalt		left Alt key depressed: 1, else 0
v	internal_variable	_lastdisk	Last valid drive
v	internal_variable	_lctrl		Left Ctrl key depressed: 1, else 0
v	internal_variable	_logfile	Current log file name
v	internal_variable	_lshift		Left Shift key depressed: 1, else 0
v	internal_variable	_minute		Current minute
v	internal_variable	_month		Current month of the year as integer
v	internal_variable	_monthf		Current month of the year, English, full
v	internal_variable	_numlock	NumLock on: 1, else 0
v	internal_variable	_openafs	OpenAFS installed: 1, otherwise 0
v	internal_variable	_osbuild	Windows build number
v	internal_variable	_pid		Command processor process ID (numeric)
v	internal_variable	_pipe		Current process is running in a pipe: 1, else 0
v	internal_variable	_ppid		Process ID of parent process
v	internal_variable	_ralt		Right Alt key depressed: 1, else 0
v	internal_variable	_rctrl		Right Ctrl key depressed: 1, else 0
v	internal_variable	_ready		List of accessible drives
v	internal_variable	_registered	Registered user name
v	internal_variable	_row		Current cursor row
v	internal_variable	_rows		Screen height
v	internal_variable	_rshift		Right Shift key depressed: 1, else 0
v	internal_variable	_scrolllock	ScrollLock on: 1, else 0
v	internal_variable	_second		Current second
v	internal_variable	_selected	(TC) First line of highlighted text
v	internal_variable	_shell		Shell level
v	internal_variable	_shells		Shell level (old style)
v	internal_variable	_shift		Shift key depressed: 1, else 0
v	internal_variable	_shralias	SHRALIAS is loaded: 1, else 0
v	internal_variable	_startpath	Startup directory of current shell.
v	internal_variable	_startpid	Process ID of most recent STARTed process.
v	internal_variable	_stderr		STDERR redirected: 1, else 0
v	internal_variable	_stdin		STDIN redirected: 1, else 0
v	internal_variable	_stdout		STDOUT redirected: 1, else 0
v	internal_variable	_stzn		Name of time zone for standard time
v	internal_variable	_stzo		Offset in minutes from UTC for standard time
v	internal_variable	_syserr		Latest Windows error code
v	internal_variable	_time		Current time
v	internal_variable	_transient	Current process is a transient shell: 1, else 0
v	internal_variable	_tzn		Name of current time zone
v	internal_variable	_tzo		Offset in minutes from UTC for current time zone
v	internal_variable	_unicode	Shell uses unicode for redirected output: 1, else 0
v	internal_variable	_virtualpc	Running inside VirtualPC: 1; else 0
v	internal_variable	_vmware		Running inside VMWare: 1; else 0
v	internal_variable	_windir		Windows directory pathname
v	internal_variable	_winfgwindow	Title of foreground window.
v	internal_variable	_winname	Name of local computer
v	internal_variable	_winsysdir	Windows system directory pathname
v	internal_variable	_winticks	Milliseconds since Windows was started
v	internal_variable	_wintitle	Current window title
v	internal_variable	_winuser	Name of current user.
v	internal_variable	_winver		Windows version number
v	internal_variable	_wow64		Running inside WOW64: 1; else 0
v	internal_variable	_xpixels	Physical screen horizontal size in pixels
v	internal_variable	_year		Current year
v	internal_variable	_ypixels	Physical screen vertical size in pixels
v	internal_variable	errorlevel	Exit code, last external program
=== END_KEYWORDS

"------------------------------------------------------------------------------
"   Copyright (C) 2006	Martin Krischik
"
"   Vim is Charityware - see ":help license" or uganda.txt for licence details.
"------------------------------------------------------------------------------
" vim: textwidth=0 wrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab
" vim: foldmethod=marker
