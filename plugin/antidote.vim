" Description: Spelling and grammar checking with Antidote.app from Vim
" Author:      Patrick Ballard <patrick.ballard.paris@gmail.com>
" Last Change: 06/01/2022


if &cp || exists("g:loaded_antidote")
 finish
endif
let g:loaded_antidote = "1"

if !exists('g:antidote_application')
	let g:antidote_application = '/Applications/Antidote/Antidote 11.app'
endif

if empty(glob(g:antidote_application))
	finish
endif

if !has('unix') " macOS's vim, nvim and MacVim have this feature
	finish
endif


" Antidote spellchecking
command -range=% Antidote call antidote#CommandAntidote(<line1>,<line2>)
vnoremap <silent> <Leader>an :<C-U>call antidote#VisualAntidote()<CR>
nnoremap <silent> <Leader>an :Antidote<CR>

function! AntidoteDict(word)
	call system("osascript -e \'tell application \"AgentAntidoteConnect\" to lance module dictionnaires ouvrage definitions mot \"" . a:word . "\"\'")
	redraw!
endfunction

" Enable "C-@" to call the definition of the current word in normal and visual modes
" (oddly "C-@" is referred to a <C-Space> in Vim)
nnoremap <C-Space> ":call AntidoteDict(<cword>)<CR>
vnoremap <C-Space> :call AntidoteDict(<cword>)<CR>
" nnoremap <C-Space> "dyiw:call AntidoteDict(@d)<CR>
" vnoremap <C-Space> "dy:call AntidoteDict(@d)<CR>
