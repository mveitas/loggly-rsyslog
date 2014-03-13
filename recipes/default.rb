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

# If we're not replacing the default rsyslog.conf, use the include conf source.
if node['loggly']['rsyslog']['conf'] != '/etc/rsyslog.conf'
  rsyslog_conf_source = 'loggly.conf-include.erb'
else
  rsyslog_conf_source = 'loggly.conf.erb'
end

template node['loggly']['rsyslog']['conf'] do
  source rsyslog_conf_source
  owner 'root'
  group 'root'
  mode 0644
  variables({
    :monitor_files => !node['loggly']['log_files'].empty? || !node['loggly']['log_dirs'].empty?,
    :tags => node['loggly']['tags'].nil? || node['loggly']['tags'].empty? ? '' : "tag=\\\"#{node['loggly']['tags'].join("\\\" tag=\\\"")}\\\""
  })
  notifies :restart, "service[rsyslog]", :immediate
end
