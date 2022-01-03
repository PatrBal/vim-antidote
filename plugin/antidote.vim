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

" Get default browser
" let g:defaultBrowser = system("defaults read ~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure | awk -F\'\"\' \'/http;/{print window[(NR)-1]}{window[NR]=$2}\'")
" if g:defaultBrowser =~ 'safari' || g:defaultBrowser == ''
" 	"if Safari is the only Browser installed or if another Browser is installed and has never had a default Browser set, then by default nothing will be returned by the "defaults ..." command, and this means Safari is the default Browser
" 	let g:defaultBrowser = 'Safari'
" elseif g:defaultBrowser =~ 'chrome'
" 	let g:defaultBrowser = 'Google Chrome'
" elseif g:defaultBrowser =~ 'firefox'
" 	let g:defaultBrowser = 'Firefox'
" else
" 	echom "Unknown default browser."
" 	finish
" endif


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

" Enable "alt-@" to call the definition of the current word in normal and visual modes
" nnoremap • "dyiw:call AntidoteDict(@d)<CR>
" vnoremap • "dy:call AntidoteDict(@d)<CR>
" Enable "alt-shift-@" to call the conjugation of the current word in normal and visual modes
" nnoremap Ÿ "dyiw:call AntidoteConjug(@d)<CR>
" vnoremap Ÿ "dy:call AntidoteConjug(@d)<CR>
