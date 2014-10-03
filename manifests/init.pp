class fixubuntu (
  $enabled = true,
  $scriptPath = '/usr/local/bin',
  ) {
  if $enabled {
    if ${::unity_remote_content_search} != 'none' {
      case $::lsbdistrelease {
        '12.10', '13,04', '13.10', '14.04': {
          $filename = 'fixubuntu.sh'

          file {${filename}:
            path   => ${scriptPath}/${filename},
            ensure => file,
            owner  => 'root',
            group  => 'root',
            mode   => '0755',
            source => "puppet:///modules/fixpuppet/${filename}",
          }

          exec {'fixubuntu':
            path    => ${scriptPath},
            command => ${filename},
            timeout => 30,
            require => File["${filename}"],
          }

        }
        default: {
          fail("This module is only relevant for 12.10 - 14.04. Your lsbdistrelease is identified as <${::lsbdistrelease}>.")
        }
      }
    }
  }
}
