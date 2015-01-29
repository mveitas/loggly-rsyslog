require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe file("/etc/rsyslog.d/22-loggly.conf") do
  it { should be_file }
  it { should contain "[logglytoken12345@41058 \] %msg%" }
  it { should_not contain "$ActionSendStreamDriver gtls" }
  it { should_not contain "$ActionSendStreamDriverMode 1" }
end

describe service('rsyslog') do
  it { should be_enabled }
  it { should be_running }
end
