" Description: Spelling and grammar checking with Antidote.app from Vim
" Author:      Patrick Ballard <patrick.ballard.paris@gmail.com>
" Last Change: 21/11/2022


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

""" Do not load if the system is not macOS
if !(has('unix') && system('uname') =~? 'Darwin')
	finish
endif


" Antidote spellchecking
command -range=% Antidote call antidote#CommandAntidote(<line1>,<line2>)
vnoremap <silent> <Leader>an :<C-U>call antidote#VisualAntidote()<CR>
nnoremap <silent> <Leader>an :Antidote<CR>

function! s:AntidoteDict(word)
	call system("osascript -e \'tell application \"AgentAntidoteConnect\" to lance module dictionnaires ouvrage definitions mot \"" . a:word . "\"\' - e \'tell application \"Antidote 11\" to activate\'")
	redraw!
endfunction

function! s:AntidoteDictVisual(type)
	let saved_unnamed_register = @@
	if a:type ==#'v'
		normal! `<v`>y
	else
		return
	endif
	call system("osascript -e \'tell application \"AgentAntidoteConnect\" to lance module dictionnaires ouvrage definitions mot \"" . @@ . "\"\'")
	let @@ = saved_unnamed_register
endfunction

nnoremap <silent> <C-@> :call <SID>AntidoteDict(expand('<cword>'))<CR>
vnoremap <silent> <C-@> :<C-U>call <SID>AntidoteDictVisual(visualmode())<CR>

" Enable "C-@" to call the definition of the current word in normal and visual modes
" (oddly "C-@" is referred to a <C-Space> in Vim)
" nnoremap <C-Space> "dyiw:call AntidoteDict(@d)<CR>
" vnoremap <C-Space> "dy:call AntidoteDict(@d)<CR>
