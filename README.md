Puppet Preseed Module
=====================

The Puppet Preseed module, `puppet-preseed`, helps APT package installation
using debconf preseeding and copying static configuration files.


Quick usage example
-------------------

<pre>
preseed::package { 'ntp':
  ensure => installed,
}

service { 'ntp':
  ensure => running,
}

preseed::config { 'ntp':
  path => '/etc/ntp.conf',
}
</pre>


Initializing the client
-----------------------

The `preseed::setup` class initializes the client by creating a working
directory where to store the preseeding files.

It uses the default "${::puppet_vardir}/preseed" location. Currently there
is no need to instantiate the class.


Installing a package
--------------------

Installing and preseeding a package can be done with two parameters

* content: specifying the preseeding file content (allows for templates)
* source: by specifying the PuppetMaster source file

If either parameter is set, then the module will search for the preseeding
file in the following source locations, whichever one happens first

* puppet:///files/${::fqdn}/${name}.preseed
* puppet:///files/${name}.preseed
* puppet:///modules/preseed/empty.preseed (no preseeding)

The following example installs a package without preseeding (if no proper preseed file
is found in the default locations, using the empty.preseed file). 

<pre>
  preseed::package { 'ntp':
    ensure => installed,
  }
</pre>

This example installs a package with the content from a template

<pre>
  preseed::package { 'slapd':
    ensure => installed,
    content => template('ldap/slapd.preseed.erb'),
  }
</pre>

This example installs a package with a static preseed file

<pre>
  preseed::package { 'slapd':
    ensure => installed,
    content => 'puppet:///files/mycompany/global_slapd_config.preseed',
  }
</pre>

This example installs a package with a static preseed file, using the default
locations in the PuppetMaster tree. In order to get the client's default location,
the `${::fqdn}` is used. The preseed file should be named like `${package}.preseed`.

<pre>
/etc/puppet/files
├── test.example.com
│   └── slapd.preseed  (automatic preseed file)
└── slapd.preseed  (fallback preseed file)
</pre>

<pre>
  preseed::package { 'slapd':
    ensure => installed,
  }
</pre>


Configuring a package
---------------------

Configuring a package with static files is done by calling the `preseed::config` defined type,
as many times as needed. As with preseeding, it will look in the Puppet Master tree and copy
recursively the config files from there.

The permissions applied to the copied files are the ones set by the package installation,
or if the file did not previously existed, "root.root rw-r--r--"

The default locations are under the `${::fqdn}/config/${package}` directory and then the
`config/${package}` directory.

<pre>
/etc/puppet/files
├── config
│   └── ntp
│       └── etc
│           └── ntp.conf
└── test.example.com
    └── config
        └── ntp
            └── etc
                └── ntp.conf
</pre>

<pre>
preseed::config { 'ntp':
  path => '/etc/ntp.conf',
  service => 'ntp',
}
</pre>

The `service` parameter allows to notify the service about modifications in the configuration
files.


Known Issues:
-------------

* No uninstallation of packages yet
* Better file permission handling of the config files, maybe use of exclude patterns
* Missing documentation as 13. Puppet Doc style guide
* 11.9 Class parameter defaults style guide conformance

License
-------

This software is distributed under the GNU General Public License
version 3 or any later version.

Copyright
---------

Copyright (C) 2012 Juan Fernandez-Rebollos

