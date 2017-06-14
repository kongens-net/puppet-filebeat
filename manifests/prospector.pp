define filebeat::prospector (
  $ensure                = present,
  $config
) {

  $wrapped_config = {
    'filebeat' => {
      'prospectors' => [$config]
    }
  }
  file { "filebeat-${name}":
    ensure       => $ensure,
    path         => "${filebeat::config_dir}/${name}.yml",
    owner        => 'root',
    group        => 'root',
    mode         => $::filebeat::config_file_mode,
    content      => hash2yaml($wrapped_config),
    validate_cmd => "/usr/share/filebeat/bin/filebeat -N -configtest -c %",
    notify       => Service['filebeat'],
  }
}
