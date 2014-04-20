require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe file("/etc/rsyslog.d/10-loggly.conf") do
  it { should be_file }
  it { should contain "[logglytoken12345@41058 \] %msg%" }
  it { should contain "$DefaultNetstreamDriverCAFile /etc/rsyslog.d/keys/ca.d/loggly_full.crt" }
  it { should contain "$ActionSendStreamDriver gtls" }
  it { should contain "$ActionSendStreamDriverMode 1" }
  it { should contain "$ActionSendStreamDriverAuthMode x509/name" }
  it { should contain "$ActionSendStreamDriverPermittedPeer \*\.loggly.com" }
end

describe service('rsyslog') do
  it { should be_enabled }
  it { should be_running }
end