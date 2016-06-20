""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""

" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
" set the runtime path to include Vundle and initialize it
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
set rtp+=~/.fzf

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" colorschemes
Plugin 'flazz/vim-colorschemes'
Plugin 'xolox/vim-colorscheme-switcher'
Plugin '0ax1/lxvc'
Plugin 'chriskempson/base16-vim'

" main plugins
Plugin 'Valloric/YouCompleteMe'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'wellle/targets.vim'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'mbbill/undotree'
Plugin 'vim-scripts/grep.vim'
Plugin 'vim-scripts/CSApprox'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'scrooloose/syntastic.git'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-vinegar'
Plugin 'henrik/vim-indexed-search'
Plugin 'jiangmiao/auto-pairs'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
Plugin 'unblevable/quick-scope'
Plugin 'powerline/powerline'
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'junegunn/vim-easy-align'
Plugin 'tpope/vim-repeat'
Plugin 'Shougo/neocomplete.vim'
Plugin 'terryma/vim-expand-region'
Plugin 'gilgigilgil/anderson.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'godlygeek/tabular'
Plugin 'matze/vim-move'
Plugin 'tobyS/vmustache'
Plugin 'tpope/vim-obsession'
Plugin 'dhruvasagar/vim-prosession'
Plugin 'tacahiroy/ctrlp-funky'
"Plugin 'Shougo/vimshell.vim'
Plugin 'Shougo/vimproc'
Plugin 'benmills/vimux'
Plugin 'ervandew/supertab'

Plugin 'junegunn/goyo.vim'
"Plugin 'KabbAmine/yowish.vim'

""" LANGUAGES
Plugin 'sheerun/vim-polyglot'
Plugin 'adoy/vim-php-refactoring-toolbox'
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'tobyS/pdv'
Plugin 'fatih/vim-go'
Plugin 'mattn/emmet-vim'
Plugin 'pearofducks/ansible-vim'
Plugin 'janko-m/vim-test'
Plugin 'tpope/vim-dispatch'
Plugin 'rust-lang/rust.vim'

" All Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
filetype plugin on


""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = "\<Space>"

set encoding=utf-8
set smarttab " respect tabstop, shiftwidth and softtabstop
set tabstop=4 " tabs are 4 spaces
set shiftwidth=4 " number of spaces to use for indent
set softtabstop=4 " edit as if the tabs are 4 chars
set expandtab " use tabs, no spaces

set autoindent " automatically indent files
set copyindent " copy last indent when autoindenting

" show the current line number and relative numbers from there
set number

set history=1000 " save up to 1000 histories

set backspace=indent,eol,start " make backspace behave sanely
set showmode " show the current mode
set autoread " detect when a file is changed
set incsearch " search incrementaly
set hlsearch " Enable search highlighting
set ignorecase " ignore case when searching
set smartcase " but respect it if the expression contains a capital letter
set vb " don't beep, flash
set nowrap " don't wrap lines
set ruler " show the current row and position
set cul "highlights current line
set undofile " use files for undo
set showmatch " show matching braces
set mat=2 " how many tenths of a second to blink
set magic " magic for regex
set ttyfast " faster redrawing
set cursorline
set mouse=a

" Save swp, backups and undos to custom folders
set backupdir=~/.vim/backup_files//
set directory=~/.vim/swap_files//
set undodir=~/.vim/undo_files//
set pastetoggle=<F2>

" colors
syntax enable
let base16colorspace=256  " Access colors present in 256 colorspace"
let g:hybrid_use_Xresources = 1
set background=dark
colorscheme base16-ocean

" Disable Background Color Erase (BCE) so that color schemes work properly
" when Vim is used inside tmux and GNU screen.
if exists('$TMUX')
	set t_ut=
endif

" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden

set tags=~/.vim/tags/mce,~/.vim/tags/lumen,tags,~/.vim/tags/master

" file type specific settings
if has('autocmd') && !exists('autocommands_loaded')
    let autocommands_loaded = 1
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType html setlocal ts=4 sts=4 sw=4 noexpandtab indentkeys-=*<return>
    autocmd FileType *.md.js :call SyntasticReset<cr>
    autocmd FileType markdown,textile setlocal textwidth=0 wrapmargin=0 wrap spell
    autocmd FileType .xml exe ":silent %!xmllint --format --recover - 2>/dev/null"
    autocmd FileType crontab setlocal nobackup nowritebackup

    " automatically resize panes on resize
    autocmd VimResized * exe 'normal! \<c-w>='
    "autocmd BufWritePost .vimrc source %
    "autocmd BufWritePost .vimrc.local source %
    " save all files on focus lost, ignoring warnings about untitled buffers
    autocmd FocusLost * silent! wa

    autocmd BufNewFile,BufRead *.ejs set filetype=html
    autocmd BufNewFile,BufRead *.ino set filetype=c
    autocmd BufNewFile,BufRead *.svg set filetype=xml

    " make quickfix windows take all the lower section of the screen when there
    " are multiple windows open
    autocmd FileType qf wincmd J

    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'json=javascript', 'stylus', 'html']

    " autocmd! BufEnter * call ApplyLocalSettings(expand('<afile>:p:h'))

	autocmd BufWritePre * StripWhitespace

	augroup reload_vimrc " {
		autocmd!
		autocmd BufWritePost $MYVIMRC source $MYVIMRC | AirlineRefresh
	augroup END " }
endif

""""""""""""""""""""""""""""""""""""""""""""""""
" Copying
""""""""""""""""""""""""""""""""""""""""""""""""
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

" Auto set paste mode
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations
""""""""""""""""""""""""""""""""""""""""""""""""
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
abbr funciton function
abbr teh the
abbr tempalte template
abbr fitler filter
abbr tihs this
abbr pubic public

""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

""" Move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" go to next buffer
map <leader>n :bn<CR>
" go to previous buffer
map <leader>p :bp<CR>
" delete current buffer
map <leader>d :bd<CR>


