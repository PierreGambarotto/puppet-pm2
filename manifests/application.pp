# dependancies : pm2, ssh_authorized_keys

define pm2::application(
  $app_name = $name,
  $username = $app_name,
  $directory = "/usr/local/${app_name}",
  $ensure_service = false,
  $ssh_login_keytype = undef,
  $ssh_login_pubkey = undef
  ){
  require pm2
  # user to run the service
  user{$username:
    ensure => present,
    comment => "${app_name} manager",
    home => $directory,
    shell => '/bin/bash',
    managehome => true,
  } ->
  file{"${directory}/.ssh":
    ensure => directory,
    owner => $username,
    group => $username,
    mode => 0700
  }  


  if ($ssh_login_keytype and $ssh_login_pubkey){
    ssh_authorized_key{"manager of ${app_name}":
      user => $username,
      type => $ssh_login_keytype,
      key => $ssh_login_pubkey
    }
  }

  if ($ensure_service){
    exec{"generates pm2 init script for user ${username} managing application ${app_name}":
      require => Package[pm2],
      provider => shell,
      command => "/usr/bin/pm2 startup -s --no-daemon -u ${username}",
      creates => "/etc/init.d/pm2-init-${app_name}.sh"
    }  ->
    service{"pm2-init-${app_name}.sh":
      ensure => true,
      enable => true,
      hasrestart => true
    }
  }
  
}
