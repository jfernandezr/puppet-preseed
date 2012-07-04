# Class: preseed::setup
#
# XXX - Put options for ensure and changing directory
#
class preseed::setup {
  
  # Make sure that the puppet_vardir from stdlib is set
  require stdlib
  if $::puppet_vardir {
    $basedir = "${::puppet_vardir}/preseed"
  }
  else {
    fail("\$::puppet_vardir from puppetlabs/stdlib not defined. Try running again with pluginsync enabled")
  }
  
  # Ensure the preseeding directory exists
  file {
    "${basedir}" :
      ensure => directory,
      owner => 'root',
      group => 'root',
      mode => '0750',
  }
}