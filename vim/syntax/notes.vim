if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "notes"
set showmatch

if !exists("*Notesoff")
	function Notesoff()
		execute ':colorscheme ' . g:colors_name
	endfunction
endif

if !exists("*Noteson")
	function Noteson()
		let b:current_syntax = "notes"
		syntax on
	endfunction
endif			

if !exists("*Darknote")
	function Darknote()
		if &ft ==# "notes"
			set background=dark
			syntax sync fromstart
			syntax off
			syntax on
		endif
	endfunction
endif

if !exists("*Lightnote")
	function Lightnote()
		if &ft ==# "notes"
			set background=light
			syntax sync fromstart
			syntax off
			syntax on
		endif
	endfunction
endif

command! Notesoff call Notesoff()
command! Noteson call Noteson()
command! Darknote call Darknote()
command! Lightnote call Lightnote()

if &ft ==# "notes"
	if &background ==# "dark"
		highlight Normal ctermbg=NONE ctermfg=white guibg=NONE guifg=white
		highlight Cursor ctermfg=white guifg=white
		highlight NoteFunction ctermfg=darkcyan guifg=darkcyan
		highlight NoteKeyword ctermfg=cyan guifg=cyan
		highlight LineNR ctermfg=red guifg=red
		highlight StandOut ctermfg=lightgreen guifg=lightgreen
		highlight ArgSeparator ctermfg=darkred guifg=darkred
		highlight NumberArg ctermfg=magenta guifg=magenta
		highlight TextStandOut cterm=underline ctermfg=white gui=underline guifg=white
		highlight TextSpecial ctermfg=lightgreen guifg=lightgreen
		highlight NoteBullet cterm=bold ctermfg=green gui=bold guifg=green
		highlight SectionTitle cterm=bold ctermfg=cyan gui=bold guifg=cyan
	elseif &background ==# "light"
		highlight Normal ctermbg=darkgray ctermfg=lightgray guibg=darkgray guifg=black
		highlight Cursor ctermfg=black guifg=black
		highlight NoteFunction ctermfg=cyan guifg=cyan
		highlight NoteKeyword ctermfg=green guifg=green
		highlight LineNR ctermfg=blue guifg=blue
		highlight ArgSeparator ctermfg=lightred guifg=lightred
		highlight NumberArg ctermfg=red guifg=red
		highlight TextStandOut cterm=underline ctermfg=black gui=underline guifg=black
		highlight TextSpecial ctermfg=lightblue guifg=lightblue
		highlight NoteBullet cterm=bold ctermfg=cyan gui=bold guifg=cyan
		highlight SectionTitle cterm=bold ctermfg=blue gui=bold guifg=blue
	endif

	syntax keyword notesFunction cmb frc equ
	syntax keyword notesKeyword EQUS EQUE LSTS LSTE SRCE TBLE nextgroup=EOL
	syntax match titleLine /^#.*$/
	syntax match bullet /^[ \t]*\(\* \|\*\S\)[.]*/

	syntax keyword startSource SRCS nextgroup=langStart
	syntax keyword startTable TBLS nextgroup=colStart

	syntax match TableCols '\d*[^:]' contained nextgroup=titleStart
	syntax match TableTitle '.*' contained nextgroup=EOL

	syntax match colStart ':' contained nextgroup=TableCols
	syntax match titleStart ':' contained nextgroup=TableTitle
	syntax match langStart ':' contained nextgroup=SourceLanguage

	syntax keyword SourceLanguage asm awk bash sh csh ksh zsh c cpp cs css javascript java ruby python contained nextgroup=EOL
	syntax match EOL '$' contained

	highlight link TableCols NumberArg
	highlight link TableTitle TextStandOut
	highlight link SourceLanguage TextSpecial

	highlight link colStart ArgSeparator
	highlight link titleStart ArgSeparator
	highlight link langStart ArgSeparator

	highlight link notesFunction NoteFunction
	highlight link notesKeyword NoteKeyword
	highlight link startSource NoteKeyword
	highlight link startTable NoteKeyword

	highlight link titleLine SectionTitle
	highlight link bullet NoteBullet

	syntax cluster ParenGroup contains=notesFunction
	syntax match ParenError display ')'
	syntax region  Paren transparent matchgroup=hlLevel0 start='(' end=')' contains=@ParenGroup,Paren1
	syntax region  Paren1 transparent matchgroup=hlLevel1 start='(' end=')' contains=@ParenGroup,Paren2
	syntax region  Paren2 transparent matchgroup=hlLevel2 start='(' end=')' contains=@ParenGroup,Paren3
	syntax region  Paren3 transparent matchgroup=hlLevel3 start='(' end=')' contains=@ParenGroup,Paren4
	syntax region  Paren4 transparent matchgroup=hlLevel4 start='(' end=')' contains=@ParenGroup,Paren5
	syntax region  Paren5 transparent matchgroup=hlLevel5 start='(' end=')' contains=@ParenGroup,Paren6
	syntax region  Paren6 transparent matchgroup=hlLevel6 start='(' end=')' contains=@ParenGroup,Paren7
	syntax region  Paren7 transparent matchgroup=hlLevel7 start='(' end=')' contains=@ParenGroup,Paren8
	syntax region  Paren8 transparent matchgroup=hlLevel8 start='(' end=')' contains=@ParenGroup,Paren9
	syntax region  Paren9 transparent matchgroup=hlLevel9 start='(' end=')' contains=@ParenGroup,Paren
	highlight link ParenError Error

	highlight default link hlLevel0 NoteFunction
	highlight default link hlLevel1 NoteFunction
	highlight default link hlLevel2 NoteFunction
	highlight default link hlLevel3 NoteFunction
	highlight default link hlLevel4 NoteFunction
	highlight default link hlLevel5 NoteFunction
	highlight default link hlLevel6 NoteFunction
	highlight default link hlLevel7 NoteFunction
	highlight default link hlLevel8 NoteFunction
	highlight default link hlLevel9 NoteFunction
else
	execute ':colorscheme ' . g:colors_name
endif
