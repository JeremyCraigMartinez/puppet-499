class syslog {
	file { 'syslog.sh':
		ensure => 'file',
		source => "puppet:///modules/syslog/syslog.sh",
		path => '/usr/local/bin/syslog.sh',
		owner => 'vagrant',
		group => 'vagrant',
		mode    => 0755, 
	}	

	file { 'reportToMaster.sh':
		ensure => 'file',
		source => "puppet:///modules/syslog/reportToMaster.sh",
		path => '/usr/local/bin/reportToMaster.sh',
		owner => 'vagrant',
		group => 'vagrant',
		mode    => 0755, 
	}	

	file { 'ssmtp.conf':
		ensure => 'present',
		source => "puppet:///modules/syslog/config/ssmtp.conf",
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
		command => "/usr/local/bin/syslog.sh",   
		user    => root,
		hour    => '*',
		minute  => '*/20', 
		require => File['syslog.sh','syslog.old','syslog.diff']
	}

	cron { 'report':   
		command => "/usr/local/bin/reportToMaster.sh",   
		user    => root,
		hour    => '*',   
		minute  => '*/20',
		require => [
			File['reportToMaster.sh'],
			Cron['newSyslogInfo']
		],
	}
}