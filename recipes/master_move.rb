service 'jenkins' do
  supports [:stop, :start, :restart, :status]
  action :nothing
end

execute 'stop-jenkins' do
  command 'echo w00t'
  notifies :stop, 'service[jenkins]', :immediately
  not_if "test -L #{node[:platform_jenkins][:master][:home]}"
end

execute 'move jenkins directory' do
  command "mv #{node[:platform_jenkins][:master][:home]} #{node[:platform_jenkins][:real_var_path]}"
  not_if { ::File.directory? node[:platform_jenkins][:real_var_path] }
end

execute 'remove base folder, if it persisted' do
  command "rm -rf #{node[:platform_jenkins][:master][:home]}"
  action :run
  only_if { ::File.directory? node[:platform_jenkins][:master][:home] }
end

link 'var/lib/jenkins' do
  to node[:platform_jenkins][:real_var_path]
  link_type :symbolic
end

execute 'start-jenkins' do
  command 'echo w00t'
  notifies :start, 'service[jenkins]', :delayed
  not_if "test -L #{node[:platform_jenkins][:master][:home]}"
end
