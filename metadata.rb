name             'loggly-rsyslog'
maintainer       'Matt Veitas'
maintainer_email 'mveitas@gmail.com'
license          'Apache 2.0'
description      'Configures rsyslog to send logs to Loggly'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.1.0'

supports 'ubuntu', '>= 12.04'

depends "rsyslog", "~> 1.5.0"

