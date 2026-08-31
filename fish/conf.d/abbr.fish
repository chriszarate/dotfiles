# Short names for commands that need no logic of their own.
#
# These used to be functions. Abbreviations are a better fit for a plain
# rename: the real command appears on the command line before it runs, so it
# can be edited, and the shell history records what actually ran rather than
# the nickname. Anything with branching or arguments to inspect stays a
# function in fish/functions. So does `vim`: an abbreviation only expands when
# you type a space or enter right after it, so a pasted command line leaves the
# cursor on the last argument and `vim` never becomes `nvim`.
#
# Two things to know. Abbreviations only expand at an interactive prompt, so a
# script or a `fish -c` call gets the real command — see kitty/inc/maps.conf,
# which spells out nvim for that reason. And completions arrive only after the
# expansion, so tab completion works on `bat`, not on the half-typed `cat`.

abbr --add brewdump 'brew bundle dump --force'
abbr --add cat bat
abbr --add icat 'kitty +kitten icat'
abbr --add ni 'npm i --save-exact'
abbr --add top htop
abbr --add vi 'nvim -u NONE'
abbr --add yy yazi
