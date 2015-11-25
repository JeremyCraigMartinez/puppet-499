class { 'my_fail2ban::post':
	fail2ban { "":
		jails_config   => 'concat',
	}
}