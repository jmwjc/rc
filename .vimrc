set encoding=utf-8
" set path
let $PATH=$PATH . ':/opt/homebrew/bin'

call plug#begin('~/.vim/plugged')
" colorscheme
Plug 'arcticicestudio/nord-vim'
    let g:nord_cursor_line_number_background=1
    let g:nord_bold=1
    let g:nord_italic=1
    let g:nord_italic_comments=1
    let g:nord_underline=1

" status bar
Plug 'itchyny/lightline.vim'
    let g:lightline = {
        \ 'colorscheme': 'nord',
        \ }
    set laststatus=2

" focus mode
" `:Goyo`: Toggle goyo
" `:Goyo!`: Turn goyo off
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
    let g:limelight_conceal_ctermfg = 'DarkGray'

" NerdTree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" floder tree
" if has('nvim')
"     Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"     Plug 'Shougo/defx.nvim'
"     Plug 'roxma/nvim-yarp'
"     Plug 'roxma/vim-hug-neovim-rpc'
" endif

" fuzzy mode
"Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

" indent line
Plug 'nathanaelkane/vim-indent-guides'
    let g:indent_guides_enable_on_vim_startup = 1    
    let g:indent_guides_guide_size = 1

" auto align
" :Tabularize /<notion><CR>
Plug 'godlygeek/tabular'

" markdown support
Plug 'plasticboy/vim-markdown'
    let g:vim_markdown_math = 1
    "let g:vim_markdown_edit_url_in = 'tab'
" markdwon criticmarkup support
" place cursor inside the annotation and then execute:
" :Critic accept
" :Critic reject
" Plug 'vim-pandoc/vim-criticmarkup'
Plug 'mattly/vim-markdown-enhancements'

" snippets
Plug 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger = '<Tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
    let g:UltiSnipsEditSplit="vertical"
    if has('nvim')
        let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
    endif 

" tex support
" setup: -h vimtex-faq-zathura-macos
" pip3 install neovim-remote
Plug 'lervag/vimtex'
    " block $$...$$
    syn region math start=/\$\$/ end=/\$\$/
    " inline math
    syn match math '\$[^$].\{-}\$'
    " actually highlight the region we defined as "math"
    hi link math Statement
    let g:tex_flavor='latex'
    let g:vimtex_view_general_viewer = 'skim'
    let g:vimtex_view_method='skim'
    let g:vimtex_compiler_progname = 'nvr'
    let g:vimtex_quickfix_mode=0
    let g:vim_syntax_conceal_disable=1
    "set conceallevel=2
    "let g:tex_conceal='abdmg'

" multi cursors
" `Ctrl-n`: select words
" `n/N`: get next/previous occurrence
" `[/]`: select next/previous cursor
" `q/Q`: skip/remove current and get next occurrence
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" homepage
Plug 'mhinz/vim-startify'

" git supoort
Plug 'tpope/vim-fugitive'

" auto pairs
Plug 'jiangmiao/auto-pairs'
    let g:AutoPairsFlyMode = 1
    let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''", '$':'$', '$$':'$$'}

" table mode
" using `||`/`__` to quickly enble/disable table mode in insert mode
" In the second line, enter | twice. The plugin will write a properly formatted horizontal line.
Plug 'dhruvasagar/vim-table-mode'
    function! s:isAtStartOfLine(mapping)
        let text_before_cursor = getline('.')[0 : col('.')-1]
        let mapping_pattern = '\V' . escape(a:mapping, '\')
        let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
        return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
    endfunction
    inoreabbrev <expr> <bar><bar>
              \ <SID>isAtStartOfLine('\|\|') ?
              \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
    inoreabbrev <expr> __
              \ <SID>isAtStartOfLine('__') ?
              \ '<c-o>:silent! TableModeDisable<cr>' : '__'

" autocomplete
" requirement: python3
" pip3 install --user --upgrade pynvim
" if has('nvim')
"     Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"     Plug 'Shougo/deoplete.nvim'
"     Plug 'roxma/nvim-yarp'
"     Plug 'roxma/vim-hug-neovim-rpc'
" endifkkk
"     let g:deoplete#enable_at_startup = 1

Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " texlab install by homebrew: brew install texlab
    let g:coc_global_extensions = ['coc-markdownlint', 'coc-texlab', 'coc-snippets', 'coc-json', 'coc-dictionary', 'coc-word', 'coc-emoji']

" thesaurus
" "mthesaur_txt" querys from `mthesaur.txt`. For this backend to work,be sure to download the file from [gutenberg.org](http://www.gutenberg.org/files/3202/files/) and place it under "~/.vim/thesaurus".
Plug 'ron89/thesaurus_query.vim'
    let g:tq_enabled_backends = ["paper_md"]

" yank
" go to the end of the file and press p
" press <C-P> to move backwards through the yankring
Plug 'vim-scripts/YankRing.vim'
    let g:yankring_history_dir = '$VIM'

" insert bibtex
" Plug 'lionawurscht/deoplete-biblatex'

call plug#end()

" settings
" theme
colorscheme nord
set gfn=Menlo:h16 " set font for en
set gfw=PingFangSC-Medium:h16 " set font for cn
" tab spaces
set softtabstop=4
set shiftwidth=4
set expandtab
" indent
set autoindent
set smartindent
" number and cursor
set number
set relativenumber
set rnu
set cursorline
set showcmd
set showmatch
autocmd FileType latex,tex,md,markdown setlocal spell
set backspace=indent,eol,start "set backspace option
set iskeyword+=_,$,@,%,#,-,.
set ignorecase
set smartcase
set mouse=a
syntax on

" copy
set clipboard=unnamed

" save
set nobackup
set nowritebackup
set noswapfile
set autoread
set autowrite

" folding
set foldmethod=indent
" set foldopen=all
nnoremap <space> za

" maintain cursor at middle of screen
"nnoremap <esc> :noh<cr>zz
"nnoremap <esc> zz
"noremap j gjzz
"noremap k gkzz

" jump between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

let mapleader=','

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif
