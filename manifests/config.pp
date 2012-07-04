# Type: preseed::config
#
# XXX - Add documentation
#
define preseed::config ($path, $package = $name, $service = $name, $ensure = present) {
  
  # Check if the service is defined
  if defined(Service[$service]) {
    $notify_service = Service[$service]
  } else {
    $notify_service = undef
  }
  
  notice "Service: ${notify_service}"
  
  # Copy all the configuration files
  file { "config-${package}-${path}":
    path    => $path,
    recurse => true,
    source  => [
      "puppet:///files/${::fqdn}/config/${package}${path}",
      "puppet:///files/config/${package}${path}",
    ],
    require => Package[$package],
    notify  => $notify_service,
  }
}