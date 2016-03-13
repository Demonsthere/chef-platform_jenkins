# setup jenkins user and home
user 'jenkins' do
  home node['platform_jenkins']['slave']['home']
  shell node['platform_jenkins']['slave']['shell']
  manage_home true
end

directory node['platform_jenkins']['slave']['home'] do
  owner 'jenkins'
end

# install swarm jar
remote_file "#{node['platform_jenkins']['slave']['home']}/#{node['platform_jenkins']['slave']['swarm_jar']}" do
  source "#{node['platform_jenkins']['slave']['swarm_base_url']}/#{node['platform_jenkins']['slave']['swarm_jar']}"
  headers 'Host' => URI.parse(source.first).host
  action :create_if_missing
  notifies :restart, 'service[jenkins-swarm-slave]', :delayed
end

link "#{node['platform_jenkins']['slave']['home']}/swarm-slave.jar" do
  to "#{node['platform_jenkins']['slave']['home']}/#{node['platform_jenkins']['slave']['swarm_jar']}"
end

# create service file
template '/etc/systemd/system/jenkins-swarm-slave.service' do
  source 'slave-systemd.erb'
  mode '644'
end

# configure log dir
directory '/var/log/jenkins' do
  owner 'jenkins'
end

# move installation
execute 'mv /var/lib/jenkins /srv' do
  not_if { ::File.directory? '/srv/jenkins' }
end

# link home to true directory
link node['platform_jenkins']['slave']['home'] do
  to '/srv/jenkins'
end

group 'docker' do
  action :manage
  members 'jenkins'
end
