
$node_version = "v0.10.5"

file { '/etc/motd':
	content => "

  Node Dev VM

      - OS:      Ubuntu precise-server-cloudimg-amd64
      - Node:    ${node_version}
      - IP:      192.168.33.10
      - Code:    ~/code/app
\n"
}

# Make all the magic happen by instantiating the app class
class { app:
	node_version => $node_version
}

