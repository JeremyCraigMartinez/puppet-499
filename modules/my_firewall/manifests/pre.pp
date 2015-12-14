 class my_firewall::pre {

  firewall { '000 accept all icmp':
    proto   => 'icmp',
    action  => 'accept',
  }

  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }

  firewall { '002 accept related established rules':
    proto   => 'all',
    state   => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
  }

  # Allow SSH
  firewall { '100 allow ssh access':
    dport   => '22',
    proto  => tcp,
    action => accept,
  }

  # Allow SMTP
  firewall { '100 allow SMTP access':
    dport   => '25',
    proto  => tcp,
    action => accept,
  }

}
