vim9script
# vim: foldmethod=marker foldmarker=[START],[END]
# /- - - - - - - - - - - - - - - - - - - - - -\
#   https://github.com/wordswords/dotfiles
# \- - - - - - - - - - - - - - - - - - - - - -/
#
# [START] Vundle CONFIG
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
# [END] Vundle CONFIG
# [START] Plugins CONFIG
# [END] Plugins CONFIG
Plugin 'elixir-editors/vim-elixir'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'lervag/vimtex'
Plugin 'liuchengxu/vista.vim'
Plugin 'madox2/vim-ai'
Plugin 'reedes/vim-lexical'
Plugin 'reedes/vim-litecorrect'
Plugin 'reedes/vim-pencil'
Plugin 'reedes/vim-textobj-quote'
Plugin 'reedes/vim-textobj-sentence'
Plugin 'reedes/vim-wordy'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'ryanoasis/vim-devicons'
Plugin 'scrooloose/nerdtree'
Plugin 'Shougo/denite.nvim'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'vim-airline/vim-airline'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ycm-core/YouCompleteMe'
# [START] Vundle end CONFIG
call vundle#end()
filetype plugin indent on
# [END] Vundle end CONFIG
# [START] General CONFIG
syntax enable

set autoindent                     # Automatically indent code
set background=dark                # Dark background, light foreground
set backspace=2                    # Backspace back up a line
set backupdir=~/.backup/vim        # Directory to drop backup files
set bk                             # Backup files
set colorcolumn=+1                 # Enable coloured column after textwidth line
set cursorline                     # Highlight current line
set dir=~/.backup/vim/swap         # Directory to drop swap files
set encoding=utf-8                 # Required for YCM
set expandtab                      # Always expand tabs
set history=1000                   # 1000 previous commands remembered
set hlsearch                       # Highlight searches
set ignorecase                     # Ignore case when searching
set incsearch                      # Do incremental searching
set laststatus=2                   # Show non-printable characters e.g. tab, \\n
set list                           # Use the following list characters:
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set ls=2                           # Always show status line
set number                         # Show line numbers
set norelativenumber                 # Set numbering from current line
set ruler                          # Show the cursor position all the time
set scrolloff=3                    # Keep 3 lines when scrolling
set shiftwidth=4                   # With indentation shifts, use 4 space tabs
set showcmd                        # Display incomplete commands
set softtabstop=4                  # With tab key, use 4 space tabs
set spelllang=en_gb                # Set dictionary to be UK spelling
set splitbelow                     # Opens new windows below, not above
set splitright                     # Open new vertical split windows to the right
set t_Co=256                       # Force 256 colour mode
set ts=4                           # Each tab is four spaces
set ttyfast                        # Smoother changes
set undodir=~/.backup/vim/undos    # Directory to drop undo files
set undofile                       # Drop undo files
set wildmenu                       # Allow for menu based file navigation
set wildmode=list:longest,full
# Generate vim helpfiles
:helptags ALL

# no bells, ever
set noerrorbells novisualbell t_vb=
set belloff=all

# map the <leader> character to comma
g:mapleader = ','

# Paste from system clipboard
def PasteFromSystemClipboard(): void
    read ! ~/bin/xclip.sh -o 2>/dev/null
enddef
nnoremap <C-v> :call <SID>PasteFromSystemClipboard()<CR>

# Google Search the selected text
def GoogleSearch(): void
    normal! gv"zy
    redir! > /tmp/googlesearchvim
    echo getreg('z')
    redir END
    silent !~/bin/gg.sh
    redraw!
enddef
vnoremap <leader>g :<c-u>call <SID>GoogleSearch()<CR>

# Format file for code Reddit markdown post
def FormatForReddit(): void
    normal! gv"xy
    redir! > /tmp/formatforredditvim
    silent! echo getreg('x')
    redir END
    sp /tmp/formatforredditvim
    %s/^/     /g
enddef
vnoremap <leader>p :<c-u>call <SID>FormatForReddit()<CR>

# Yank whole file into clipboard
def YankFile(): void
    %yank+
enddef
nnoremap <leader>y :call <SID>YankFile()<CR>

# Foot pedal
nnoremap <F6> i
imap <F6> <Esc>
#
# Dotfiles help toggle
def BringUpDotfilesReadme(): void
    :sp ~/.dotfiles/README.md
    :Vista toc
    nnoremap <leader>h :call <SID>CloseDotfilesReadme()<CR>
