default['loggly']['token'] = nil
default['loggly']['tags'] = []

default['loggly']['log_files'] = []
default['loggly']['log_dirs'] = []

default['loggly']['tls']['enabled'] = true
default['loggly']['tls']['cert_path'] = '/etc/rsyslog.d/keys/ca.d'
default['loggly']['tls']['cert_url'] = 'https://logdog.loggly.com/media/loggly.com.crt'
default['loggly']['tls']['cert_checksum'] = 'e65a3dd6eafe4c46d7c171f871bf022ab7d4e551'
default['loggly']['tls']['intermediate_cert_url'] = 'https://certs.starfieldtech.com/repository/sf_bundle.crt'
default['loggly']['tls']['intermediate_cert_checksum'] = '9f4b50011bdeabda276c9dd08f32f545218ea1b7'

default['loggly']['rsyslog']['host'] = 'logs-01.loggly.com'
default['loggly']['rsyslog']['port'] = node['loggly']['tls']['enabled'] ? 6514 : 514

default['loggly']['rsyslog']['repeat_msg'] = true
default['loggly']['rsyslog']['file_owner'] = 'syslog'
default['loggly']['rsyslog']['file_group'] = 'adm'
default['loggly']['rsyslog']['file_create_mode'] = '0640'
default['loggly']['rsyslog']['dir_create_mode'] = '0755'
default['loggly']['rsyslog']['umask'] = '0022'
default['loggly']['rsyslog']['priv_drop_to_user'] = 'syslog'
default['loggly']['rsyslog']['priv_drop_to_group'] = 'syslog'
default['loggly']['rsyslog']['work_directory'] = '/var/spool/rsyslog'
default['loggly']['rsyslog']['input_file_poll_interval'] = 10
