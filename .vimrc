filetype off
" Note: Skip initialization for vim-tiny or vim-small.
 if 0 | endif

 if has('vim_starting')
   if &compatible
     set nocompatible               " Be iMproved
   endif

   " Required:
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 " Required:
 call neobundle#begin(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'

 " My Bundles here:
 " Refer to |:NeoBundle-examples|.
 " Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }
NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', { 'autoload' : {
  \ 'insert' : 1,
  \ 'filetypes': 'ruby',
  \ }}
NeoBundleLazy 'marcus/rsense', {
      \ 'autoload': {
      \   'filetypes': 'ruby',
      \ },
      \ }
NeoBundle 'supermomonga/neocomplete-rsense.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'vim-scripts/cursoroverdictionary'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'kana/vim-operator-user'
NeoBundleLazy 'kana/vim-smartchr',  { 'autoload' : {'insert' : '1'} }
NeoBundleLazy 'kana/vim-smartinput', { 'autoload' : {'insert' : '1'} }
NeoBundle "tyru/caw.vim.git"
NeoBundle "OrangeT/vim-csharp"
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'
NeoBundle 'kitao/unity_dict' 
NeoBundle 'scrooloose/syntastic.git'
NeoBundle 'tpope/vim-endwise'
 " Required:
 filetype plugin indent on

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck

 call neobundle#end()
" Options "{{{1

" MyAutocmd
augroup MyAutoCmd
  autocmd!
augroup END

" ColorScheme
set t_Co=256
let g:hybrid_use_iTerm_colors = 1
colorscheme hybrid
syntax on
set background=dark

" Vim/Ruby
filetype indent on
filetype plugin on

" タブ幅リセット
au BufNewFile,BufRead * set tabstop=4 shiftwidth=4
au BufNewFile,BufRead *.rhtml set tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.rb set tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.erb set tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.yml set tabstop=2 shiftwidth=2
au User Rails* set fenc=utf-8

" backspaceで特殊文字を削除
set backspace=indent,eol,start

" clipboard連携
set clipboard=unnamed,autoselect

" tmp,swapファイル設定
set backup
set backupcopy&
set backupdir=~/tmp
set directory=~/swap

" history table
set history=100

set incsearch

" status line
set laststatus=2
let &statusline = ''
let &statusline .= '%<%f %h%m%r%w'
let &statusline .= '%='
let &statusline .= '[%{&l:fileencoding == "" ? &encoding : &l:fileencoding}]'
let &statusline .= '  %-14.(%l,%c%V%) %P'

set mouse=a
set ruler
set showcmd
set showmode
set updatetime=4000
set title
set titlestring=Vim:\ %f\ %h%r%m
set ttimeoutlen=50
set wildmenu

" 自動改行しない
set formatoptions=q

set visualbell
set vb t_vb=

" tab文字をスペースに変換する
set expandtab

" 挿入モードでカーソル形状を変更する
let &t_SI.="\e[6 q"
let &t_EI.="\e[2 q"
" 挿入モードを抜けるとIMEをオフにする
set imdisable
" カーソル形状がすぐに元に戻らないのでタイムアウト時間を調整
set ttimeoutlen=10
" 挿入モードを抜けた時にカーソルが見えなくなる現象対策(なぜかこれで治る)
inoremap <ESC> <ESC>

" Key Bindings "{{{1

" normal mode mappings "{{{2

" saves and quits 
nnoremap <silent> <Space>w :<C-u>update<CR>
nnoremap <silent> <Space>fw :<C-u>write!<CR>
nnoremap <silent> <Space>q :<C-u>quit<CR>
nnoremap <silent> <Space>aq :<C-u>quitall<CR>
nnoremap <silent> <Space>fq :<C-u>quitall!<CR>
nnoremap <Leader><Leader> :<C-u>update<CR>

" ; と : を交換
noremap ; :
noremap : ;

" <space>s.で即座にvimrcを開く
nnoremap <Space>.
      \        :<C-u>edit $MYVIMRC<CR>

" macvim
if has('gui_macvim')
    let mapleader=' '
endif

" <space>s.で即座にvimrcをリロード
nnoremap <Space>s.
      \        :<C-u>source $MYVIMRC<CR>

" marksとregistersに専用キーを割り当て
nnoremap <Space>m  :<C-u>marks
nnoremap <Space>r  :<C-u>registers

" Tab pages 
nnoremap <C-t>  <Nop>
nnoremap <C-t>n  :<C-u>tabnew<CR>
nnoremap <C-t>c  :<C-u>tabclose<CR>
nnoremap <C-t>o  :<C-u>tabonly<CR>
nnoremap <C-t>j  :<C-u>execute 'tabnext' 1 + (tabpagenr() + v:count1 - 1) % tabpagenr('$')<CR>
nnoremap <C-t>k  gT
nnoremap <C-h>   gT
nnoremap <C-l>   gt
nnoremap st :<C-u>tabnew<CR>
nnoremap sn gt
nnoremap sp gT

" ウィンドウ分割
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>

"ペーストしたテキストをビジュアルモードで選択(gp)
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" command mode mappings "{{{2

" /検索中に/を入力しやすくする
cnoremap <expr> /  getcmdtype() == '/' ? '\/' : '/'

" visual mode mappings "{{{2

vnoremap v $h
" Visual Mode で 選択中に*で検索する
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>

" insert mode mappings "{{{2


" operatorをgtキーにマップ
map tt <Plug>(operator-cod-gt)
" original command "{{{2
" AllMaps
command!
      \ -nargs=* -complete=mapping
      \ AllMaps
      \ map <args> | map! <args> | lmap <args>

" Plugin Settings "{{{1

autocmd BufRead *.cs :set dictionary=~/.vim/dict/unity_classes.dict

" --------------------------------
" NeoComplete
" --------------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
"return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup()."\<Space>" : "\<Space>"



" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" .や::を入力したときにオムニ補完が有効になるようにする
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

"---------------------------------
" Vimfiler
"---------------------------------
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_edit_action = 'tabopen'
nnoremap <Leader>e :<C-u>VimFilerBufferDir<CR>

"---------------------------------
" unite.vim
"---------------------------------
nmap    <Leader>u [unite]
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir<Space>-buffer-name=files<Space>file<CR>
nnoremap <silent> [unite]u :<C-u>Unite<Space>buffer file_mru bookmark<CR>

let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200

"---------------------------------
" Rsense
"---------------------------------
let g:rsenseHome = '/usr/local/Cellar/rsense/0.3/libexec/'
let g:rsenseUseOmniFunc = 1

" 環境変数RSENSE_HOMEに'/usr/local/bin/rsense'を指定しても動く
let g:neocomplete#sources#rsense#home_directory = '/usr/local/bin/rsense'

"------------------------------------
" Rubocop シンタックスチェック
"------------------------------------
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

"------------------------------------
" smartchr "{{{2
"------------------------------------
inoremap <expr> # smartchr#one_of('#', '#{}')
inoremap <expr> , smartchr#one_of(', ', ',')

" indent-guides "{{{2

hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1

" caw.vim
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

"
" Fin.  "{{{1

"set secure  " must be written at the last.  see :help 'secure'.

" __END__  "{{{1
" vim: expandtab softtabstop=2 shiftwidth=2
" vim: foldmethod=marker