enddef
nnoremap <leader>h :call <SID>BringUpDotfilesReadme()<CR>

def CloseDotfilesReadme(): void
    :windo if expand('%:t') == 'README.md' | q! | endif
    :Vista!
    nnoremap <leader>h :call <SID>BringUpDotfilesReadme()<CR>
enddef

# Quickfix list toggle
:autocmd FileType qf wincmd J
def ToggleOnQuickfixList(): void
    :copen
    nnoremap <DOWN> :call <SID>ToggleOffQuickfixList()<CR>
enddef
def ToggleOffQuickfixList(): void
    :cclose
    nnoremap <DOWN> :call <SID>ToggleOnQuickfixList()<CR>
enddef
nnoremap <DOWN> :call <SID>ToggleOnQuickfixList()<CR>

# Location list toggle
def ToggleOnLocationList(): void
    :lopen
    nnoremap <UP> :call <SID>ToggleOffLocationList()<CR>
enddef
def ToggleOffLocationList(): void
    :cclose
    nnoremap <UP> :call <SID>ToggleOnLocationList()<CR>
enddef
nnoremap <UP> :call <SID>ToggleOnLocationList()<CR>

# Git Copilot toggle
def ToggleCopilotOff(): void
    :Copilot disable
    :Copilot status
    nnoremap <silent><leader>c :call <SID>ToggleCopilotOn()<CR>
enddef
nnoremap <silent><leader>c :call <SID>ToggleCopilotOff()<CR>

def ToggleCopilotOn(): void
    :Copilot enable
    :Copilot status
    nnoremap <silent><leader>c :call <SID>ToggleCopilotOff()<CR>
enddef

# Run language tool
nnoremap <silent><leader>l :call <SID>RunTextidoteToggle()<CR>
def RunTextidoteToggle(): void
    compiler textidote|make
enddef

# Set gVIM settings to be the same as the terminal
set t_Co=256

# Stop <> marks being inserted on all filetypes from lh-brackets plugin
g:cb_no_default_brackets = 1

# Turn off macro recording
noremap q <Nop>

# Disable F1 help launcher
nmap <F1> :echo<CR>
nmap <F1> <c-o>:echo<CR>
# Vim fonts for gVIM
set guifont=DroidSansMono\ Nerd\ Font\ 18

# Highlighted ruler for extra focus
highlight CursorLine term=bold cterm=bold guibg=Grey40
highlight CursorColumn term=bold cterm=bold guibg=Grey40
set cursorline cursorcolumn
g:markdown_fenced_languages = ['vim', 'help']
# [END] General CONFIG
# [START] YCM CONFIG
g:ycm_enable_inlay_hints = 1
g:ycm_auto_trigger = 1
g:ycm_enable_semantic_highlighting = 1
g:ycm_always_populate_location_list = 1
imap <silent> <C-l> <Plug>(YCMToggleSignatureHelp)
nmap <C-f> <Plug>(YCMFindSymbolInWorkspace)
# [END] YCM CONFIG
# [START] Third Party Language Serverfs for use with YCM
g:ycm_language_server = [{ name: 'vim', cmdline: ['vim-language-server', '--stdio' ], filetypes: [ 'vim' ]}]
# [END] Third Party Language Serverfs for use with YCM
# [START] Visual selection search options CONFIG
# Search visual selection via stackoverflow
vnoremap <leader>s y:!echo <C-r>=escape(substitute(shellescape(getreg('"')), '\n', '\r', 'g'), '%!')<CR> <Bar> so.sh 2>/dev/null<CR><CR>

# Send visual selection to OpenAI and output the result
vnoremap <leader>o y:read !echo <C-r>=escape(substitute(shellescape(getreg('"')), '\n', '\r', 'g'), '%!')<CR> <Bar> ai.sh 2>/dev/null<CR><CR>
# [END] Visual selection search options CONFIG
# [START] Clipboard synchronisation hackery CONFIG
vnoremap <C-c> "+y
# [END] Clipboard synchronisation hackery CONFIG
# [START] GUI CONFIG
g:prettier#autoformat = 1 # Prettier code formatter automatically files
g:rehash256 = 1 # Ensure 256 colour mode
# [END] GUI config
# [START] Colourscheme CONFIG
# You might have to force true color when using regular vim inside tmux as the
# colorscheme can appear to be grayscale with "termguicolors" option enabled.
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  var &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  var &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

