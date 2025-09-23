call plug#begin()

"""""""""""""""""""
" Settings
"""""""""""""""""""
" Sensible
Plug 'tpope/vim-sensible'

" Readline key bindings
" Plug 'tpope/vim-rsi'

"""""""""""""""""""
" Appearance
"""""""""""""""""""
" Theme
"Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sainnhe/sonokai'
let g:sonokai_style = 'default'

" Devicons
"Plug 'ryanoasis/vim-devicons'

" Airline
"Plug 'vim-airline/vim-airline'
"let g:airline#extensions#tabline#enabled = 1

" Tmux line
"Plug 'edkolev/tmuxline.vim'
"let g:tmuxline_powerline_separators = 0

" Show numbers.vim
"Plug 'myusuf3/numbers.vim'

" Git Gutter
"Plug 'airblade/vim-gitgutter'

" Indent Guides
"Plug 'nathanaelkane/vim-indent-guides'
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_guide_size = 1

"""""""""""""""""""
" Languages
"""""""""""""""""""
" Vim Polyglot (many languages support)
Plug 'sheerun/vim-polyglot'

" Vim CSS Color
Plug 'ap/vim-css-color'

"""""""""""""""""""
" Resources
"""""""""""""""""""
" Copy/Paste from clipboard
"Plug 'christoomey/vim-system-copy'

" Tools for writers
"Plug 'reedes/vim-pencil'
"let g:pencil#wrapModeDefault = 'soft'
"nnoremap <silent> Q gqap
"Plug 'reedes/vim-lexical'
"let g:lexical#spelllang = ['en_us', 'pt_br',]
"let g:lexical#spellfile = ['~/.config/vim/spell/en.utf-8.add',
"                        \ '~/.config/vim/spell/pt.utf-8.add',]
"Plug 'dbmrq/vim-ditto'
"augroup writerTools
"  autocmd!
"  autocmd FileType markdown,mkd call pencil#init()
"                            \ | call lexical#init()
"                            \ | DittoOn
"augroup END

" Repeat commands with dot '.'
Plug 'tpope/vim-repeat'

" Fuzzy finder
"Plug 'junegunn/fzf', {
"      \ 'dir': expand('$XDG_CACHE_HOME') . '/fzf',
"      \ 'do': './install --all --xdg --no-bash --no-fish'
"      \}

" NERDTree
Plug 'preservim/nerdtree'
map <C-e> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeChDirMode = 0
let g:NERDTreeMouseMode = 2
let g:NERDTreeKeepTreeInNewTab = 1
let g:NERDTreeIgnore=['^\.git|node_modules$']

" Vim Commentary gc
Plug 'tpope/vim-commentary'

" Vim Editor Config
Plug 'editorconfig/editorconfig-vim'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Highlight yank
Plug 'machakann/vim-highlightedyank'

" Easy Motion
Plug 'easymotion/vim-easymotion'

" Surround
Plug 'tpope/vim-surround'

" Vim buffer bye
Plug 'moll/vim-bbye'

" Show possible key bindings
Plug 'liuchengxu/vim-which-key'

" Asynchronous Lint Engine
"Plug 'dense-analysis/ale'
"let g:ale_enabled = 1
"let g:ale_completion_enabled = 0
"let g:ale_lint_delay = 200
"let g:ale_lint_on_enter = 1
"let g:ale_lint_on_filetype_changed = 1
"let g:ale_lint_on_save = 1
"let g:ale_fix_on_save = 1
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
"let g:ale_fixers = {
"      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
"      \   'javascript': ['eslint', 'prettier'],
"      \   'javascriptreact': ['eslint', 'prettier'],
"      \   'typescript': ['eslint', 'prettier'],
"      \   'typescriptreact': ['eslint', 'prettier'],
"      \   'json': ['fixjson'],
"      \}
" let g:ale_fixers = {
      " \ 'javascript': ['prettier', 'eslint'],
      " \ 'php': ['phpcbf', 'php_cs_fixer'],
      " \ 'python': ['autopep8'],
      " \ 'sh': ['shfmt'],
      " \ 'go': ['gofmt']
      " \}

" COC LSP
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"source $MY_VIM_HOME/coc.vim

call plug#end() " END Plugins
