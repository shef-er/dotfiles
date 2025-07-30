"---------------------------------------
"   Commands
"---------------------------------------

" Save file with root permissions
command! WW     exec 'w !sudo tee % > /dev/null' | e!

"---------------------------------------
"   Shortcuts
"---------------------------------------
" mappings modifer
let mapleader = ","


" ,v
" open settings
nnoremap <leader>v <esc>:e ~/.config/vimrc<cr>
" ,vs
" open shortcuts
nnoremap <leader>vs <esc>:e ~/.config/vim/keymaps.vim<cr>
" ,vp
" open plugins
nnoremap <leader>vp <esc>:e ~/.config/vim/plugins.vim<cr>


" Disables suspending by <Ctrl+z>
nnoremap <c-z> <nop>


" language switch in vim
cmap <silent> <C-F> <C-^>
imap <silent> <C-F> <C-^>X<Esc>a<C-H>
nmap <silent> <C-F> a<C-^><Esc>
vmap <silent> <C-F> <Esc>a<C-^><Esc>gv


" stop using arrows in vim
"nnoremap <Up> :echomsg "use k"<CR>
"nnoremap <Down> :echomsg "use j"<CR>
"nnoremap <Left> :echomsg "use h"<CR>
"nnoremap <Right> :echomsg "use l"<CR>


" <Esc><Esc>
" Clear the search highlight in Normal mode
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" ,ts
" Fix trailing white space
nnoremap <leader>ts   :<C-u>%s/\s\+$//e<CR>


" ,w
" Jump to next split
nnoremap <Leader>w    <C-w>w


" ,bl
" Show buffers
nnoremap <Leader>bl   :<C-u>ls<cr>:b

" ,bp
" Go to prev buffer
nnoremap <Leader>bp   :<C-u>bp<cr>

" ,bn
" Go to next buffer
nnoremap <Leader>bn   :<C-u>bn<cr>

" ,bd
" Delete current buffer saving split
nnoremap <Leader>bd   :<C-u>bp\|bd #<cr>

" ,br
" Delete all buffers except off current
function! CloseAllBuffersButCurrent()
  let curr = bufnr("%")
  let last = bufnr("$")

  " :NERDTreeClose
  if curr > 1    | silent! execute "1,".(curr-1)."bd"     | endif
  if curr < last | silent! execute (curr+1).",".last."bd" | endif
endfunction
nnoremap <Leader>br :call CloseAllBuffersButCurrent()<cr>

" Y
" copy from cursor position to the end of line
nnoremap Y y$

" Jump to begin/end of line in command mode
cnoremap <c-e> <end>
inoremap <c-e> <c-o>$
cnoremap <c-a> <home>
inoremap <c-a> <c-o>^

" ,<Tab>
" Switch tabs with <Tab>
nnoremap <Leader><Tab> gt
nnoremap <Leader><S-Tab> gT

" Tab navigation like Firefox.
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

" Show syntax highlighting groups for word under cursor
nmap <C-S-p> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

