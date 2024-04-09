set tabstop=4
set shiftwidth=4
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set clipboard=unnamed
set textwidth=110
set ignorecase
set smartcase
set tabpagemax=100
set regexpengine=0

" This is only necessary if you use "set termguicolors".
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

"====================================================
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'morhetz/gruvbox'
Plug 'kamykn/spelunker.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'
" Plug 'Lokaltog/vim-powerline'
Plug 'cormacrelf/vim-colors-github'
Plug 'arzg/vim-colors-xcode'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'shime/vim-livedown'
Plug 'preservim/vim-pencil'
Plug 'tpope/vim-vinegar'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()
"====================================================

set wrap
set hlsearch

" remove the delay of ^[O (Esc + O)
set timeout timeoutlen=5000 ttimeoutlen=100

" disable auto new line at end of file
set nofixendofline

"-- FOLDING --
"set foldmethod=syntax "syntax highlighting items specify folds
"set foldcolumn=1 "defines 1 col at window left, to indicate folding
"let javaScript_fold=1 "activate folding by JS syntax
"set foldlevelstart=99 "start file with all folds opened

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=manual
    au BufWinEnter * normal zR
augroup END

" fold block code around {}
nnoremap <leader>fcb zfa}

" save fold automatically when leave and load it when open
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

com! FormatJSON $!python -m json.tool

" map FZF to ctrl+p
nnoremap <silent> <C-p> :FZF<CR>

" FZF config
let g:fzf_layout = { 'down': '40%' }

let mapleader = ","
" laziness
nnoremap ; :
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
inoremap jk <esc>

" toggle highlighting the cursor line
nnoremap <leader>, :set cursorline!<cr>

" grep search recursively under the current folder for the current word
nnoremap <leader>grs :grep -rn <cword> ./src<cr>
nnoremap <leader>grc :grep -rn <cword> ./src/sap.ui.core/src<cr>
nnoremap <leader>grr :grep -rn <cword> .<cr>

" Move blocks in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" map the delete, yank, paste to the 'p' register
vnoremap <leader>y "py
nnoremap <leader>p "pp
nnoremap <leader>P "pP
vnoremap <leader>d "pd

" comment out the current line
nnoremap <leader>/ 0wi// <esc>

" reselect last pasted (or changed) text
noremap gV `[v`]

" select code block starting from the current line
nnoremap <leader>vb <S-v>$%

" comment selected lines
nnoremap <leader>bc :call Toggle()<CR>

function! Comment()
	let ft = &filetype
	if ft == 'php' || ft == 'ruby' || ft == 'sh' || ft == 'make' || ft == 'python' || ft == 'perl'
		silent s/^/\#/
	elseif ft == 'javascript' || ft == 'c' || ft == 'cpp' || ft == 'java' || ft == 'objc' || ft == 'scala' || ft == 'go'
		silent s:^:\/\/:g
	elseif ft == 'tex'
		silent s:^:%:g
	elseif ft == 'vim'
		silent s:^:\":g
	endif
endfunction

function! Uncomment()
	let ft = &filetype
	if ft == 'php' || ft == 'ruby' || ft == 'sh' || ft == 'make' || ft == 'python' || ft == 'perl'
		silent s/^\#//
	elseif ft == 'javascript' || ft == 'c' || ft == 'cpp' || ft == 'java' || ft == 'objc' || ft == 'scala' || ft == 'go'
		silent s:^\/\/::g
	elseif ft == 'tex'
		silent s:^%::g
	elseif ft == 'vim'
		silent s:^\"::g
	endif
endfunction

function! Toggle()
	try
		call Uncomment()
	catch
		call Comment()
	endtry
endfunction


" Goyo enter and leave autocmd
fun! MDEdit()
	augroup numbertoggle
		autocmd!
	augroup END
	Goyo 50%
	"let g:seoul256_srgb = 1
	"colorscheme seoul256
endfunction

fun! MDEditOff()
	augroup numbertoggle
		autocmd!
		autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
		autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
	augroup END
	Goyo!
	"colorscheme gruvbox
	PencilOff
endfunction

com! MDEdit call MDEdit()
com! MDEditOff call MDEditOff()

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init({'wrap': 'soft'})
  autocmd FileType text         call pencil#init()
augroup END

" gitgutter diff with 'master' and 'head'
"nmap <leader>dm let g:gitgutter_diff_base = "master" | GitGutter
"nmap <leader>db let g:gitgutter_diff_base = "head" | GitGutter
"nmap <leader>dp let g:gitgutter_diff_base = "HEAD~1" | GitGutter

set background=dark
set t_Co=256
colorscheme gruvbox
let g:gruvbox_contrast_light='soft'

let g:airline_theme='gruvbox'

"====[ Make the 81st column stand out ]====================
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

"=====[ Highlight matches when jumping to next ]=============

	highlight WhiteOnRed ctermbg=red ctermfg=white
    " This rewires n and N to do the highlighing...
    nnoremap <silent> n   n:call HLNext(0.1)<cr>
    nnoremap <silent> N   N:call HLNext(0.1)<cr>
	
    " OR ELSE just highlight the match in red...
    function! HLNext (blinktime)
        let [bufnum, lnum, col, off] = getpos('.')
        let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
        let target_pat = '\c\%#\%('.@/.'\)'
        let ring = matchadd('WhiteOnRed', target_pat, 101)
        redraw
        exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
        call matchdelete(ring)
        redraw
    endfunction
	
"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======

    exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
    set list

" for tmuxline + vim-airline integration
let g:airline#extensions#tmuxline#enabled = 0
" start tmuxline even without vim running
" let airline#extensions#tmuxline#snapshot_file = "~/.tmuxline.config"

" reduce the refresh time for vimgutter
set updatetime=800

" use fzf in vim
set rtp+=/usr/local/opt/fzf
" remove trailing while space
" autocmd FileType js,json autocmd BufWritePre <buffer> %s/\s\+$//e

" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Spellcheck type: (default: 1)
" 1: File is checked for spelling mistakes when opening and saving. This
" may take a bit of time on large files.
" 2: Spellcheck displayed words in buffer. Fast and dynamic. The waiting time
" depends on the setting of CursorHold `set updatetime=1000`.
let g:spelunker_check_type = 2
