if [ (uname) = 'Darwin' ]
  function cdf -d 'Change to directory of the frontmost Finder window.'
    cd (osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')
  end
end
