function ips -d 'Show known IP addresses for this machine.'
  echo -e "OpenDNS:\n--------"
  dig +short myip.opendns.com @resolver1.opendns.com
  echo -e "\nifconfig:\n---------"
  ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, ""); print }'
end