syntax on
set termguicolors
colorscheme molokai
hi SpecialKey ctermfg=grey guifg=grey70
hi NonText ctermfg=grey guifg=grey70
# [END] Colourscheme config
# [START] Modelines CONFIG
set modelines=5
set modeline
# [END] Modelines config
# [START] vim-airline CONFIG
g:airline_theme = 'molokai'
g:airline#extensions#tabline#enabled = 0
g:airline#extensions#tabline#fnamemod = ':t' # Show just the filename
g:airline_powerline_fonts = 1
g:powerline_symbols = 'fancy'
# [END] vim-airline CONFIG
# [START] NERDTree CONFIG
# Start NerdTree when vim is started to edit a directory, except in vimdiff mode
if &diff
    # Do nothing
else
    if (len(expand("%")) > 0)
      autocmd VimEnter * silent NERDTree %
    endif
endif
autocmd VimEnter * wincmd p

# stop NERDTree buffers being lost by disabling buffer next and buffer previous
autocmd FileType nerdtree noremap <buffer> <c-h> <nop>
autocmd FileType nerdtree noremap <buffer> <c-l> <nop>

# if NERDTree is the last window present, i.e: when you've closed all other
# windows, then close vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")) | q | endif

# make NERDTree look nicer
var NERDTreeMinimalUI = 1
var NERDTreeDirArrows = 1

# make sure NERDTree shows hidden files/dirs
var NERDTreeShowHidden = 1

#
# Pressing <LEFT> cursor toggles NerdTree
#
noremap <LEFT> :NERDTreeToggle<CR>
# [END] Nerdtree CONFIG
# [START] Filetype formats/autocmd CONFIG
def SetRestructuredTextOptions(): void
  au BufRead,BufNewFile *.rst setlocal textwidth=80
  setlocal spell
enddef

def SetTextAndMarkdownOptions(): void
  #call pencil#init()
  #call lexical#init()
  #call textobj#quote#init()
  #call textobj#sentence#init()

  g:pencil#joinspaces = 1     # 0=one_space (def), 1=two_spaces
  g:pencil#cursorwrap = 1     # 0=disable, 1=enable (def)
  setlocal spell
  setlocal nowrap # this is required for special text wrapping
enddef

def SetMakefileOptions(): void
  :!ctags -R %
  :Vista ctags
  setlocal noexpandtab
  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal softtabstop=0
enddef

def SetVimFileOptions(): void
    :!ctags -R %
    :Vista ctags
    :sleep 1
    :wincmd p
enddef

def SetPythonFileOptions(): void
  :!ctags -R %
  :Vista ctags
  # To meet PEP8
  setlocal textwidth=79
  setlocal shiftwidth=4
  setlocal tabstop=4
  setlocal expandtab
  setlocal softtabstop=4
  setlocal shiftround
  setlocal autoindent
  setlocal fileformat=unix
enddef

def SetGitCommitFileOptions(): void
  setlocal colorcolumn+=51 # set additional marker for line wrap
  setlocal wrap # Enable word wrap
  setlocal textwidth=70
  setlocal spell # highlight spelling mistakes
enddef

# remove trailing whitespace on these filetypes only:
autocmd FileType text,markdown,Makefile,Jenkinsfile,Python,vim,sh autocmd BufWritePre <buffer> :%s/\s\+$//e
# file-type-specific stuff
autocmd BufRead,BufNewFile *.f90 set filetype=Fortran
autocmd BufRead,BufNewFile *.robot setlocal noexpandtab
autocmd BufRead,BufNewFile Jenkinsfile set filetype=groovy
autocmd BufRead,BufNewFile *.txt,*.md call SetTextAndMarkdownOptions()
autocmd BufRead,BufNewFile Makefile call SetMakeFileOptions()
autocmd BufRead,BufNewFile *.py call SetPythonFileOptions()
autocmd BufRead,BufNewFile .vimrc call SetVimFileOptions()
autocmd FileType gitcommit call SetGitCommitFileOptions()
autocmd FileType plugin indent on " for writing plugins
# [END] Filetype formats/autocmd CONFIG
# [START] Goyo CONFIG
noremap <F12> :Goyo<CR> " this toggles distraction-free mode
# [END] Goyo CONFIG
# [START] Vista CONFIG
g:vista_default_executive = "ctags"
nmap <silent><RIGHT> :Vista!!<ENTER>

