class git {

  package { 'patterns-openSUSE-minimal_base':
    ensure => absent
  }

  package { 'git':
    ensure  => installed,
    require => Package['patterns-openSUSE-minimal_base']
  }

  file { '/etc/gitconfig':
    ensure  => present,
    content => template('git/gitconfig.erb')
  }

  file { '/etc/gitignore':
    ensure  => present,
    content => template('git/gitignore.erb')
  }

  define rc($ensure, $name, $home, $group) {
    $user = $title

    file {"${user}/gitrc":
      ensure  => $ensure,
      path    => "${home}/.gitconfig",
      require => File["${user}/home"],
      owner   => $user,
      group   => $group,
      content => template('git/gitrc.erb'),
    }
  }

}
