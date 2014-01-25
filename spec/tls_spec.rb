require 'spec_helper'

describe 'loggly-rsyslog::tls' do
  
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set['loggly']['token'] = 'some_token_value'
    end.converge(described_recipe)
  end

  it 'uses 6514 as the port' do
    expect(chef_run.node['loggly']['rsyslog']['port']).to eq 6514
  end

  it 'does not install the rsyslog-gnutls package' do
    expect(chef_run).to install_package('rsyslog-gnutls')    
  end

  it 'creates a directory for the certificate' do
    expect(chef_run).to create_directory('/etc/rsyslog.d/keys/ca.d').with(
      owner: 'root',
      group: 'syslog',
      mode: 0750
    )
  end

  it 'installs the rsyslog-gnutls package' do
    expect(chef_run).to install_package('rsyslog-gnutls')
  end

  it 'downloads the certifcates' do
    expect(chef_run).to create_remote_file('download intermediate cert').with(
      path: "/var/chef/cache/sf_bundle.crt"
    )
    expect(chef_run).to create_remote_file('download loggly.com cert').with(
      path: "/var/chef/cache/loggly.com.crt"
    )
  end

  it 'creates the loggly certificate' do
    expect(chef_run).to run_bash('bundle certificate')
  end
  
end
