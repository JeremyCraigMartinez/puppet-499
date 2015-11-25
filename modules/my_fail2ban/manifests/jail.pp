class my_fail2ban::jail { 'sshd':
	port     => '22',
	logpath  => '/var/log/secure',
	maxretry => '4',
}	
