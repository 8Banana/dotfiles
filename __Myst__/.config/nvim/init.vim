call plug#begin('~/.config/nvim/bundle')

" Syntax Checking (Neomake)
Plug 'benekastah/neomake'

" Better Terminals (Neoterm)
Plug 'kassio/neoterm'

" EasyAlign
Plug 'junegunn/vim-easy-align'

" Surround
Plug 'tpope/vim-surround'

" Fugitive (git wrapper)
Plug 'tpope/vim-fugitive'

" Highlighted yank
Plug 'machakann/vim-highlightedyank'

" Targets
Plug 'wellle/targets.vim'

" Start page (Startify)
Plug 'mhinz/vim-startify'

" Colorscheme & Transparent Background
Plug 'chriskempson/base16-vim'
Plug 'miyakogi/seiya.vim'

" Status line (Airline)
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Auto-Completion (Deoplete)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'Shougo/deoplete-clangx'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'junegunn/fzf', { 'dir': '~/Applications/fzf', 'do': './install --all' }

" WebApi-vim (for rust.vim)
Plug 'mattn/webapi-vim'

" Autotag
Plug 'craigemery/vim-autotag'

" Customizable text objects (vim-textobj-user)
Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'
Plug 'glts/vim-textobj-comment'

" NERDTree
Plug 'scrooloose/nerdtree'

" Syntax plugins
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'cespare/vim-toml'
Plug 'dag/vim2hs', { 'for': 'haskell' }
Plug 'leafgarland/typescript-vim'
Plug 'leafo/moonscript-vim'
Plug 'pangloss/vim-javascript'
Plug 'rhysd/vim-crystal'
Plug 'rust-lang/rust.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'elixir-editors/vim-elixir'
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'

" Type in Tandem
"Plug 'typeintandem/nvim', { 'do': ':UpdateRemotePlugins' }

" Rainbow parenthesis
Plug 'junegunn/rainbow_parentheses.vim'

call plug#end()

" Enable filetype plugins, but disable automatic indenting.
" Some plugins are sneaky and pass through the cracks, like rust.vim
filetype plugin on
filetype indent off

" Enable syntax highlighting.
syntax on

" Set the encoding to UTF-8. I don't know why you'd want anything else.
set encoding=utf-8

" Make folds only show up if manually created.
" While foldmethod=syntax is pretty cool, it's also pretty slow, especially on
" large files.
set foldmethod=manual

" Colorscheme gubbins.
let base16colorspace=256
set background=dark
colorscheme base16-ocean

" Automaking is cool-io!
" I don't really feel the need to adjust this based on battery.
" \ 'TextChangedI': {},
call neomake#configure#automake({
\ 'TextChanged':  {},
\ 'InsertLeave':  {},
\ 'BufWritePost': {'delay': 0},
\ 'BufReadPost':  {},
\ }, 500)

augroup filetype_autocommands
    autocmd!

    " Use 2-space wide indents in these languages, as is convention.
    autocmd FileType lisp,clojure,ruby,crystal,haskell,yaml,dart 
        \ setlocal shiftwidth=2 softtabstop=2 tabstop=2

    " Because rust.vim likes to set smart indent.
    autocmd FileType rust setlocal nosmartindent
    autocmd BufWritePre *.rs silent! RustFmt

    autocmd FileType lisp,clojure,scheme,rust,javascript RainbowParentheses
augroup END

" TODO: Instead of just reading the templates, use a templating engine to add
" something like custom module names in Rust.
function! LoadTemplate(extension)
    try
        silent execute '0r ~/.config/nvim/templates/skeleton.' . a:extension
    catch
        return
    endtry

    " This only happens if a template was read, due to the "catch" above.
    normal Gddgg
endfunction

augroup templates
  autocmd!

  " When creating a new file, a template will be read from ~/.config/nvim/templates,
  " with the name format 'skeleton' + the extension of the current file.
  autocmd BufNewFile *.* call LoadTemplate(expand('<afile>:e'))
