# Test

preseed::package { 'ntp':
  ensure => installed,
}

service { 'ntp':
  ensure => running,
}

preseed::config { 'ntp':
  path => '/etc/ntp.conf',
  service => 'ntp',
}