" Stop the bullshit
noremap K <nop>
noremap Q <nop>
map q: :q

" Close quickfix window
nnoremap <leader>q :ccl<Cr>
nnoremap <leader>z :cope<Cr>

" Saving and exiting
nnoremap <leader>s :w<CR>
nnoremap <leader>S :wq<CR>
nnoremap <leader>Q :q!<CR>

" Reload vimrc
nnoremap <leader>vr :so ~/.vimrc<CR>

" Remove highlights
nnoremap <leader>c :nohl<CR>

" Open Undotree
nnoremap <F5> :UndotreeToggle<CR>

" Open Tagbar
nmap <F6> :TagbarToggle<CR>

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Insert new line and stay on insert mode
nmap oo :pu_<Cr>k
nmap OO :pu!_<Cr>j

nnoremap <Enter> :

" provide hjkl movements in Insert mode via the <Alt> modifier key
inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l

""""""""""""""""""""""""""""""""""""""""""""""""
" Git
""""""""""""""""""""""""""""""""""""""""""""""""
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

set diffopt+=vertical

" Netrw
" ==============================================
"let g:netrw_liststyle=3
"nmap <F7> :Explore<Cr>

""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""

" NERD Tree
" =============================================

" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
nmap <S-F7> :NERDTreeClose<CR>

" Close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=0

" Show hidden files in NERDTree
let NERDTreeShowHidden=1

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
                   \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
                   \ '\.embed\.manifest$', '\.embed\.manifest.res$',
                   \ '\.intermediate\.manifest$', '^mt.dep$', '^.git$', '^.idea$' ]


let g:SuperTabDefaultCompletionType = ""

""" auto-open NerdTree when no file is specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" NerdTree git
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \
    \}


" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')

" Airline
" =============================================
set laststatus=2

"if !exists("g:airline_symbols")
  "let g:airline_symbols = {}
"endif

"let g:airline_theme="raven"
"let g:airline_powerline_fonts=1
"let g:airline#extensions#branch#empty_message  =  "no .git"
"let g:airline#extensions#whitespace#enabled    =  0
"let g:airline#extensions#syntastic#enabled     =  1
"let g:airline#extensions#tabline#enabled       =  1
"let g:airline#extensions#tabline#tab_nr_type   =  1 " tab number
"let g:airline#extensions#tabline#fnamecollapse =  1 " /a/m/model.rb
"let g:airline#extensions#hunks#non_zero_only   =  1 " git gutter

let g:loaded_airline_themes=1
let g:airline_theme = 'base16_ocean'
set noshowmode
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
" Automatically populate the symbols dictionary with the powerline symbols.
let g:airline_powerline_fonts = 1
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
"let g:airline_left_alt_sep = '⎢'
"let g:airline_right_alt_sep = '⎟'
"let g:airline_mode_map = {
			"\ '__' : '-',
			"\ 'n'  : 'N',
			"\ 'i'  : 'I',
			"\ 'R'  : 'R',
			"\ 'c'  : 'C',
			"\ 'v'  : 'V',
			"\ 'V'  : 'V-L',
			"\ '' : 'V',
			"\ 's'  : 'S',
			"\ 'S'  : 'S',
			"\ '' : 'S',
		"\ }
" Enable only those extensions
" EXTENSIONS
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
" Show splits and tab number in tabline
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#buffer_min_count = 2
" let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#show_splits = 0
" Formatting of the whitespace warning messages
" let g:airline#extensions#whitespace#trailing_format = 't[%s]'
" let g:airline#extensions#whitespace#mixed_indent_format = 'm[%s]'
" let g:airline#extensions#whitespace#long_format = 'l[%s]'
" let g:airline#extensions#whitespace#mixed_indent_file_format = 'mf[%s]'

" Syntastic
" =============================================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" QuickScope
" =============================================

""" Only enable the quick-scope plugin highlighting when using the f/F/t/T movements
function! Quick_scope_selective(movement)
    let needs_disabling = 0
    if !g:qs_enable
        QuickScopeToggle
        redraw
        let needs_disabling = 1
    endif

    let letter = nr2char(getchar())

    if needs_disabling
        QuickScopeToggle
    endif

    return a:movement . letter
