" custom mappings
nnoremap Y y$
nnoremap <Space>y "+y
vnoremap <Space>y "+y
nnoremap <Space>yy "+yy
nnoremap <Space>Y "+Y
nnoremap <Space>p "+p
vnoremap <Space>p "+p
nnoremap <Space>P "+P
vnoremap <Space>P "+P
nnoremap <Esc> :noh<CR>
vnoremap > >gv
vnoremap < <gv
nnoremap _ ^

" make o/O respect context
exmap blankBelow obcommand obsidian-editor-shortcuts:insertLineBelow
exmap blankAbove obcommand obsidian-editor-shortcuts:insertLineAbove
nmap o :blankBelow<CR>i
nmap O :blankAbove<CR>i

" switch tabs
exmap nextTab obcommand workspace:next-tab
exmap prevTab obcommand workspace:previous-tab
nnoremap gt :nextTab<CR>
nnoremap gT :prevTab<CR>

" jumping between headings
exmap nextHeading obcommand obsidian-editor-shortcuts:goToNextHeading
exmap prevHeading obcommand obsidian-editor-shortcuts:goToPrevHeading
nnoremap <C-j> :nextHeading<CR>
nnoremap <C-k> :prevHeading<CR>

" open right-click context menu under cursor
exmap contextMenu obcommand editor:context-menu
nnoremap K :contextMenu<CR>

