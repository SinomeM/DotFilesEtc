" This .vimrc is mostly inspired by these two sources
" http://nerditya.com/code/guide-to-neovim/
" https://dougblack.io/words/a-good-vimrc.html

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Basic settings "

  let mapleader="\<SPACE>"        " Map the leader key to SPACE
  syntax enable                   " enable syntax processing
  set mouse=a                     " enable mouse


  " UI
    set showmatch                 " Show matching brackets.
    set number                    " Show the line numbers on the left side.
    set formatoptions+=o          " Continue comment marker in new lines.
    " highlight last inserted text
    nnoremap gV `[v`]

  " TAB / spaces
    set expandtab                 " Insert spaces when TAB is pressed.
    set tabstop=2                " Render TABs using this many spaces.
    set shiftwidth=2             " Indentation amount for < and > commands.
    set nojoinspaces              " Prevents inserting two spaces after punctuation on a join (J)

    " Tell Vim which characters to show for expanded TABs,
    " trailing whitespace, and end-of-lines. VERY useful!
    if &listchars ==# 'eol:$'
      set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
    endif
    set list                      " Show problematic characters.
    " Also highlight all tabs and trailing whitespace characters.
    highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
    match ExtraWhitespace /\s\+$\|\t/

  " More natural splits
    set splitbelow                " Horizontal split below current.
    set splitright                " Vertical split to right of current.

    if !&scrolloff
      set scrolloff=3             " Show next 3 lines while scrolling.
    endif
    if !&sidescrolloff
      set sidescrolloff=5         " Show next 5 columns while side-scrolling.
    endif
    set nostartofline             " Do not jump to first character with page commands.

  " Search and Replace
    set ignorecase                " Make searching case insensitive
    set smartcase                 " unless the query has capital letters.
    set gdefault                  " Use 'g' flag by default with :s/foo/bar/.

    " turn off search highlight with <space><space>
    nnoremap <leader><space> :nohlsearch<CR>

    " Search and Replace shortcut
    nmap <Leader>s :%s//g<Left><Left>

  " Relative Numbering
    function! NumberToggle()
      if(&relativenumber == 1)
        set nornu
        set number
      else
        set rnu
      endif
    endfunc

    " Toggle between normal and relative numbering.
    nnoremap <leader>R :call NumberToggle()<cr>

  " Folding "
    set foldenable                " enable folding
    set foldlevelstart=5         " open most folds by default
    set foldnestmax=5            " 10 nested fold max
    set foldmethod=indent         " fold based on indent level

  " Movement
    " move vertically by visual line
    nnoremap j gj
    nnoremap k gk
    " move to beginning/end of line
    nnoremap B ^
    nnoremap E $
    " $/^ doesn't do anything
    nnoremap $ <nop>
    nnoremap ^ <nop>

  " Shortcuts "
    " Use ; for commands.
    nnoremap ; :
    " Use Q to execute default register.
    nnoremap Q @q

    " toggle undotree, super undo
    nnoremap <leader>u :UndotreeToggle<CR>
    " save session, can be recovered running "vim -S", super save
    nnoremap <leader>s :mksession<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plugins

" vim-plug plugins management "

  " Plugins will be downloaded under the specified directory.
  call plug#begin('~/.vim/plugged')

    Plug 'tpope/vim-sensible'          " basic set of universal defaults for vim
    "Plug 'tpope/vim-sleuth'            " adjust TAB/spaces related settings based on file

    Plug 'ctrlpvim/ctrlp.vim'          " CtrlP fuzzy finder

    Plug 'vim-airline/vim-airline'     " power line simpler alternative
    " Plug 'vim-airline/vim-airline-themes'

    Plug 'morhetz/gruvbox'             " best theme

    Plug 'mbbill/undotree'             " undotree, the super undo

    Plug 'chrisbra/csv.vim'            " help visualize and manage CSV in vim

  " List ends here. Plugins become visible to Vim after this call.
  call plug#end()

" Plugins configuration

  " CtrlP
    " Open file menu
    nnoremap <Leader>o :CtrlP<CR>
    " Open buffer menu
    nnoremap <Leader>b :CtrlPBuffer<CR>
    " Open most recently used files
    nnoremap <Leader>f :CtrlPMRUFiles<CR>

  " vim-airline
    let g:airline#extensions#tabline#enabled = 2
    let g:airline#extensions#tabline#fnamemod = ':t'
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#right_sep = ' '
    let g:airline#extensions#tabline#right_alt_sep = '|'
    let g:airline_left_sep = ' '
    let g:airline_left_alt_sep = '|'
    let g:airline_right_sep = ' '
    let g:airline_right_alt_sep = '|'
    let g:airline_theme='gruvbox'

  " Theme
    colorscheme gruvbox
