#
# Cookbook Name:: loggly
# Recipe:: tls
#
# Copyright (C) 2014 Matt Veitas
#
# All rights reserved - Do Not Redistribute
#

package 'rsyslog-gnutls' do
  action :install
end

cert_path = node['loggly']['tls']['cert_path']

directory cert_path do
  owner 'root'
  group 'syslog'
  mode 0750
  action :create
  recursive true
end

loggly_crt_path = "#{Chef::Config['file_cache_path']}/loggly_full.crt"

remote_file 'download loggly.com cert' do
  owner 'root'
  group 'root'
  mode 0644
  path loggly_crt_path
  source node['loggly']['tls']['cert_url']
  checksum node['loggly']['tls']['cert_checksum']
end
