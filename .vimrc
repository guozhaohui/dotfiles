"---------------------------------------------------------------------------
" guo zhaohui's .vimrc
"---------------------------------------------------------------------------

"---------------------------------------------------------------------------
" Initialize "{{{
"

" Vi互換をオフ
set nocompatible

" for Win
let s:is_windows = has('win32') || has('win64')

" vimfiles
if s:is_windows
  let $DOTVIM = $VIM.'/vimfiles'
else
  let $DOTVIM = '~/.vim'
endif

" キーマップリーダーを「,」にする
let mapleader = ","

" Encoding "{{{
"
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2202-jp,sjis,cp932,euc-jp,cp20932
set fileformats=unix,dos,mac

" View "{{{
"

" vimdiff 色設定
 hi DiffAdd    ctermfg=black ctermbg=2
 hi DiffChange ctermfg=black ctermbg=3
 hi DiffDelete ctermfg=black ctermbg=6
 hi DiffText   ctermfg=black ctermbg=7
 highlight Pmenu ctermfg=black ctermbg=3
 highlight PmenuSel ctermfg=black ctermbg=3
 hi clear SpellBad
 hi SpellBad cterm=underline
 
" ターミナルでマウスを使用できるようにする
set mouse=a
set ttymouse=xterm2

filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" " required!
Bundle "gmarik/vundle"
Bundle "vim-scripts/taglist.vim"
Bundle "vim-scripts/DoxygenToolkit.vim"
Bundle "vim-scripts/grep.vim"
Bundle "vim-scripts/bufkill.vim"
Bundle "vim-scripts/a.vim"
Bundle "vim-scripts/cscope.vim"
"
" 行番号を表示する
set number

" 不可視文字の表示
" set list
" 不可視文字の表示形式
" set listchars=tab:\|\

" ウィンドウ幅より長い行を折り返す
set wrap
" カーソルが行頭/末にある時に前/次行に移動できるように
set whichwrap=b,s,h,l,<,>,[,]

" タイトルを表示
set title

" スプラッシュ画面を表示しない
set shortmess+=I

" 最終行に現在のモードを表示
set showmode

" スクロール時の余白確保
set scrolloff=5

" バッファで開いているディレクトリをExploreの初期ディレクトリに
set browsedir=buffer

" バックアップを作らない
set nobackup
set nowritebackup

" スワップファイルを作らない
set noswapfile

" 8進数を無効にする
set nrformats-=octal
" 印字不可能文字を16進数で表示
set display=uhex

" ビープ音を鳴らさない
"set visualbell
"set vb t_vb=

" コマンド・ファイル名補完の拡張機能を使用
set wildmenu
" 補完を開始するキー
set wildchar=<tab>
" リスト表示，最長マッチ
set wildmode=list:longest,full

" コマンド・検索パターンの履歴数
set history=1000

" 補完に辞書ファイル追加
set complete+=k

" カーソルが何行目の何列目に置かれているかを表示する
set ruler
" カーソル行をハイライト
set cursorline
" 縦方向もハイライト
" set cursorcolumn

" コマンド実行中に画面を描画しない
set lazyredraw

" コマンド入力欄の高さを3行分に設定
set cmdheight=1

" 常にステータスラインを表示
set laststatus=2
" コマンドをステータスラインに表示
set showcmd
" ステータスラインに文字コードと改行文字を表示する
set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %t%=%l,%c%V%8P

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" タブページを常に表示
" set showtabline=2

"---------------------------------------------------------------------------
" Edit "{{{
"

" タブ幅設定
set tabstop=4 shiftwidth=4 softtabstop=0
" タブを空白に変換しない
set expandtab

" .jsのみタブ幅とタブを空白にする設定
au BufNewFile,BufRead *.js set expandtab tabstop=8 shiftwidth=4
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

" ファイルごとの設定を有効にする
set modeline
set modelines=2

" OSのクリップボードを使用する
set clipboard+=unnamed

" 自動で折り返しをしない
set textwidth=0

" バックスペースで何でも消せるように
set backspace=indent,eol,start

" 対応する括弧をハイライト
set showmatch
" ハイライトの時間を3秒に
set matchtime=3

" 編集中でも他のファイルを開けるようにする
set hidden

" 他でファイルが書き換えられたら自動で読み直す
set autoread

" 挿入モードでの単語補完時に大文字小文字を無視する
set infercase

" 矩形選択で自由に移動する
set virtualedit+=block

" テキスト整形オプション，マルチバイト系を追加
set formatoptions=lmoq

" 文字がない場所でのペースト時に空白を詰める
if has('virtualedit') && &virtualedit =~# '\<all\>'
  nnoremap <expr> p (col('.') >= col('$') ? '$' : '') . 'p'
endif

"---------------------------------------------------------------------------
" Search "{{{
"

" 最後まで検索したら先頭へ戻る
set wrapscan

" 大文字小文字無視
set ignorecase

" 検索文字列に大文字が含まれている場合は区別して検索
set smartcase

" インクリメンタルサーチ
set incsearch

" 検索文字をハイライト
set hlsearch

"---------------------------------------------------------------------------
" Syntax "{{{
"

" シンタックスカラーをON
syntax enable

" 自動でインデント
set autoindent

" 新しい行のインデントを現在行と同じ量に
set smartindent

"---------------------------------------------------------------------------
" Key-mappings "{{{
"
map <F3>  :Rgrep<CR>
map <F5>  :sh<CR>
map <F6>  :make install<CR>
nnoremap * *``

"---------------------------------------------------------------------------
" abbr "{{{
"
abbr tracetxt printf("##########DEBUG %s(%d)  \n", __func__, __LINE__ );
abbr todotxt  /*TODO:  */
abbr cb /*---------------------------------------------------------------------
abbr ce -----------------------------------------------------------------------*/
abbr cb1 /*====================================================================
abbr ce1 ======================================================================*/
abbr cc /*   */


"---------------------------------------------------------------------------
" Plugins "{{{
"

"------------------------------------
" vimshell "{{{
"

" ノーマルモードで起動
nnoremap <silent> vs :VimShell<CR>

" 設定
let g:vimshell_prompt = '% '
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_temporary_directory = $VIM.'/.vimshell'
let g:vimshell_enable_smart_case = 1

let Grep_Default_Filelist = '*.c *.cpp *.h *.lisp Makefile Makefile.in Makefile.am    '
let Grep_Skip_Files = '*.bak *~ *.a *.o *.lsp'
let Grep_Skip_Dirs = '.tmp'

