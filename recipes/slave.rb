include_recipe 'platform_base'
include_recipe 'platform_jenkins::slave_install'
include_recipe 'platform_jenkins::ssh_setup'

cookbook_file '/etc/sudoers.d/jenkins' do
  source 'jenkins'
  owner 'root'
  group 'root'
  mode '0440'
end

execute 'Backup original sfdisk' do
  command 'mv sfdisk sfdisk.back'
  cwd '/sbin/'
  action :run
end

remote_file '/sbin/sfdisk' do
  owner 'root'
  group 'root'
  mode '0755'
  source 'http://192.168.42.100:4280/data/bin/sfdisk'
end

service 'jenkins-swarm-slave' do
  action [:enable, :start]
end
