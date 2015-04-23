# == Class: pm2
#
# Installs pm2 with npm from node.js puppet module
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the function of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'pm2':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Pierre Gambarotto <pierre.gambarotto@enseeiht.fr>
#
# === Copyright
#
# Copyright 2015 Pierre Gambarotto
#
class pm2($version = present) {
  require nodejs

  package { 'pm2':
    require => Class['nodejs'],
    provider => 'npm',
    ensure => $version
  }

}
