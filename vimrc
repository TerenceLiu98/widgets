call plug#begin("~/.vim/bundle")

 Plug 'scrooloose/nerdtree'
 Plug 'mhinz/vim-startify'
 Plug 'tpope/vim-fugitive'
 Plug 'lfv89/vim-interestingwords'
 Plug 'voldikss/vim-floaterm'
 Plug 'skywind3000/asyncrun.vim'

call plug#end()

" nerdtree
let mapleader = ","
nnoremap <F5> :exec 'NERDTreeToggle' <CR>

" vim-interestingwords
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']
let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222']
let g:interestingWordsRandomiseColors = 1

" vim-floaterm
let g:floaterm_wintype = "split"
nnoremap <F6> :exec "FloatermNew --height=0.2"


" asyncrun
let g:asyncrun_open = 6
let g:asyncrun_bell = 1
nnoremap <F7> :call asyncrun#quickfix_toggle(6)<cr>
