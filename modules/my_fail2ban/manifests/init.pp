class { 'my_fail2ban':
	# fail2ban configuration
	include fail2ban

  resources { "fail2ban":
     purge => true
  }
}