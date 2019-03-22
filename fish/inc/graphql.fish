function torelay -d 'Generate a Relay ID from a type and an ID'
	node -e "process.stdout.write(Buffer.from(process.argv[1]+':'+process.argv[2]).toString('base64'));"
end

function fromrelay -d 'Decode the ID from a Relay ID'
	node -e "process.stdout.write(Buffer.from(process.argv[1], 'base64').toString().split(':')[1]);"
end

