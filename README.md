#CptS 499 - Puppet

##Setup - Puppet Master


	cd ~; wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
	sudo dpkg -i puppetlabs-release-trusty.deb
	sudo apt-get update
	sudo apt-get install puppetmaster-passenger
	# you can stop the puppet master by stopping apache2 service
	sudo service apache2 stop

	# next lock the version of puppet so you don't override with other versions

	# print version (3.8.4 in this case)
	puppet help | tail -n 1

	#create file
	sudo vim /etc/apt/preferences.d/00-puppet.pref

	: <<'FILESETUP'
	# FOR /etc/apt/preferences.d/00-puppet.pref
	Package: puppet puppet-common puppetmaster-passenger
	Pin: version 3.8*
	Pin-Priority: 501
	FILESETUP

	# detele any existing certificates
	sudo rm -rf /var/lib/puppet/ssl

	sudo vim /etc/puppet/puppet.conf

	: <<'FILESETUP'
	[main]
	logdir=/var/log/puppet
	vardir=/var/lib/puppet
	ssldir=/var/lib/puppet/ssl
	rundir=/var/run/puppet
	factpath=$vardir/lib/facter

	[master]
	# These are needed when the puppetmaster is run by passenger
	# and can safely be removed if webrick is used.
	ssl_client_header = SSL_CLIENT_S_DN 
	ssl_client_verify_header = SSL_CLIENT_VERIFY

	certname = puppet
	dns_alt_names = puppet,puppet.puppetnetwork.com
	FILESETUP

	# generate new certificate
	sudo puppet master --verbose --no-daemonize

	# base file
	sudo touch /etc/puppet/manifests/site.pp

	# start apache2 back up
	sudo service apache2 start

##Setup - Puppet Master


	cd ~; wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
	sudo dpkg -i puppetlabs-release-trusty.deb
	sudo apt-get update
	sudo apt-get install puppet
	sudo vim /etc/default/puppet

	# changes to /etc/default/puppet
	: <<'FILECHANGE'
	START=yes
	FILECHANGE

	sudo vi /etc/apt/preferences.d/00-puppet.pref
	: <<'FILESETUP'
	# /etc/apt/preferences.d/00-puppet.pref
	Package: puppet puppet-common
	Pin: version 3.6*
	Pin-Priority: 501
	FILESETUP

	sudo vim /etc/puppet/puppet.conf
	# [agent]
	# server = puppet.nyc2.example.com

	sudo service puppet start

##Back on Master (signing request from agent)

	# to list all unsigned certificate requests
	sudo puppet cert list
	# output: "pnode1.puppetnetwork.com" (SHA256) B1:96:ED:1F:F7:1E:40:53:C1:D4:1B...
	sudo puppet cert sign pnode1.puppetnetwork.com