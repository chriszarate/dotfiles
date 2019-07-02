set __fish_git_prompt_describe_style 'branch'
set __fish_git_prompt_show_informative_status true

set __fish_git_prompt_color_bare a89984
set __fish_git_prompt_color_branch 665c54
set __fish_git_prompt_color_branch_detached cc241d
set __fish_git_prompt_color_dirtystate d65d0e
set __fish_git_prompt_color_invalidstate cc241d
set __fish_git_prompt_color_merging b16286
set __fish_git_prompt_color_stagedstate 98971a
set __fish_git_prompt_color_stashstate 458588
set __fish_git_prompt_color_untrackedfiles 3c3836
set __fish_git_prompt_color_upstream d79921

set __fish_git_prompt_char_cleanstate ''
set __fish_git_prompt_char_dirtystate ' ◒'
set __fish_git_prompt_char_invalidstate ' (╯°□°)╯︵'
set __fish_git_prompt_char_stagedstate ' ●'
set __fish_git_prompt_char_stashstate '◆'
set __fish_git_prompt_char_stateseparator ''
set __fish_git_prompt_char_untrackedfiles ' ○'
set __fish_git_prompt_char_upstream_ahead ' ▲'
set __fish_git_prompt_char_upstream_behind ' ▼'
set __fish_git_prompt_char_upstream_prefix ''

function g -d 'Change to the root of the current Git repo'
	cd (git rev-parse --show-toplevel)
end

function gh -d 'Open the current branch on GitHub'
	o https://github.com/(git_origin)/tree/(git_branch)
end

function ghi -d 'Open GitHub issues for the current Git repo'
	o https://github.com/(git_origin)/issues
end

function ghp -d 'Open GitHub pull requests for the current Git repo'
	o https://github.com/(git_origin)/pulls
end

function ghpr -d 'Open a GitHub pull request for the current Git repo'
	o https://github.com/(git_origin)/pull/new/(git_branch)
end

