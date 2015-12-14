node 'pnode1' {

  #Firewall
  include my_firewall

  # Fail2ban
  class { 'fail2ban':
    jails_config   => 'concat',
  }
  fail2ban::jail { 'sshd':
    port     => '22',
    logpath  => '/var/log/secure',
    maxretry => '2',
  }

  # SSH
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
  }  

  # Sudoers
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

  # APT
  include apt

  # Syslog
  include syslog

  # Path
  include path
}