""---------------------------------------
"" Keymaps
""---------------------------------------

"" Bind :W to :w
command! W w

"" Bind :Q to :q
command! Q q

"" Disables suspending by <Ctrl+z>
nnoremap <C-z> <nop>

"" Language switch in vim
cmap <silent> <C-f> <C-^>
imap <silent> <C-f> <C-^>X<Esc>a<C-H>
nmap <silent> <C-f> a<C-^><Esc>
vmap <silent> <C-f> <Esc>a<C-^><Esc>gv

"" Stop using arrows in vim
"nnoremap <Up> :echomsg "use k"<CR>
"nnoremap <Down> :echomsg "use j"<CR>
"nnoremap <Left> :echomsg "use h"<CR>
"nnoremap <Right> :echomsg "use l"<CR>


"" Indentation with <Tab> and <Shift-Tab>
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >
vnoremap <S-Tab> <


"" <Esc><Esc>
"" Clear the search highlight in Normal mode
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

"" <Ctrl-s>
noremap <C-s> <Esc>:w<CR>
noremap <C-ы> <Esc>:w<CR>
"inoremap <C-s> <Esc>:w<CR>
"inoremap <C-ы> <Esc>:w<CR>


""---------------------------------------
"" Modifier-based keymaps
""---------------------------------------

"" mappings modifer
let mapleader = ","

"" ,ts
"" Fix trailing white space
nnoremap <Leader>ts :<C-u>%s/\s\+$//e<CR>

"" ,w
"" Jump to next split
nnoremap <Leader>w <C-w>w

"" ,bl
"" Show buffers
nnoremap <Leader>bl :<C-u>ls<CR>:b

"" ,bp
"" Go to prev buffer
nnoremap <Leader>bp :<C-u>bp<cr>

"" ,bn
"" Go to next buffer
nnoremap <Leader>bn :<C-u>bn<CR>

"" ,bd
"" Delete current buffer saving split
nnoremap <Leader>bd :<C-u>bp\|bd #<CR>

"" ,br
"" Delete all buffers except off current
function! CloseAllBuffersButCurrent()
  let curr = bufnr("%")
  let last = bufnr("$")

  :NERDTreeClose
  if curr > 1    | silent! execute "1,".(curr-1)."bd"     | endif
  if curr < last | silent! execute (curr+1).",".last."bd" | endif
endfunction
nnoremap <Leader>br :call CloseAllBuffersButCurrent()<CR>

"" ,v
"" open settings
nnoremap <Leader>v <Esc>:e ~/.config/nvim/vim/settings.vim<CR>

"" ,vs
"" open shortcuts
nnoremap <Leader>vs <Esc>:e ~/.config/nvim/vim/keymaps.vim<CR>

"" ,vp
"" open plugs
nnoremap <Leader>vp <Esc>:e ~/.config/nvim/vim/plugins.vim<CR>

