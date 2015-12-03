node 'pnode1' {
	include my_firewall

	# fail2ban configuration
	class { 'fail2ban':
		jails_config   => 'concat',
	}
	fail2ban::jail { 'sshd':
		port     => '22',
		logpath  => '/var/log/secure',
		maxretry => '2',
	}	

	# ssh configuration
	class { 'ssh':
	  storeconfigs_enabled => false,
	  server_options => {
	    'Match User www-data' => {
	      'ChrootDirectory' => '%h',
	      'ForceCommand' => 'internal-sftp',
	      'PasswordAuthentication' => 'yes',
	      'AllowTcpForwarding' => 'no',
	      'X11Forwarding' => 'no',
	    },
	    'Port' => [22], #change ssh port
	  },
	  #client_options => {
	  #  'Host *.amazonaws.com' => {
	  #    'User' => 'ec2-user',
	  #  },
	  #},
	  #users_client_options => {
	  #  'bob' => {
	  #    options => {
	  #      'Host *.alice.fr' => {
	  #        'User' => 'alice',
	  #      },
	  #    },
	  #  },
	  #},
	}	

  # sudoers configuration
  class { 'sudo':
  	sudoers => {
  		"worlddomination" => {
			  ensure   => 'present',
			  comment  => 'World domination.',
			  users    => ['vagrant','tester'],
			  hosts    => ['127.0.0.*'],
			  runas    => ['root'],
			  cmnds    => ['ALL'],
			  tags     => ['NOPASSWD'],
			  defaults => [ 'env_keep += "SSH_AUTH_SOCK"' ]	  			
  		}
  	}
	}

	include apt

	include watch
}