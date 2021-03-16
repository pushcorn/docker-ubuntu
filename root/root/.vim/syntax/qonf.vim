" Vim syntax file
" Language: QDSH configuration file

if exists("b:current_syntax")
  finish
endif

syn region  qdAction            start='^\s*[a-z][a-z0-9-.]*\:' end='$' oneline contains=qdActionLineCont,qdActionType
syn match   qdActionLineCont    '\\$' contained
syn match   qdActionType        '^\s*[a-z][a-z0-9-.]*\:' contained

syn match   qdComments          '^\s*#.*'
syn region  qdCommentsBlock     start='#{' end='#}'

syn region  qdOption            start='^#[!?*+]\s' end='$' oneline contains=qdOptionLineCont
syn region  qdInclude           start='^#<[!?]\?\s' end='$'
syn region  qdAlias             start='^#[=]\s' end='$' oneline contains=qdAliasLineCont
syn match   qdOptionLineCont    '\\$' contained
syn match   qdAliasLineCont     '\\$' contained

hi link qdActionType        Identifier
hi link qdAction            String
hi link qdActionLineCont    String
hi link qdOption            Special
hi link qdInclude           Special
hi link qdOptionLineCont    Special
hi link qdAlias             Function
hi link qdAliasLineCont     Function
hi link qdComments          Comment
hi link qdCommentsBlock     Comment

let b:current_syntax = "qdsh"
