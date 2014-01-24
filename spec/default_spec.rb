require 'spec_helper'

describe 'loggly-rsyslog::default' do
  
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set['loggly']['token'] = 'some_token_value'
    end.converge(described_recipe)
  end

  context 'when rsyslog tls is disabled' do

    before do
      chef_run.node.set['loggly']['tls']['enabled'] = false
      chef_run.converge(described_recipe)
    end

    it 'does not include the tls recipe' do
      expect(chef_run).to_not include_recipe "loggly::tls"
    end

    it 'uses 514 as the port' do
      expect(chef_run.node['loggly']['rsyslog']['port']).to eq 514
    end

  end

  it 'notifies the rsyslog service to restart' do
    rsyslog_template = chef_run.find_resource(:template, '/etc/rsyslog.conf')
    expect(rsyslog_template).to notify('service[rsyslog]').to(:restart)
  end

  it 'creates loggly rsyslog template with no tags' do
    expect(chef_run).to create_template('/etc/rsyslog.conf').with(
      owner: 'root',
      group: 'root',
      variables: ({
        :tags => ''  
      })
    )  
  end

  it 'creates loggly rsyslog template with tags' do
    chef_run.node.set['loggly']['tags'] = ['test', 'foo', 'bar']
    chef_run.converge(described_recipe)
    expect(chef_run).to create_template('/etc/rsyslog.conf').with(
      owner: 'root',
      group: 'root',
      variables: ({
        :tags => 'tag=\"test\", tag=\"foo\", tag=\"bar\"'  
      })
    )  
  end

  it 'creates a rsyslog.conf file with file entries' do
    runner = ChefSpec::Runner.new do |node|
      node.set['loggly']['token'] = 'some_token_value'
      node.set['loggly']['log_files'] = 
      [ { filename: '/var/log/somefile', tag: 'sometag', statefile: 'somefile.state' },
        { filename: '/var/log/anotherfile', tag: 'anothertag', statefile: 'anotherfile.state' }
      ]
    end.converge(described_recipe)

    expect(runner).to create_template('/etc/rsyslog.conf').with(
      owner: 'root',
      group: 'root',
      :tags => nil  
    )

    expect(runner).to render_file('/etc/rsyslog.conf').with_content(/^.*\[some_token_value \] %msg%/)    

    expect(runner).to render_file('/etc/rsyslog.conf').with_content(/^\$ModLoad imfile/)

    expect(runner).to render_file('/etc/rsyslog.conf').with_content(/^\$InputFileName \/var\/log\/somefile/)    
    expect(runner).to render_file('/etc/rsyslog.conf').with_content(/^\$InputFileTag sometag\:/)
    expect(runner).to render_file('/etc/rsyslog.conf').with_content(/^\$InputFileStateFile somefile.state/)
    
  end

end
