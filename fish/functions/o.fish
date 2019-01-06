function o -d 'Open a file or URL'

  if [ (uname) = 'Darwin' ]
    open $argv
  end

  if [ (uname) = 'Linux' ]
    switch $argv
      case "http*"
        xdg-open $argv
      case "*"
        open $argv
    end
  end

end
