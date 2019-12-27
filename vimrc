"------------- test ------------
"set omnifunc=syntaxcomplete#Complete
"imap nn <C-n>
"------------------------------

" -------------------- Настройки нативного vim ------------------------------"
" включить плагины типов файлов --------
filetype plugin on

"  swp файлы хранить в отдельном каталоге
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set undodir=~/.vim/tmp/undo//
" Отключить формирование swap файлов 
set nobackup
set noswapfile
" swp файлы

" строка статуса // стандартно не работает если включен плагин vim-airline
set wildmenu
set laststatus=2
set statusline=%f%m%r%h%w\ %y\ enc:%{&enc}\ ff:%{&ff}\ fenc:%{&fenc}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%]
" !строка статуса

syntax on " подсветка синтаксиса включена

set wrapmargin=8 " 8-ми символьный буфер перед концом терминала
set number

" отступы
set shiftwidth=4 " сдвиг >>
set tabstop=4 " Заменять табы на пробелы
set softtabstop=4 " повтор сдвига   
set expandtab " при вставке заменять табы на прбелы (shiftwidth)

set timeoutlen=300 " таймаут до нажатия второй клавиши если есть горячие клавиши 

" копирование / вставка в буфер ОС:
nmap "PP "+p
vmap "YY "+y

" блочное выделение
nmap vvv <S-v>
nmap vvb <C-v>
" сплит
" :vsplit, split

" переключение между сплитами
nmap tg <C-w>w
nmap ty <C-w><C-+>

" выход в нормальный режим
imap ,j <Esc>l
vmap ,j <Esc>l 

" автозаполнение
imap nn <C-n>

" вкладки, табы
" gt - перейти на следующую вкладку
" <n> gt - перейти на вкладку номен
" gT - предидущия вкладка
"  
" метки: ----------------------
" m <a-z, 1-9> - поставить метку (строчные буквы - метка для текущего файла, заглавная для всех файлов)
" :marks - список меток
" ` <marks> - перейти к метке
" ------------------------------
"
" ------------------------- 
" переход к файлу в котором объявлена функция
" ctags -R
" g] - на функции чтобы перейти на объявление
" Ctrl + T - вернуться
set autochdir
set tags=tags;
set tags=tags;/ " tags в корне проекта

" выделение:
" v - по символьно
" Shift + v (<S-v>) - по стрчно
" Ctr + v (<C-v>) - блочно

" меню кодировки, вызывается "fn + F8"
set wildmenu
set wcm=<Tab>
menu Encoding.koi8-r :e ++enc=koi8-r<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.cp866 :e ++enc=cp866<CR>
menu Encoding.utf-8 :e ++enc=utf8 <CR>
map <F8> :emenu Encoding.<TAB>
" !-------------------- !Настройки нативного vim ------------------------------"
"
call plug#begin('~/.vim/plugged')
    " NERDTree -------------------
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    map nerd :NERDTreeToggle<CR>
    let NERDTreeShowHidden=1 " отображать скрытые файлы
    autocmd VimEnter * NERDTree " открывать автоматически
    autocmd VimEnter * wincmd p " курсор на открытом файле
    let g:NERDTreeWinPos = "right" " дерево каталогов справа
    " Для выхода лучше использовать:
    " Функция для закрытия NERDTree при закрытии окна
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " end NERDTree close function
    " !NERDTree -------------------
    " плагин для % (перемещения по тегам html)
    Plug 'https://github.com/adelarsq/vim-matchit'
    " Emmet ---------------------
    Plug 'mattn/emmet-vim' " генерирование тегов html
    let g:user_emmet_expandabbr_key = ',<tab>'
    let g:user_emmet_settings = {
      \  'php' : {
      \    'extends' : 'html',
      \    'filters' : 'c',
      \  },
      \  'xml' : {
      \    'extends' : 'html',
      \  },
      \  'haml' : {
      \    'extends' : 'html',
      \  },
      \}
    " end Emmet ----------------
    Plug 'rstacruz/sparkup', {'rtp': 'vim/'} " расширяет возможности Emmet
    " theme ----------
    Plug 'altercation/vim-colors-solarized'
    let g:solarized_termcolors=256
    let g:solarized_termtrans = 1
    syntax on
    syntax enable
    set background=light
    if has("gui_running")
       colorscheme solarized
    else
        colorscheme desert
    endif
    " end theme ------------
    " start plugin for comment code------------
    Plug 'scrooloose/nerdcommenter'
    " default "leader key" = '\'
    let g:NERDSpaceDelims = 1 " количество пробелов после символа(ов) комментария
    " end comment ----------------
    "
    Plug 'szw/vim-tags'

    Plug 'ctrlpvim/ctrlp.vim' " поиск файллов в проекто (зависить от tags)
    " Ctrl+p
    " Ctrl+j - перемещение по списку
    
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
 "   let g:deoplete#enable_at_startup = 1

    " -------------
    Plug 'vim-syntastic/syntastic'
    " syntastic -------------------
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    let g:syntastic_enable_signs    = 1
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list   = 1
    let g:syntastic_check_on_open   = 1
    let g:syntastic_check_on_wq     = 0
    let g:syntastic_php_checkers    = ['php', 'phpcs', 'phpmd']

    let g:syntastic_auto_jump           = 1
    let g:syntastic_error_symbol        = '✖'
    let g:syntastic_warning_symbol      = '►'
    let g:syntastic_javascript_checkers = ['jshint'   ] " sudo npm install -g jshint
    let g:syntastic_html_checkers       = ['jshint'   ] " sudo npm install -g jshint
    let g:syntastic_haml_checkers       = ['haml-lint'] " gem install haml-lint
    let g:syntastic_css_checkers        = ['csslint'  ] " sudo npm install -g csslint
    let g:syntastic_css_csslint_args    = "--ignore=zero-units"
    " !syntastic -----------------

call plug#end()
