"set guifont=Monospace\ 11
set guifont=Source\ Code\ Pro\ Regular\ 12"
"set guifont=Input\ Mono\ 12"

" vim-plug {{{
call plug#begin()

" color scheme
Plug 'altercation/vim-colors-solarized'

" syntax highlighting
Plug 'peterhoeg/vim-qml'
Plug 'artoj/qmake-syntax-vim'
Plug 'octol/vim-cpp-enhanced-highlight'

" auto complete
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --tern-completer' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'nvie/vim-flake8'
"Plug 'davidhalter/jedi-vim'
"Plug 'ervandew/supertab'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

" navigation/search file
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'rking/ag.vim'
"Plug 'dkprice/vim-easygrep'

" git management plugin
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" time tracking
Plug 'wakatime/vim-wakatime'

call plug#end()
" }}} vim-plug

" TODO Check these
"Plugin 'alfredodeza/coveragepy.vim'
"Plugin 'ntpeters/vim-better-whitespace'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'pylint-mode'


" Fix jedi auto-completion with anaconda
" https://github.com/Valloric/YouCompleteMe/issues/1241
" Workaround from
" https://github.com/Valloric/ycmd/pull/295#issuecomment-174221840
let g:ycm_python_binary_path=substitute(system("which python"), "\n$", "", "")
let $PYTHONPATH=getcwd() . ":" . $PYTHONPATH


" Colors {{{
syntax enable                " enable syntax processing
colorscheme solarized
set background=dark
call togglebg#map("<F5>")
" }}} Colors


" Spaces & Tabs {{{
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
" }}} Spaces & Tabs


" Search {{{
set incsearch       " search as characters are entered
set hlsearch        " highlight matches
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is lower case

" set Ag as the grep command
if executable('ag')
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
endif

" move through grep results
nmap <silent> <right> :cnext<CR>
nmap <silent> <left> :cprev<CR>
" }}} Search


" Keyboard mappings {{{
map <silent> <C-n> :NERDTreeToggle<CR>
nnoremap <F2> :set nonumber!<CR>

" Buffers handling
nnoremap <tab> :bn<CR>        " Next
nnoremap <s-tab> :bp<CR>      " Previous
nnoremap <leader>bd :bd<CR>   " Delete

" fzf, hijacks Ctrl-P
"nnoremap <c-p> :FZF<CR>
" }}}


"highlight clear SignColumn
highlight link GitGutterAdd DiffAdd
highlight link GitGutterChange DiffChange
highlight link GitGutterDelete DiffDelete
highlight link GitGutterAdd DiffAdd

" diff options, also used by fugitive. filler is default value
set diffopt=filler,vertical

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Functions {{{
" Remove trailing whitespaces on save
match ErrorMsg '\s\+$'
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd BufWritePre * :call TrimWhiteSpace()

" Check python files on save
" https://github.com/nvie/vim-flake8
autocmd BufWritePost *.py call Flake8()
" }}}
