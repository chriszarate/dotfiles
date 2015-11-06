function fish_title
  if [ "fish" != "$_" ]
    echo "$_"
  else
    if [ "$PWD" = "$HOME" ]
      echo "~"
    else
      echo (basename $PWD)
    end
  end
end
