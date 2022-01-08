# vim-antidote

## Description

This plugin interfaces Vim with [Antidote][Antidote] for efficient spell-checking and grammar checking from inside Vim. `Antidote` is a very complete proprietary dictionary application maintained and distributed by the Canadian company Druide. It can perform not only spell checking, but also thorough grammar checking. `Antidote` can handle LaTeX and Markdown markup. At the present time, it is limited to the English and French languages only.

The plugin provides a new :Antidote command and (recommended) mappings.

WARNING: this version of `vim-antidote` is a Mac only plugin, so you will not benefit
from using `vim-antidote` on Linux nor Windows. It can be installed on those systems,
however, but it will not load.

## Installation

Install using your favorite package manager, or use Vim's built-in package
support:

    mkdir -p ~/.vim/pack/PatrBal/start
    cd ~/.vim/pack/PatrBal/start
    git clone https://github.com/PatrBal/vim-antidote
    vim -u NONE -c "helptags vim-antidote/doc" -c q

## Usage
 - `:[range]Antidote`  where the default `[range]` is the whole buffer.
 - `<Leader>an`  to run spellcheck in visual or normal modes
 - `<C-@>` to call the definition of the current word under the cursor

## Features
 - Spellcheck of either the entire buffer or part of it.
 - Validated corrections in Antidote are reimported in Vim.
 - Show definition in Antidote of the current word.

## Open task
[ ] Add support for Windows and Linux


## License

Copyright (c) Patrick Ballard.  Distributed under the same terms as Vim itself.
See `:help license`.

[Antidote]: https://www.antidote.info/en

