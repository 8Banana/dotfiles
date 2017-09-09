let g:python3_host_prog = "/home/boring/bin/python3"

call plug#begin('~/.config/nvim/bundle')

Plug 'chriskempson/base16-vim'
Plug 'miyakogi/seiya.vim'

Plug 'https://github.com/rhysd/vim-crystal.git'

Plug 'benekastah/neomake'
Plug 'junegunn/vim-easy-align'
Plug 'kassio/neoterm'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'mhinz/vim-startify'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
"Plug 'landaire/deoplete-d'
"Plug 'sebastianmarkow/deoplete-rust'

Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'
Plug 'glts/vim-textobj-comment'

Plug 'leafo/moonscript-vim'
Plug 'pangloss/vim-javascript'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'dag/vim2hs', { 'for': 'haskell' }
Plug 'leafgarland/typescript-vim'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'

Plug 'scrooloose/nerdtree'

call plug#end()

filetype plugin on
filetype indent off
syntax on
set encoding=utf-8
set foldmethod=manual  " TODO: Make syntax folding faster.

if has("termguicolors")     " set true colors
    "set t_8f=[38;2;%lu;%lu;%lum
    "set t_8b=[48;2;%lu;%lu;%lum
    "set termguicolors
endif

let base16colorspace=256
set background=dark
colorscheme base16-ocean

augroup plugin_autocommands
    autocmd!
    autocmd BufWritePost,BufReadPost * Neomake
    "autocmd TermOpen * set bufhidden=hide
augroup END

augroup filetype_autocommands
    autocmd!
    autocmd FileType javascript,lisp,clojure,ruby,crystal,haskell,yaml setlocal shiftwidth=2 softtabstop=2 tabstop=2

    " Because rust.vim is dumb
    autocmd FileType rust setlocal nosmartindent
augroup END

augroup autowrite
    autocmd!
    autocmd InsertLeave,FocusLost * if bufname("%") != "" | update | endif
augroup END

function LoadTemplate(extension)
    try
        silent execute '0r ~/.config/nvim/templates/skeleton.' . a:extension
    catch
        return
    endtry

    " This only happens if a template was read.
    normal Gddgg
endfunction

augroup templates
  autocmd!
  autocmd BufNewFile *.* call LoadTemplate(expand('<afile>:e'))
augroup END

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

tnoremap <Esc> <C-\><C-n>

vnoremap < <gv
vnoremap > >gv

highlight Search cterm=underline ctermfg=NONE ctermbg=NONE

set hlsearch

set number
set relativenumber

"set colorcolumn=80
"highlight ColorColumn ctermfg=NONE cterm=bold

set listchars=tab:>-,trail:·,extends:>,precedes:<
set list
highlight SpecialKey cterm=bold ctermfg=NONE ctermbg=NONE

set autoread

set nosmartindent

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set tw=79
set nowrap
set fo-=t

set backupdir=~/.config/nvim/backup/
set directory=~/.config/nvim/swap/

set mouse=a

let g:plug_window = "enew"

set fillchars+=stl:\ ,stlnc:\   
"set laststatus=2
let g:airline_theme = 'base16'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:neomake_cpp_clang_args = ['-std=c++1z', '-Wall', '-Wextra', '-Weffc++']
let g:neomake_cpp_enabled_makers = ['clang', 'clangtidy', 'cppcheck']

let g:neomake_c_clang_args = ['-std=c99', '-Wall', '-Wextra', '-Weffc++']

let g:neomake_python_python_exe = 'python3'

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.6/lib/libclang.so.1'
let g:deoplete#sources#clang#clang_header = '/usr/include/clang'

let g:deoplete#sources#rust#racer_binary='/home/boring/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/boring/Applications/rust/src'

set completeopt-=preview

let g:startify_bookmarks = [ { 'C': '~/.config/nvim/init.vim' } ]

let g:seiya_auto_enable=1

map <C-n> :NERDTreeToggle<CR>
