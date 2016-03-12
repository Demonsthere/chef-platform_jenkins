service 'jenkins' do
  supports [:stop, :start, :restart, :status]
  action :nothing
end

execute 'stop-jenkins' do
  command 'echo w00t'
  notifies :stop, 'service[jenkins]', :immediately
  not_if 'test -L /var/lib/jenkins'
end

bash 'move_jenkins_installation' do
  user 'root'
  code <<-EOL
    REAL_VAR_PATH_BASE=$(echo "#{node['platform_jenkins']['real_var_path']}" | sed -e 's;\/$;;' | sed -e 's;\/jenkins$;;')
    [ -z "${REAL_VAR_PATH_BASE}" ] && REAL_VAR_PATH_BASE=/srv
    [ -d $REAL_VAR_PATH_BASE/jenkins ] && rm -Rf $REAL_VAR_PATH_BASE/jenkins
    [ ! -d $REAL_VAR_PATH_BASE ] && mkdir -p $REAL_VAR_PATH_BASE
    [ ! -d $REAL_VAR_PATH_BASE/jenkins ] && mv /var/lib/jenkins $REAL_VAR_PATH_BASE
    ln -s $REAL_VAR_PATH_BASE/jenkins /var/lib/jenkins
  EOL
  not_if 'test -L /var/lib/jenkins'
end

execute 'start-jenkins' do
  command 'echo w00t'
  notifies :start, 'service[jenkins]', :delayed
  not_if 'test -L /var/lib/jenkins'
end
