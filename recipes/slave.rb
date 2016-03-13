include_recipe 'platform_base'
include_recipe 'platform_jenkins::slave_install'
include_recipe 'platform_jenkins::ssh_setup'

service 'jenkins-swarm-slave' do
  action [:enable, :start]
end
