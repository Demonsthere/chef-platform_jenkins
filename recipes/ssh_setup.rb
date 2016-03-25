directory '/var/lib/jenkins/.ssh' do
  mode '0700'
  owner 'jenkins'
  group 'jenkins'
end

cookbook_file 'id_rsa' do
  path '/var/lib/jenkins/.ssh/id_rsa'
  mode '0600'
  owner 'jenkins'
  group 'jenkins'
  action :create_if_missing
end

cookbook_file 'id_rsa.pub' do
  path '/var/lib/jenkins/.ssh/id_rsa.pub'
  mode '0644'
  owner 'jenkins'
  group 'jenkins'
  action :create_if_missing
end

cookbook_file 'known_hosts' do
  path '/var/lib/jenkins/.ssh/known_hosts'
  owner 'jenkins'
  group 'jenkins'
  mode '0644'
  action :create_if_missing
end

execute 'Add apache to known_hosts' do
  command 'ssh-keyscan 192.168.42.100 >> ~/.ssh/known_hosts'
  action :run
end