endfunction

let g:qs_enable = 0

nnoremap <expr> <silent> f Quick_scope_selective('f')
nnoremap <expr> <silent> F Quick_scope_selective('F')
nnoremap <expr> <silent> t Quick_scope_selective('t')
nnoremap <expr> <silent> T Quick_scope_selective('T')
vnoremap <expr> <silent> f Quick_scope_selective('f')
vnoremap <expr> <silent> F Quick_scope_selective('F')
vnoremap <expr> <silent> t Quick_scope_selective('t')
vnoremap <expr> <silent> T Quick_scope_selective('T')

let g:qs_first_occurrence_highlight_color = 155
let g:qs_second_occurrence_highlight_color = 81

" CtrlP
" =============================================
let g:ctrlp_map = "<c-p>"
nnoremap <leader>bp :CtrlPMRU<CR>
nnoremap <leader>t :CtrlPBuffer<CR>
let g:ctrlp_follow_symlinks=1
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_working_path_mode = 0
"set wildignore+=*/vendor/**,*/.git/*,*/tests/*

" Give CtrlP some speed!
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif


" FZF
" ==============================================
nnoremap <Leader>f :FZF <Cr>

function! s:update_fzf_colors()
  let rules =
  \ { 'fg':      [['Normal',       'fg']],
    \ 'bg':      [['Normal',       'bg']],
    \ 'hl':      [['Comment',      'fg']],
    \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
    \ 'bg+':     [['CursorColumn', 'bg']],
    \ 'hl+':     [['Statement',    'fg']],
    \ 'info':    [['PreProc',      'fg']],
    \ 'prompt':  [['Conditional',  'fg']],
    \ 'pointer': [['Exception',    'fg']],
    \ 'marker':  [['Keyword',      'fg']],
    \ 'spinner': [['Label',        'fg']],
    \ 'header':  [['Comment',      'fg']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && code > 0
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
        \ empty(cols) ? '' : (' --color='.join(cols, ','))
endfunction

augroup _fzf
  autocmd!
  autocmd ColorScheme * call <sid>update_fzf_colors()
augroup END

let g:fzf_layout = { 'down': '~60%' }

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap  <Leader>bf :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

" UltiSnips
" =============================================
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical" " If you want :UltiSnipsEdit to split your window.

" EasyAlign
" =============================================
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)"

" region expand
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" BufExplorer
" =============================================
let g:bufExplorerFindActive=0 " fix bufexplorer bug with hidden

" Neocomplete
" =============================================
"let g:acp_enableAtStartup = 1
"let g:neocomplete#enable_at_startup = 1
"let g:SuperTabDefaultCompletionType = ""

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

" Auto pairs
"let g:AutoPairsShortcutFastWrap = "<leader>w"

" Vim-move
" =============================================
let g:move_key_modifier = 'C'

" Rust
"===========================================
let g:ycm_rust_src_path = '~/sources/rust/src/'
nnoremap <Leader>g :YcmCompleter GoTo<CR>

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"
" this mapping Enter key to <C-y> to chose the current highlight item
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" PHP refactor
" =============================================
let g:vim_php_refactoring_default_property_visibility = 'protected'
let g:vim_php_refactoring_default_method_visibility = 'protected'
let g:vim_php_refactoring_auto_validate_visibility = 0

" Vim Session
" ============================================
let g:session_autoload = 'no'

" Pdv
" ============================================
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <buffer> <C-c> :call pdv#DocumentWithSnip()<CR>

" ctrlp funky
nnoremap <Leader>fu :CtrlPFunky<Cr>

" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

" Vim shell
" ===========================================
nnoremap <leader>sh :VimShellPop<Cr>
let g:vimshell_popup_command = 'belowright sp'
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt = '% '

" Vim test
" ============================================
nmap <silent> <leader>tt :TestNearest<CR>
let test#strategy = "vimux"
let test#php#phpunit#executable = '/usr/local/bin/phpunit'

" Phpcomplete
let g:phpcomplete_parse_docblock_comments = 1
let g:phpcomplete_mappings = {
  \ 'jump_to_def': '<C-G>',
  \ }
" Functions
" ============================================
function! AddNamespace()
	execute "norm ggA ocns\<Tab>"
endfunction

nnoremap <leader>ns :call AddNamespace()<CR>

function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
"autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
"autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
"

map <Leader>ut :VimuxRunCommand("phpunit")<CR>
map <Leader>et :VimuxRunCommand("phpunit --stop-on-error")<CR>

function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

" Env vars
"===========================================
let $MCE = 'plugins/mce/'
let $MUSER = 'plugins/mce/user'
