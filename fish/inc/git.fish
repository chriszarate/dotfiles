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

