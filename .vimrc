source ~/.bundles.vim

syntax on

set cursorline
set cursorcolumn

" set spell

set t_Co=256
imap jj <esc>

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set softtabstop=2
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
set shiftround
set showmatch

" display incomplete commands
set showcmd

" make tab in v mode ident code
" vmap <tab> >gv
" vmap <s-tab> <gv

" paste mode - this will avoid unexpected effects when you
" cut or copy some text from one window and paste it in Vim.
set pastetoggle=<F5>

set fileformat=unix

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

set autoread

set hidden

" command line completion
set wildchar=<Tab> wildmenu wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git*,*.rbc,*.class,.svn,vendor/gems/*,*/tmp/*,*.so,*.swp,*.zip,*/images/*,*/cache/*,scrapers/products/*

" setup dbext to use sqlite3 by default"
let g:dbext_default_SQLITE_bin='sqlite3'

set switchbuf=useopen

" " It's useful to show the buffer number in the status line.
" set laststatus=2 statusline=%02n:%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

autocmd BufReadPost fugitive://* set bufhidden=delete

"" json highlighting
autocmd BufNewFile,BufRead *.json set ft=javascript

"" coffee script autocompile on save
""autocmd BufWritePost *.coffee silent CoffeeMake! | cwindow

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,Vagrantfile,Thorfile,config.ru} set ft=ruby

au BufNewFile,BufRead *.hamlc set filetype=haml

" Don't syntax highlight markdown because it's often wrong
autocmd! FileType mkd setlocal syn=off

" cucumber auto outline
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

let g:LustyJugglerSuppressRubyWarning = 1

function! MyCloseGdiff()
  if (&diff == 0 || getbufvar('#', '&diff') == 0)
        \ && (bufname('%') !~ '^fugitive:' && bufname('#') !~ '^fugitive:')
    echom "Not in diff view."
    return
  endif

  " close current buffer if alternate is not fugitive but current one is
  if bufname('#') !~ '^fugitive:' && bufname('%') =~ '^fugitive:'
    if bufwinnr("#") == -1
      b #
      bd #
    else
      bd
    endif
  else
    bd #
  endif
endfunction
nnoremap <Leader>D :call MyCloseGdiff()<cr>

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:  ' . a:cmdline)
  call setline(2, 'Expanded to:  ' . expanded_cmdline)
  call append(line('$'), substitute(getline(2), '.', '=', 'g'))
  silent execute '$read !'. expanded_cmdline
  1
endfunction

nnoremap <Leader>f :CtrlP<CR>
nnoremap <Leader>B :CtrlPBuffer<CR>

function! s:GrepOpenBuffers(search, jump)
    call setqflist([])
    let cur = getpos('.')
    silent! exe 'bufdo vimgrepadd /' . a:search . '/ %'
    let matches = len(getqflist())
    if a:jump && matches > 0
        sil! cfirst
    else
        call setpos('.', cur)
    endif
    echo 'BufGrep:' ((matches) ? matches : 'No') 'matches found'
endfunction
com! -nargs=1 -bang BufGrep call <SID>GrepOpenBuffers('<args>', <bang>0)
nnoremap <Leader>S :BufGrep

" remap 'increase number' since C-a is captured by tmux/screen
" Easier increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>

let g:EasyGrepRecursive = 1
let g:EasyGrepIgnoreCase = 1
let g:EasyGrepJumpToMatch = 1
let g:EasyGrepReplaceWindowMode = 2
let g:EasyGrepMode = 2 " Track extension

set relativenumber

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" CTags
"
" $PATH appears different to vim for some reason and hence wrong ctags gets picked
" until then, you need to manually override ctags in /usr/bin/ with those from homebrew
" TODO fix vim path
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Gundo configuration
nmap <F6> :GundoToggle<CR>
imap <F6> <ESC>:GundoToggle<CR>

let g:molokai_original = 0
set background=dark
colorscheme solarized
" hi Search ctermbg=black

set scrolloff=3 " Keep 3 lines below and above the cursor"

" Store swap files in fixed location, not current directory.
set dir=~/.vimswap//,/var/tmp//,/tmp//,."

nnoremap <CR> :nohls<CR><CR>

" Make Y behave like other capitals
nnoremap Y y$

" Improve up/down movement on wrapped lines
nnoremap j gj
nnoremap k gk

" Use very magic regexes
nnoremap / /\v
vnoremap / /\v

" Better comand-line editing
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-^> <Home>
cnoremap <C-e> <End>

" Drag Current Line/s Vertically
nnoremap <M-j> :m+<CR>
nnoremap <M-k> :m-2<CR>
inoremap <M-j> <Esc>:m+<CR>
inoremap <M-k> <Esc>:m-2<CR>
vnoremap <M-j> :m'>+<CR>gv

" Disable paste mode when leaving Insert Mode
au InsertLeave * set nopaste

let g:ackprg="ack -H --nocolor --nogroup --column"

" Stop messing with my arrow keys
if !has("gui_running")
  let g:AutoClosePreservDotReg = 0
endif

map <leader>y "*y

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>


nnoremap <Leader>tt :TagbarOpenAutoClose<CR

let NERDTreeHijackNetrw=1

set list listchars=trail:·

let g:ctrlp_show_hidden = 1

" disable folding
set nofoldenable

" alias backtick to signle quote
map ' `

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1

" omni completion"
set ofu=syntaxcomplete#Complete

" PowerLine recommeneded:
set laststatus=2   " Always show the statusline"
set encoding=utf-8 " Necessary to show Unicode glyphs"

fun! RangerChooser()
  exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
  if filereadable('/tmp/chosenfile')
    exec 'edit ' . system('cat /tmp/chosenfile')
    call system('rm /tmp/chosenfile')
  endif
  redraw!
endfun
map <Leader><Leader>r :call RangerChooser()<CR>

" Quick grep for word under the cursor in rails app
noremap <Leader>aa :Ack <cword> app<cr>
noremap <Leader>as :Ack <cword> spec<cr>

"needed to put this line in once i installed the YankRing plugin as it
"overrides the CtrlP plugin"
" nnoremap <c-f> :CtrlP<cr>
" nnoremap <c-b> :CtrlPBuffer<cr>

nnoremap ¯ :vertical resize -10<cr>
nnoremap ˘ :vertical resize +10<cr>

" easier navigation to the beginning and end of a line"
nnoremap H ^
nnoremap L g_

" better support for the mouse"
set mouse=a

" when moving from window to window the below turns off cursorcolumn,
" cursorline and relativenumber. Hopefully this will help with which window is
" active.."
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set relativenumber
  autocmd WinEnter * set cursorline
  autocmd WinEnter * set cursorcolumn

  autocmd WinLeave * set norelativenumber
  autocmd WinLeave * set nocursorline
  autocmd WinLeave * set nocursorcolumn
augroup END

" the below changes the horrible dotted line between windows... notice that
" there is a space after the \ that needs to be there"
set fillchars=vert:\ ,stl:\ ,stlnc:\
