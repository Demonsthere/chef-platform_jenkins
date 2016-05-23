include_recipe 'platform_base'
include_recipe 'platform_jenkins::slave_install'
include_recipe 'platform_jenkins::ssh_setup'

cookbook_file '/etc/sudoers.d/jenkins' do
  source 'jenkins'
  owner 'root'
  group 'root'
  mode '0440'
end

service 'jenkins-swarm-slave' do
  action [:enable, :start]
end
