# Type: preseed::config
#
# XXX - Add documentation
#
define preseed::config ($path, $package = 'UNSET', $service = undef, $ensure = present) {
  
  # Get the default values
  $package_real = $package ? {
  	'UNSET' => $name,
  	default => $package,
  }
  
  # Check if the service is defined
  if defined(Service[$service]) {
    $notify_service = Service[$service]
  } else {
    $notify_service = undef
  }
  
  # Copy all the configuration files
  file { "config-${package_real}-${path}":
    path    => $path,
    recurse => true,
    source  => [
      "puppet:///files/${::fqdn}/config/${package_real}${path}",
      "puppet:///files/config/${package_real}${path}",
    ],
    require => Package[$package_real],
    notify  => $notify_service,
  }
}