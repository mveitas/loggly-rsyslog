#
# Cookbook Name:: loggly
# Recipe:: default
#
# Copyright (C) 2014 AgaMatrix
# 
# All rights reserved - Do Not Redistribute
#

raise "You have to set a token set in the attribute ['loggly']['token']" if node['loggly']['token'].nil?

service "rsyslog"

include_recipe "loggly-rsyslog::tls" if node['loggly']['tls']['enabled']

template '/etc/rsyslog.conf' do
  source 'loggly.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables({
    :tags => node['loggly']['tags'].nil? || node['loggly']['tags'].empty? ? '' : "tag=\\\"#{node['loggly']['tags'].join("\\\" tag=\\\"")}\\\""
  })
  notifies :restart, "service[rsyslog]", :immediate
end
