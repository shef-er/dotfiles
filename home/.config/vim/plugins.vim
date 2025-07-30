" Plug autoinstallation
if empty(glob('~/.config/vim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

" Specify a directory for plugins
call plug#begin('~/.local/share/vim/plugins')

" Code commenting
Plug 'scrooloose/nerdcommenter'

" Close buffer leaving split or window
Plug 'qpkorr/vim-bufkill'

" Initialize plugin system
call plug#end()
