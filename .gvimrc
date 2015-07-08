if !exists("colors_name")
    " Use the macvim color scheme by default
    "colorscheme macvim
    colorscheme hybrid
endif
set background=dark
set guifont=Ricty:h18

if has('gui_macvim')
    set transparency=10	" 透明度を指定
    set antialias
    set guioptions-=t	" ツールバー非表示
    set guioptions-=r	" 右スクロールバー非表示
    set guioptions-=R
    set guioptions-=l	" 左スクロールバー非表示
    set guioptions-=L
    set guifont=Osaka-Mono:h14

    set imdisable		" IMを無効化

    "フルスクリーンモード	
    set fuoptions=maxvert,maxhorz
    autocmd GUIEnter * set fullscreen 
endif
