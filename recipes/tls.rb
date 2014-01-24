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
  group 'root'
  mode 0644
  action :create
  recursive true
end

remote_file 'download loggly.com cert' do
  owner 'root'
  group 'root'
  mode 0644
  path "#{node['loggly']['tls']['cert_path']}/loggly.com.crt"
  source node['loggly']['tls']['cert_url']
  checksum node['loggly']['tls']['cert_checksum']
end

remote_file 'download intermediate cert' do
  owner 'root'
  group 'root'
  mode 0644
  path "#{node['loggly']['tls']['cert_path']}/sf_bundle.crt"
  source node['loggly']['tls']['intermediate_cert_url']
  checksum node['loggly']['tls']['intermediate_cert_checksum']
end
  
bash 'bundle certificate' do
  user 'root'
  cwd cert_path
  code <<-EOH
    cat {sf_bundle.crt,loggly.com.crt} > loggly_full.crt && rm -rf sf_bundle.crt loggly.com.crt
  EOH
end