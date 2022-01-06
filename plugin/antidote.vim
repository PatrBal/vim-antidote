" Description: Spellcheck with Antidote.app from Vim
" Author: Patrick Ballard <patrick.ballard.paris@gmail.com>
" License: MIT


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
vnoremap <silent> <Leader>an :<C-U>call antidote#VisualAntidote()<CR>
nnoremap <silent> <Leader>an :call antidote#NormalAntidote()<CR>
command -range=% Antidote call antidote#CommandAntidote(<line1>,<line2>)

function! AntidoteDict(word)
	call system("osascript -e \'tell application \"AgentAntidoteConnect\" to lance module dictionnaires ouvrage definitions mot \"" . a:word . "\"\'")
	redraw!
endfunction

function! AntidoteConjug(word)
	call system("osascript -e \'tell application \"AgentAntidoteConnect\" to lance module dictionnaires ouvrage conjugaison mot \"" . a:word . "\"\'")
	redraw!
endfunction

scriptencoding utf-8

" Enable "C-@" to call the definition of the current word in normal and visual modes
" (oddly "C-@" is referred to a <C-Space> in Vim)
nnoremap <C-Space> "dyiw:call AntidoteDict(@d)<CR>
vnoremap <C-Space> "dy:call AntidoteDict(@d)<CR>
