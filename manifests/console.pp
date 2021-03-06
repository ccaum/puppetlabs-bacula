# Class: bacula::console
#
# This class manages the bconsole application
#
# Parameters:
#   $director_server:
#     The FQDN of the director
#   $director_password:
#     The password of the director
#   $template:
#     The template to use to generate teh bconsole.conf file (Optional)
#     - Default: 'bacula/bconsole.conf.erb'
#     
# Sample Usage:
#
# class { 'bacula::console':     
#   director_server   => 'bacula.domain.com',
#   director_password => 'XXXXXXXX',
# }
class bacula::console(
    $director_server,
    $director_password,
    $template = 'bacula/bconsole.conf.erb'
  ) {

  $director_name_array = split($server, '[.]')
  $director_name = $director_name_array[0]

  package { 'bacula-console':
    ensure => 'latest';
  }

  file { '/etc/bacula/bconsole.conf':
    ensure  => file,
    owner   => 'bacula',
    group   => 'bacula',
    content => template($template),
    require => Package['bacula-console'],
  }
}
