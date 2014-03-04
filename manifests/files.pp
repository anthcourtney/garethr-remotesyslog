define remotesyslog::files {
  $logs = []
) {

  concat::fragment { "remotesyslog_files_${title}":
    target => '/etc/log_files.yml',
    content => template("etc/log_files_logs.yml.erb"),
    order => '10',
    notify => Service['remote_syslog']
  }

}
