au FileType netrw setl bufhidden=wipe


set laststatus=2
set statusline+=%F
set redrawtime=10000
syntax sync minlines=10000
set nocompatible
set nowrap
set nowritebackup
set noea
set nofoldenable
set noswf
set lbr
set expandtab
set textwidth=0
set bs=2		" allow backspacing over everything in insert mode
set ts=2
set sw=4
set ai			" always set autoindenting on
set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set incsearch		" do incremental searching
set ignorecase
set smartcase
set viminfo='10,\"100,:20,%,n~/.viminfo


set clipboard=unnamed
set showmatch
set cindent
set cinkeys-=0#
set indentkeys-=0#
set complete-=k complete+=k
set completeopt=longest,menuone
set wildmenu
set wildmode=list:longest

hi Search term=reverse ctermbg=3 ctermfg=white

" set nohlsearch
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")

" Don't use Ex mode, use Q for formatting
map Q gq
map <home> <home>
map <end>  <end>
map <F1> :let @/ = ""<CR>


" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>


"copy and paste betweeen different vim sessions
map    qy  :w! ~/.qd_clip<CR>:*y<CR><Left>
map    qx  :w! ~/.qd_clip<CR>:*d<CR><Left>
map    qp  :r ~/.qd_clip<CR>

let mapleader=","
let g:bufExplorerSplitBelow=1

nmap    <F11>  :w<CR>:bdelete<CR>
nmap    <F6>  :w<CR>
nmap    <F3> :Explore<CR>

nmap    <F6> <c-w>_<c-w>\|
nmap    <F7> <c-w>=


map <C-J> <c-w>+
map <C-K> <c-W>-
map <C-H> <c-w><
map <C-L> <c-w>>
map <C-I> g<C-G>

nnoremap <D-Left> :tabprevious<CR>
nnoremap <D-Right> :tabnext<CR>

let g:netrw_hide = 1
let g:netrw_liststyle = 3
let g:netrw_sort_sequence = '*'
let g:sh_isk = &iskeyword
let g:launch_dir=getcwd ().'/'

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
    noremap <buffer> <c-l> <c-w>>
    noremap <buffer> <c-h> <c-w><
endfunction

map <leader>/ <plug>NERDCommenterToggle
imap <leader>/ <Esc><plug>NERDCommenterTogglei
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
nnoremap <Leader>ss :cexpr []<CR>:silent grep "<C-r><C-w>" * -r -i -a<CR>:cw<CR>:redraw!<CR>
nnoremap <Leader>e :edit <C-r>=launch_dir<CR><C-D>
nnoremap <Leader>f gf<CR>
nnoremap <Leader>t :vert term<CR>
" to vertical
nnoremap <Leader>wv :wincmd H<CR>
" to horizontal
nnoremap <Leader>wh :wincmd J<CR>
" rotate
nnoremap <Leader>wr :wincmd r<CR>

let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCustomDelimiters = {
    \ 'hocon': { 'left': '#', 'leftAlt': '//' },
    \ 'qonf': { 'left': '##', 'leftAlt': '#{', 'rightAlt': '#}' },
    \ 'html': {  'left': '<!-- ', 'right': '-->', 'leftAlt': '/*','rightAlt': '*/' },
    \ 'xhtml': {  'left': '<!-- ', 'right': '-->', 'leftAlt': '/*','rightAlt': '*/'},
    \}

" save cursor
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set foldmethod=indent
endif
