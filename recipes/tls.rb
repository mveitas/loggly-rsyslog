#
# Cookbook Name:: loggly
# Recipe:: tls
#
# Copyright (C) 2014 AgaMatrix
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

loggly_crt_path = "#{Chef::Config['file_cache_path']}/loggly.com.crt"
sf_bundle_path = "#{Chef::Config['file_cache_path']}/sf_bundle.crt"

remote_file 'download loggly.com cert' do
  owner 'root'
  group 'root'
  mode 0644
  path loggly_crt_path
  source node['loggly']['tls']['cert_url']
  checksum node['loggly']['tls']['cert_checksum']
end

remote_file 'download intermediate cert' do
  owner 'root'
  group 'root'
  mode 0644
  path sf_bundle_path
  source node['loggly']['tls']['intermediate_cert_url']
  checksum node['loggly']['tls']['intermediate_cert_checksum']
end
  
bash 'bundle certificate' do
  user 'root'
  cwd cert_path
  code <<-EOH
    cat {#{sf_bundle_path},#{loggly_crt_path}} > loggly_full.crt
  EOH
  not_if { ::File.exists?("#{node['loggly']['tls']['cert_path']}/loggly_full.crt") }
end
