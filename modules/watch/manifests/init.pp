class watch {
	file { 'watch.sh':
		ensure => 'file',
		source => "puppet:///modules/watch/watch.sh",
		path => '/usr/local/bin/watch.sh',
		owner => 'vagrant',
		group => 'vagrant',
		mode    => 0755, 
	}	

	file { 'reportToMaster.sh':
		ensure => 'file',
		source => "puppet:///modules/watch/reportToMaster.sh",
		path => '/usr/local/bin/reportToMaster.sh',
		owner => 'vagrant',
		group => 'vagrant',
		mode    => 0755, 
	}	

	file { 'ssmtp.conf':
		ensure => 'present',
		source => "puppet:///modules/watch/config/ssmtp.conf",
		path => '/etc/ssmtp/ssmtp.conf',
		owner => 'root',
		group => 'root',
		mode    => 0644, 
	}

	file { '/tmp/syslog':
		ensure => 'directory',
		owner => 'vagrant',
		group => 'vagrant',
	}

	file { 'syslog.old':
		ensure => 'present',
		path => '/tmp/syslog/syslog.old',
		owner => 'vagrant',
		group => 'vagrant',
		mode    => 0666, 
	}	

	file { 'syslog.diff':
		ensure => 'present',
		path => '/tmp/syslog/syslog.diff',
		owner => 'vagrant',
		group => 'vagrant',
		mode    => 0666, 
	}	

	cron { 'newSyslogInfo':   
		command => "/usr/local/bin/watch.sh",   
		user    => root,
		hour    => '*',   
		minute  => '*/2',
		require => File['watch.sh','syslog.old','syslog.diff']
	}

	cron { 'report':   
		command => "/usr/local/bin/reportToMaster.sh",   
		user    => root,
		hour    => '*',   
		minute  => '*/2',
		require => [
			File['reportToMaster.sh'],
			Cron['newSyslogInfo']
		],
	}
}