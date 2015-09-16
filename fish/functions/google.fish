if [ (uname) = 'Darwin' ]
  function google -d 'Open a Google search for the supplied terms in the default browser.'
    open "https://www.google.com/search?q=$argv"
  end
end
