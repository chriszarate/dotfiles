function copy -d 'Copy piped text to clipboard'

  if [ (uname) = 'Darwin' ]
    pbcopy $argv
  end

  if [ (uname) = 'Linux' ]
    xclip -sel clip $argv
  end

end
