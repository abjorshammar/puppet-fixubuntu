class fixubuntu (
  $enabled = true,
  $scriptPath = '/usr/local/bin',
  ) {
  if $enabled {
    if $::unity_remote_content_search != 'none' {
      case $::lsbdistrelease {
        '12.10', '13,04', '13.10', '14.04': {
          $filename = 'fixubuntu.sh'

          file { $filename:
            ensure => file,
            path   => "${scriptPath}/${filename}",
            owner  => 'root',
            group  => 'root',
            mode   => '0755',
            source => "puppet:///modules/fixubuntu/${filename}",
          }

          exec { 'fixubuntu':
            command => "${scriptPath}/${filename}",
            timeout => 30,
            require => File[$filename],
          }

        }
        default: {
          notify {"This module is only relevant for 12.10 - 14.04. Your lsbdistrelease is identified as \"${::lsbdistrelease}\".":}
        }
      }
    }
  }
}
