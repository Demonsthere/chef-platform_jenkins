# install the prerequisites for the jenkins-package
%w(daemon psmisc).each do |pkg|
  package pkg do
    action :upgrade
  end
end
  
# Download the remote DEB file
remote_file "#{Chef::Config[:file_cache_path]}/jenkins_#{node['platform_jenkins']['master']['version']}_all.deb" do
  source   node['platform_jenkins']['master']['source']
  checksum node['platform_jenkins']['master']['checksum'] if node['platform_jenkins']['master']['checksum']
  action :create_if_missing
end

dpkg_package "jenkins_#{node['platform_jenkins']['master']['version']}_all.deb" do
  options '--force-confdef'
  source "#{Chef::Config[:file_cache_path]}/jenkins_#{node['platform_jenkins']['master']['version']}_all.deb"
  version node['platform_jenkins']['master']['version']
  notifies :restart, 'service[jenkins]', :delayed
end

# cp jenkins-cli.jar to /usr/local/lib/jenkins/jenkins-cli.jar
directory '/usr/local/lib/jenkins' do
  owner 'root'
  group 'staff'
  mode '0755'
end

ark 'jenkins-cli' do
  url 'file:///usr/share/jenkins/jenkins.war'
  path '/usr/local/lib/jenkins'
  creates 'jenkins-cli.jar'
  action :cherry_pick
  not_if { ::File.exist? '/usr/local/lib/jenkins-cli.jar' }
end

file '/usr/local/lib/jenkins/jenkins-cli.jar' do
  owner 'root'
  group 'staff'
  mode '0644'
end

execute 'set-bash-shell' do
  command 'sudo update-alternatives --install /bin/sh sh /bin/bash 300'
end

template '/etc/default/jenkins' do
  source   'jenkins-config.erb'
  mode     '0644'
  notifies :restart, 'service[jenkins]', :delayed
end

group 'docker' do
  action :manage
  members ['vagrant','jenkins']
end

service 'jenkins' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
