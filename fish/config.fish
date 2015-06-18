for file in aliases prompt
  source ~/.config/fish/inc/$file.fish
end

if [ (uname) = 'Darwin' ]
  source ~/.config/fish/inc/aliases-osx.fish
end
