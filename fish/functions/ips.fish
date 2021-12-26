function ips -d 'Show known IP addresses for this machine.'
	echo -e "ifconfig.me:\n--------"
	curl ifconfig.me
	echo -e "\n"

	echo -e "google:\n--------"
	dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'"' '{ print $2}'
	echo ""

	echo -e "ifconfig:\n---------"
	ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, ""); print }'
end
