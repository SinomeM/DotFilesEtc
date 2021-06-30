# README 

## File default location 

```
- ~/.zshrc
- ~/.config/rstudio/rstudio-prefs.json
- ~/.config/nvim/init.vim
```

## Vim main key-bindings and commands

### Misc

```
- Clear search highlighting            <C-l> or <space><space>
- Toggle spell check off               ':set nospell'
- Previous and next misspelled word    [s ]s
- Spell-check suggestions              z=
- Add word to dictionary               zg
- Open CtrlP file menu                 <space>o
- Open CtrlP buffer menu               <space>b
- Undotree                             <space>u
- Save session                         <space>w
- Restore session                      'vim -S' (from a terminal)
- Toggle relative numbering            <space>R
- Highlight last inserted text         gV
- Search and replace                   <space>s
- NERDtree (toggle)                    <C-n>
- Markdown Preview (toggle)            <C-p>
```

### Movement

```
- Place cursor under next/prev occurrence of <chr>    f or F + <chr>
- Place cursor before next/prev occurrence of <chr>   t or T + <chr>
- Create mark a (intimate of the file)                ma
- Create mark A (shared in the entire session)        mA
- jump to mark a/A                                    'a or 'A
```

### Windows & Tabs

```
- Open file in a new window            ':new file'
- Move to a window                     <C-w> + h/j/k/l
- Toggle windows                       <space>w
- Open file in a new tab               ':tabe file'
- Move to next tab                     gt
- Move to previous tab                 gT
```

### R

```
- Start R                              \rf
- Close R                              \rq
- Send line                            ,
- Send selected lines                  ,
- Send block                           \bb
- Open objects browser                 \ro
- Compile Rmd file                     ':RMarkdown pdf' or ':RMarkdown html'
- Help                                 \rh
- See data.frame                       \rv
- Output of a code line as comment     \o
- Toggle comment line/selection        \xx
- Remove objects and clear console     \rm
- Send chunk                           \cc
- Insert '<-'                          <M--> (M is Alt key)
- Insert chunck in a Rmd file          ``
- Knit to HTML                         \kh
```

