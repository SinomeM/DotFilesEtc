" This .vimrc is mostly inspired by these two sources
" http://nerditya.com/code/guide-to-neovim/
" https://dougblack.io/words/a-good-vimrc.html

" It should be quite agnostic whether it is actually used for vim or Neovim.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
    " nnoremap $ <nop>
    nnoremap ^ <nop>

  " Shortcuts "
    " Use ; for commands.
    nnoremap ; :
    " Use Q to execute default register.
    nnoremap Q @q

    " toggle undotree, super undo
    nnoremap <leader>u :UndotreeToggle<CR>
    " save session, can be recovered running "vim -S", super save
    nnoremap <leader>w :mksession<CR>

  " Misc
    set spell " spell-check on by default

  " Windows and Tabs
    nnoremap <leader>w <C-w>w

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim compatibility
    if !has('nvim')
      let g:python3_host_prog="/pat/to/python3"
    endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plugins

" vim-plug plugins management "

  " Plugins will be downloaded under the specified directory.
  call plug#begin('~/.vim/plugged')

    Plug 'tpope/vim-sensible'          " basic set of universal defaults for vim
    Plug 'ctrlpvim/ctrlp.vim'          " CtrlP fuzzy finder
    Plug 'vim-airline/vim-airline'     " power line simpler alternative
    Plug 'morhetz/gruvbox'             " best theme
    Plug 'mbbill/undotree'             " undotree, the super undo
    Plug 'chrisbra/csv.vim'            " help visualize and manage CSV in vim
    Plug 'camspiers/animate.vim'       " With the next one
    Plug 'camspiers/lens.vim'          " dynamically resize vim windows
    " Plug 'jiangmiao/auto-pairs'        " Match brackets etc
    Plug 'preservim/nerdtree'

    " Completition
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    " enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()
    " IMPORTANT: :help Ncm2PopupOpen for more information
    set completeopt=noinsert,menuone,noselect
    " suppress the annoying 'match x of y', 'The only match' and 'Pattern not found' messages
    set shortmess+=c
    " CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
    inoremap <c-c> <ESC>
    " When the <Enter> key is pressed while the popup menu is visible, it only hides the menu.
    " Use this mapping to close the menu and also start a new line.
    inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
    " Use <TAB> to select the popup menu:
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    Plug 'ncm2/ncm2-jedi'              " Python
    Plug 'ncm2/ncm2-path'              " Paths
    Plug 'ncm2/ncm2-bufword'           " Words from buffer
    Plug 'yuki-yano/ncm2-dictionary'   " Dictionary (could be not functional)
    " Plug 'oncomouse/ncm2-biblatex'     " BibLaTex

    Plug 'gaalcaras/ncm-R'             " R
    " Vim 8 only
    if !has('nvim')
        Plug 'roxma/vim-hug-neovim-rpc'
    endif

    " R, markdown, Tex
    Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}    " Use vim to edit and run R code
    " Plug 'lervag/vimtex'                            " LaTex plugin
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'vim-pandoc/vim-rmarkdown'
    " Plug 'jalvesaq/zotcite'   " Zotero integration

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

  " Animations
    let g:lens#disabled_filetypes = ['nerdtree', 'fzf']     " animations off for nerdtree

  " NERDtree
    " nnoremap <leader>N :NERDTree<CR>
    nnoremap <C-n> :NERDTreeToggle<CR>

  " Theme
    colorscheme gruvbox

  " MArkdown Preview
    nmap <C-p> <Plug>MarkdownPreviewToggle

  " Nvim-R
   " remapping the basic :: send line
    nmap , <Plug>RDSendLine
    " remapping selection :: send multiple lines
    vmap , <Plug>RDSendSelection
    " remapping selection :: send multiple lines + echo lines
    vmap ,e <Plug>RESendSelection
    " R output is highlighted with current colorscheme
    let g:rout_follow_colorscheme = 1
    " R commands in R output are highlighted
    let g:Rout_more_colors = 1

    let R_assign = 3
    " let R_assign_map = '<M-->'
    " let R_rmdchunk = '``'
    let R_objbr_place = 'script,left'
    let R_hi_fun_paren = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Most relevant key-bindings "

" MISC
  " Clear search highlighting            <C-l> or <space><space>
  " Toggle spell check off               ':set nospell'
  " Previous and next misspelled word    [s ]s
  " Spell-check suggestions              z=
  " Add word to dictionary               zg
  " Open CtrlP file menu                 <space>o
  " Open CtrlP buffer menu               <space>b
  " Undotree                             <space>u
  " Save session                         <space>w
  " Restore session                      'vim -S' (from a terminal)
  " Toggle relative numbering            <space>R
  " Highlight last inserted text         gV
  " Search and replace                   <space>s
  " NERDtree (toggle)                    <C-n>
  " Markdown Preview (toggle)            <C-p>

" Movement
  " Place cursor under next/prev occurrence of <chr>    f or F + <chr>
  " Place cursor before next/prev occurrence of <chr>   t or T + <chr>
  " Create mark a (intimate of the file)                ma
  " Create mark A (shared in the entire session)        mA
  " jump to mark a/A                                    'a or 'A

" Windows & Tabs
  " Open file in a new window            ':new file'
  " Move to a window                     <C-w> + h/j/k/l
  " Toggle windows                       <space>w
  " Open file in a new tab               ':tabe file'
  " Move to next tab                     gt
  " Move to previous tab                 gT

" R
  " Start R                              \rf
  " Close R                              \rq
  " Send line                            ,
  " Send selected lines                  ,
  " Send block                           \bb
  " Open objects browser                 \ro
  " Compile Rmd file (useless??)         ':RMarkdown pdf' or ':RMarkdown html'
  " Help                                 \rh
  " See data.frame                       \rv
  " Output of a code line as comment     \o
  " Toggle comment line/selection        \xx
  " Remove objects and clear console     \rm
  " Send chunk                           \cc
  " Insert '<-'                          <M--> (M is Alt key)
  " Insert chunck in a Rmd file          ``
  " Knit to HTML                         \kh

" Other
  " sdfsdf



