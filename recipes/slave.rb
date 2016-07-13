include_recipe 'platform_base'
include_recipe 'platform_jenkins::slave_install'
include_recipe 'platform_jenkins::ssh_setup'

cookbook_file '/etc/sudoers.d/jenkins' do
  source 'jenkins'
  owner 'root'
  group 'root'
  mode '0440'
end

execute 'start-jenkins' do
  command 'echo w00t'
  notifies :start, 'service[jenkins-swarm-slave]', :delayed
  not_if "test -L #{node[:platform_jenkins][:slave][:home]}"
end
