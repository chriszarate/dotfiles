function pass -d 'Search Bitwarden entries and copy password to clipboard'
  set -l session_token (sudo cat ~/.ssh/secrets/bw)
  set -l selected_pass (bw list items --session $session_token --search "$argv[1]" | jq -r '.[] | .name + ": " + .login.username + "\t" + .login.password' | fzf --with-nth=1 --delimiter="\t" | awk -F'\t' '{print $2}')

  # If selection is not empty, get the password and copy to clipboard
  if [ -n "$selected_pass" ]
    echo -n "$selected_pass" | pbcopy
    echo "Password copied to clipboard."
  end
end
