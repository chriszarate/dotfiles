function fish_title

  switch $_

    # If we're sitting a prompt, use the current working directory.
    case fish
      # If we're in the home directory, use "~" as shorthand.
      if [ "$PWD" = "$HOME" ]
        echo "~"
      else
        echo (basename $PWD)
      end

    # If we're SSHing, attempt to extract the hostname.
    case ssh
      echo "$argv[1]" | awk '{ for(i=NF; i>0; i--) { if(match($i, /^[^\-]/)) {print $i; break} } }'

    # Ignore some commands.
    case cd
    case ls

    # Otherwise just use the command name.
    case '*'
      echo "$_"

  end

end
