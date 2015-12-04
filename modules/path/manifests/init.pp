class path {
	file { 'inotifywaitpath.sh':
		ensure => 'file',
		source => "puppet:///modules/path/inotifywaitpath.sh",
		path => '/usr/local/bin/inotifywaitpath.sh',
		owner => 'vagrant',
		group => 'vagrant',
		mode    => 0755,
		notify => Exec["inotifywaitpath.sh"]
	}

	exec {
		'inotifywaitpath.sh':
			command => '/usr/local/bin/inotifywaitpath.sh',
			refreshonly => true,
	}
}