class apt {
	exec { "apt-get update":
		command => "/usr/bin/apt-get update",
		onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
	}

	package { "inotify-tools":
		ensure  => latest,
		require  => Exec['apt-get update'],
	}

	package { "sendEmail":
		ensure  => latest,
		require  => Exec['apt-get update'],
	}
}