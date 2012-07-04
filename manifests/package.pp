# Type: preseed::package
#
# XXX - Add documentation
#
define preseed::package ($ensure = present, $content = undef, $source = undef) {
  
  # Make sure the preseed setup module is initialized
  require preseed::setup
  
  # Put the preseeding file in the preseeding directory
  if ($content != undef) {
    
    # Content comes straight from the argument
    file { "${preseed::setup::basedir}/${name}.preseed":
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0640',
      content => $content,
      require => File[$preseed::params::basedir],
    }
    
  } else {
    
    # Content comes from the source argument
    file { "${preseed::setup::basedir}/${name}.preseed":
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0640',
      source  => $source ? {
        undef   => [
          "puppet:///files/${::fqdn}/${name}.preseed",
          "puppet:///files/${name}.preseed",
          "puppet:///modules/preseed/empty.preseed",
        ],
        default => $source
      },
      require => File[$preseed::setup::basedir],
    }
  }
  
  # Install the package accordingly
  package { $name:
    ensure       => installed,
    alias        => alias,
    responsefile => "${preseed::setup::basedir}/${name}.preseed",
    require      => File["${preseed::setup::basedir}/${name}.preseed"],
  }
  
}