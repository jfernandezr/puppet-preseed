# Class: preseed::setup
#
# XXX - Put options for ensure and changing directory
#
class preseed::setup ($preseed_dir = undef) {
  
  # Make sure that the puppet_vardir from stdlib is set
  require stdlib
  
  # Get the preseed directory from the parameter
  if ($preseed_dir != undef) {
  	$basedir = $preseed_dir
  }
  # Compose from the Puppet client vardir
  elsif $::puppet_vardir {
    $basedir = "${::puppet_vardir}/preseed"
  }
  # Nowhere to set it, fail
  else {
    fail("\$::puppet_vardir from puppetlabs/stdlib not defined. Try running again with pluginsync enabled or define the \$preseed_dir parameter")
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