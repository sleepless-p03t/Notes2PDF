if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "notes"
set showmatch

syntax keyword notesFunction cmb frc equ
syntax keyword notesKeyword EQUS EQUE LSTS LSTE SRCE TBLE
syntax keyword specialKeyword SRCS TBLS nextgroup=KeywordArgs
syntax match KeywordArgs ':\i\+' contained

syntax match titleLine /^#.*$/
syntax match bullet /^[ \t]*\*/

highlight titleLine	cterm=bold ctermfg=cyan guifg=#00ffff
highlight bullet cterm=bold ctermfg=white guifg=#ffffff

highlight KeywordArgs ctermfg=red

highlight link notesKeyword Keyword
highlight link specialKeyword Keyword

highlight link notesFunction Function
