class watch {
	file { '/usr/local/bin/watch.sh':
		content => "#!/bin/sh\necho \"Hello World\"\ncat /var/log/syslog > /tmp/syslog",
		owner => 'vagrant',
		group => 'vagrant',
		mode    => 0755, 
	}	

	cron { 'helloworld':   
		command => "/usr/local/bin/watch.sh",   
		user    => root,
		hour    => '*',   
		minute  => '*',
		require => File['/usr/local/bin/watch.sh']
	}
}