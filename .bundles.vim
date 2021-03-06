"vim -u .bundles.vim +BundleInstall +q

set nocompatible
let $GIT_SSL_NO_VERIFY='true'

filetype off " required! by vundle

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-repeat'
Bundle 'vim-ruby/vim-ruby'
Bundle 'csexton/jekyll.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'groenewege/vim-less'
Bundle 'skryl/tslime.vim'
Bundle 'VimClojure'

" dependency of vim-textobj-rubyblock"
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'

Bundle 'sjbach/lusty'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/snipmate-snippets'
Bundle 'godlygeek/tabular'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'lucapette/vim-ruby-doc'
""Bundle 'jgdavey/tslime.vim'
Bundle 'mileszs/ack.vim'
Bundle 'Lokaltog/vim-easymotion'
" vim-scripts repos
Bundle 'kien/ctrlp.vim'
Bundle 'AutoClose'
Bundle 'bufexplorer.zip'
Bundle 'matchit.zip'
Bundle 'The-NERD-tree'
Bundle 'EasyGrep'
Bundle 'AnsiEsc.vim'
Bundle 'TwitVim'
Bundle 'haskell.vim'
Bundle 'keepcase.vim'
Bundle 'dbext.vim'
Bundle 'SuperTab'
Bundle 'majutsushi/tagbar'
Bundle 'LogViewer'
Bundle 'Shougo/neocomplcache'
Bundle 'kyangk/sessionman.vim'
Bundle 'YankRing.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'altercation/vim-colors-solarized'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'bling/vim-airline'
Bundle 'elzr/vim-json'
" Bundle 'jnwhiteh/vim-golang'
Bundle 'uggedal/go-vim'
Bundle 'Blackrush/vim-gocode'
Bundle 'vim-scripts/MultipleSearch2.vim'


" non github repos
""Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed.

