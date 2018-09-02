function cdh -d 'cd to a previously visited directory'
  string join \n $dirprev | sed 1d | fzf-tmux --no-multi --tac --tiebreak=index | read -l result; and cd $result
end