augroup END

" This is really useful when starting out with Vim to build up your muscle
" memory.
" It's useless after you get it ingrained, but I like keeping it in here as a
" testament of vim-fu.
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Have <Esc> work like it does in every other mode in terminal mode.
tnoremap <Esc> <C-\><C-n>

" Re-highlight the same area after indenting in visual mode
vnoremap < <gv
vnoremap > >gv

" Underline search results.
set hlsearch
highlight Search cterm=underline ctermfg=NONE ctermbg=NONE

" Turn on line numbers, but have them be relative to the current line.
" This is a matter of taste.
set number
set relativenumber

" This creates a filled-in column at 80 columns, that's meant to help with PEP8
" compliance and other things. I find it gets annoying with a transparent
" background.
" TODO: Turn this on conditionally if the background *isn't* transparent.
"set colorcolumn=80
"highlight ColorColumn ctermfg=NONE cterm=bold

" Shows some characters specially, mostly tabs and trailing spaces.
set listchars=tab:>-,trail:·,extends:>,precedes:<
set list
highlight SpecialKey cterm=bold ctermfg=NONE ctermbg=NONE

" Removes the annoying 'Do you want to read this file again?' prompt when
" running an external command.
set autoread

" Removes the really annoying 'smart' indent.
set nosmartindent

" Expand tabs into 4 spaces, like god wants.
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Wraps text at 80 columns. This gets disabled automatically when writing
" source code, but still wraps comments. Even this one!
set tw=79
set nowrap
set fo-=t

" Prevents annoying clutter of backup/swap files
set backupdir=~/.config/nvim/backup/
set directory=~/.config/nvim/swap/

" Allows mouse usage, I mostly use this with the scroll wheel rather than
" clicking.
set mouse=a

" Writes undoable actions to a file. Useful for undoing a change even if you
" exit vim.
set undodir=~/.config/nvim/undo/
set undofile

" Shows a command's effect as you type it
set inccommand=nosplit

set fillchars+=stl:\ ,stlnc:\   

" TODO: Instead of just not showing the preview window, close it once we do
" choose a completion.
set completeopt-=preview

" Plugin configuration.

" Use a new buffer for the plug updates window.
let g:plug_window = "enew"

" Airline
let g:airline_theme = 'base16'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Neoterm
let g:neoterm_default_mod = 'botright'

" Neomake

"" C++
let g:neomake_cpp_clang_args = ['-std=c++17', '-Wall', '-Wextra', '-Weffc++']
let g:neomake_cpp_enabled_makers = ['clang', 'clangtidy', 'cppcheck']

let g:neomake_c_clang_args = ['-std=c99', '-Wall', '-Wextra', '-Weffc++']

"" Python
let g:neomake_python_python_exe = 'python3.6'
let g:neomake_python_enabled_makers = ['flake8']

"" Shell
let g:neomake_sh_shellcheck_args = ['-fgcc']

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

"" C++
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.6/lib/libclang.so.1'
let g:deoplete#sources#clang#clang_header = '/usr/include/clang'

"" Rust
let g:deoplete#sources#rust#racer_binary=$HOME . '/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path=$HOME . '/Applications/rust/src'

" Startify
let g:startify_bookmarks = [ { 'C': '~/.config/nvim/init.vim' } ]

" Seiya (transparent background)
let g:seiya_auto_enable=1

" Language server
" CTRL-F: language server, langserver
set hidden
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'python': ['python3', '-m', 'pyls'],
    \ 'lua': ['lua-lsp'],
    \ 'c': ['cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"' . $HOME . '/.cache/cquery"}'],
    \ 'cpp': ['cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"' . $HOME . '/.cache/cquery"}'],
    \ }

"let g:LanguageClient_changeThrottle = 0.1

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap K :call LanguageClient#textDocument_hover()<CR>
nnoremap gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <F2> :call LanguageClient#textDocument_rename()<CR>

" NERDTree
map <C-n> :NERDTreeToggle<CR>
