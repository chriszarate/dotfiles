function g -d 'Change to the root of the current Git repo'
	cd (git rev-parse --show-toplevel)
end
