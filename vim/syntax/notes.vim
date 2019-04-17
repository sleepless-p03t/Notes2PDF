if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "notes"

" Configures the colors based on dark/light background
if &background ==# "dark"
	highlight NoteFunction ctermfg=white guifg=white
	highlight NoteKeyword ctermfg=cyan guifg=cyan
	highlight StandOut ctermfg=lightgreen guifg=lightgreen
	highlight ArgSeparator ctermfg=darkred guifg=darkred
	highlight NumberArg ctermfg=magenta guifg=magenta
	highlight TextStandOut cterm=underline ctermfg=white gui=underline guifg=white
	highlight TextSpecial ctermfg=lightgreen guifg=lightgreen
	highlight NoteBullet cterm=bold ctermfg=green gui=bold guifg=green
	highlight SectionTitle cterm=bold ctermfg=cyan gui=bold guifg=cyan
	highlight GenWord ctermfg=lightgray guifg=lightgray
	highlight NoteString ctermfg=green guifg=green
elseif &background ==# "light"
	highlight NoteFunction ctermfg=cyan guifg=cyan
	highlight NoteKeyword ctermfg=green guifg=green
	highlight ArgSeparator ctermfg=lightred guifg=lightred
	highlight NumberArg ctermfg=red guifg=red
	highlight TextStandOut cterm=underline ctermfg=black gui=underline guifg=black
	highlight TextSpecial ctermfg=lightblue guifg=lightblue
	highlight NoteBullet cterm=bold ctermfg=cyan gui=bold guifg=cyan
	highlight SectionTitle cterm=bold ctermfg=blue gui=bold guifg=blue
	highlight GenWord ctermfg=black guifg=black
	highlight NoteString ctermfg=lightcyan guifg=lightcyan
endif

" Basic 'static' keywords/rules
syntax keyword notesFunction cmb frc equ bld udl itl
syntax keyword notesKeyword EQUS EQUE LSTS LSTE SRCE TBLE GRPE PBREAK nextgroup=EOL

" Title and bullet styles
syntax match titleLine /^#.*$/
syntax match bullet /^[ \t]*\(\* \|\*\S\+\)[.]*/

" Special notesKeywords
syntax keyword startSource SRCS nextgroup=langStart
syntax keyword startTable TBLS nextgroup=colStart
syntax keyword startGroup GRPS nextgroup=fileStart

" Table column number rule
syntax match TableCols '\d*[^:]' contained nextgroup=titleStart
" Table title rule
syntax match TableTitle '.*' contained nextgroup=EOL
syntax match FileName '.*' contained nextgroup=EOL

" These are all technically the same, but they each appear before a different rule
syntax match colStart ':' contained nextgroup=TableCols
syntax match fileStart ':' contained nextgroup=FileName
syntax match titleStart ':' contained nextgroup=TableTitle
syntax match langStart ':' contained nextgroup=SourceLanguage

" A partial list of common languages supported by LaTeX listings package
syntax keyword SourceLanguage asm awk bash sh csh ksh zsh c cpp cs css javascript java ruby python contained nextgroup=EOL

" End of line rule
syntax match EOL '$' contained

syntax region noteString start=/\v"/ skip=/\v\\./ end=/\v"/

" Link syntax rules to color rules
highlight link TableCols NumberArg
highlight link TableTitle TextStandOut
highlight link SourceLanguage TextSpecial
highlight link FileName GenWord

highlight link colStart ArgSeparator
highlight link titleStart ArgSeparator
highlight link langStart ArgSeparator
highlight link fileStart ArgSeparator

highlight link notesFunction NoteFunction
highlight link notesKeyword NoteKeyword
highlight link startSource NoteKeyword
highlight link startTable NoteKeyword
highlight link startGroup NoteKeyword

highlight link titleLine SectionTitle
highlight link bullet NoteBullet

highlight link noteString NoteString

" Highlight matching parens, error output mismatched paren
" Modified based on Accepted Answer from https://stackoverflow.com/questions/542929/highlighting-unmatched-brackets-in-vim
" which is a variation on Dr Chip's rainbow plugin: http://www.drchip.org/astronaut/vim/#RAINBOW

syntax cluster ParenGroup contains=notesFunction,noteString
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
