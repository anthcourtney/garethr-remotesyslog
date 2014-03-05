# == Class remotesyslog::config
#
# This class is called from remotesyslog
#
class remotesyslog::config {
  file { '/etc/init/remote_syslog.conf':
    source => 'puppet:///modules/remotesyslog/etc/init/remote_syslog.conf'
  }

  file { '/etc/init.d/remote_syslog':
    ensure => link,
    target => '/lib/init/upstart-job',
  }

  concat { "/etc/log_files.yml" : }

  # files fragment
  concat::fragment{ 'remotesyslog_log_files_header':
    target => "/etc/log_files.yml",
    content => "files:\n",
    order => 01
  }

  # cert/destination fragment
  concat::fragment{ 'remotesyslog_log_files_footer':
    target => "/etc/log_files.yml",
    content => template("etc/log_files_footer.yml.erb"),
    order => 99
  }

}
