" === GENERAL ===

" custom mappings
nnoremap Y y$
nnoremap <Space>y "+y
vnoremap <Space>y "+y
nnoremap <Space>Y "+Y
nnoremap <Space>p "+p
vnoremap <Space>p "+p
nnoremap <Space>P "+P
vnoremap <Space>P "+P
nnoremap <Esc> :noh<CR>
vnoremap > >gv
vnoremap < <gv
nnoremap _ ^
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz


" === TEXT EDITOR ===

" make o/O respect context
exmap blankBelow obcommand obsidian-editor-shortcuts:insertLineBelow
exmap blankAbove obcommand obsidian-editor-shortcuts:insertLineAbove
nmap o :blankBelow<CR>i
nmap O :blankAbove<CR>i

" open right-click context menu under cursor
exmap contextMenu obcommand editor:context-menu
nnoremap K :contextMenu<CR>

" toggle folding
exmap toggleFold obcommand editor:toggle-fold
exmap foldAll obcommand editor:fold-all
exmap unfoldAll obcommand editor:unfold-all
nmap za :toggleFold<CR>
nmap zM :foldAll<CR>
nmap zR :unfoldAll<CR>


" === NAVIGATION ===

" jumping between headings
exmap nextHeading obcommand obsidian-editor-shortcuts:goToNextHeading
exmap prevHeading obcommand obsidian-editor-shortcuts:goToPrevHeading
nnoremap <C-j> :nextHeading<CR>
nnoremap <C-k> :prevHeading<CR>

" lsp-style navigation
exmap followLink obcommand editor:follow-link
exmap renameFile obcommand workspace:edit-file-title
exmap back obcommand app:go-back
exmap forward obcommand app:go-forward
nmap gd :followLink<CR>
nmap grn :renameFile<CR>
nmap [b :back<CR>
nmap ]b :forward<CR>


" === WORKSPACE ===

" switch tabs
exmap nextTab obcommand workspace:next-tab
exmap prevTab obcommand workspace:previous-tab
nnoremap gt :nextTab<CR>
nnoremap gT :prevTab<CR>

" splits & close
exmap splitV obcommand workspace:split-vertical
exmap splitH obcommand workspace:split-horizontal
exmap closeTab obcommand workspace:close
nmap <Space>sv :splitV<CR>
nmap <Space>sh :splitH<CR>
nmap <Space>q :closeTab<CR>

" file explorer & sidebars
exmap openExplorer obcommand notebook-navigator:open
exmap toggleRightSidebar obcommand app:toggle-right-sidebar
nmap <Space>e :openExplorer<CR>
nmap <Space>r :toggleRightSidebar<CR>

" fuzzy find & search
exmap quickSwitcher obcommand switcher:open
exmap globalSearch obcommand global-search:open
exmap commandPalette obcommand command-palette:open
nmap <Space>ff :quickSwitcher<CR>
nmap <Space>fg :globalSearch<CR>
nmap <Space>fc :commandPalette<CR>