# Automatically close vim if vista is the only buffer left
autocmd bufenter * if (winnr("$") == 1 && bufwinnr("__vista__") > 0) | q | endif
# If only NerdTree and Vista buffers are left, automatically close VIM
autocmd bufenter * if (winnr("$") == 2 && bufwinnr("__vista__") > 0 && exists("b:NERDTree")) | qa | endif
# [END] Vista CONFIG
# [START] nerdtree-git-plugin CONFIG
g:NERDTreeGitStatusUseNerdFonts = 1 # default: 0
g:NERDTreeGitStatusShowClean = 1 # default: 0
g:NERDTreeGitStatusUntrackedFilesMode = 'all' # heavy feature default:normal
g:NERDTreeGitStatusShowIgnored = 1 # heavy feature may cost time. default: 0
g:NERDTreeGitStatusIndicatorMapCustom = { Modified: '✹',
                                          Staged: '✚',
                                          Untracked: '✭',
                                          Renamed: '➜',
                                          Unmerged: '═',
                                          Deleted: '✖',
                                          Dirty: '✗',
                                          Ignored: '☒',
                                          Clean: '✔︎',
                                          Unknown: '?', }
# [END] nerdtree-git-plugin CONFIG
# [START] Scrolling VIM9 popups using keyboard CONFIG
def ScrollPopup(nlines: number): void
    var winids = popup_list()
    if len(winids) == 0
        return
    endif

    # Ignore hidden popups
    var prop = popup_getpos(winids[0])
    if prop.visible != 1
        return
    endif

    var fline = prop.firstline
    fline = fline + nlines
    var buf_lastline = str2nr(trim(win_execute(winids[0], "echo line('$')")))
    if fline < 1
        fline = 1
    elseif prop.lastline + nlines > buf_lastline
        fline = buf_lastline + prop.firstline - prop.lastline
    endif

    call popup_setoptions(winids[0], {firstline: fline})
enddef

nnoremap <C-j> :call <SID>ScrollPopup(3)<CR>
nnoremap <C-k> :call <SID>ScrollPopup(-3)<CR>
# [END] Scrolling VIM9 popups using keyboard CONFIG
# [START] wikipedia2text lookup CONFIG
# See: https://github.com/chrisbra/wikipedia2text
# Assumes you have installed the wikipedia2text script to your path
# with the filename 'wp2t'

def WikiLookupPopup(): void
    set mouse=a
    var popup_win = printf("wp2t -s %s", expand('<cword>'))
                  ->system()
                  ->split("\n")
                  ->popup_atcursor({ padding: [1, 1, 1, 1] })

    call setbufvar(winbufnr(popup_win), '&filetype', 'git')
enddef
nnoremap <silent><leader>w :call <SID>WikiLookupPopup()<CR>
# [END] wikipedia2text lookup CONFIG
# [START] JiraIssueLookupPopup lookup CONFIG
def JiraIssueLookupPopup(): void
    set mouse=a
    var popup_win = printf("jira view issue --plain %s", expand('<cword>'))
         ->system()
         ->split("\n")
         ->popup_atcursor({ padding: [1, 1, 1, 1] })
    call setbufvar(winbufnr(popup_win), '&filetype', 'git')
enddef
nnoremap <silent><leader>j :call <SID>JiraIssueLookupPopup()<CR>
# [END] JiraIssueLookupPopup lookup CONFIG
# [START] GitBlaneLine lookup CONFIG
def GitBlameLine(): void
    var popup_win = printf("git -C %s blame -s -L %s,%s -- %s | head -c 8", expand('%:h'), line('.'), line('.'), expand('%:p'))
        ->system()
        ->printf("git -C " .. expand('%:h') .. " log --stat -1 %s")
        ->system()
        ->split("\n")
        ->popup_atcursor({ padding: [0, 1, 1, 1] })

    call setbufvar(winbufnr(popup_win), '&filetype', 'git')
enddef
nnoremap <silent><leader>b :call <SID>GitBlameLine()<CR>
# [END] GitBlaneLine lookup CONFIG
# [START] vim_codex CONFIG
nnoremap <C-x> :CreateCompletion 100<CR>
inoremap <C-x> <Esc>li<C-g>u<Esc>l:CreateCompletion 100<CR>
# [END] vim_codex CONFIG
# [START] vimtex CONFIG
g:vimtex_view_method = 'zathura'
g:vimtex_compiler_method = 'texidote'
g:vimtex_grammar_textidote = {'jar': '~/.dotfiles/textidote.jar'}
g:airline#extensions#vimtex#enabled = 1
# [END] vimtex CONFIG
