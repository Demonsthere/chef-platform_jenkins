configcheckout = '/var/lib/jenkins/scm-sync-configuration/checkoutConfiguration'
configshared = '/var/lib/jenkins/jenkins-platform_synch'

bash 'checkout scm-sync-configuration' do
  code <<-EOL
  service jenkins stop
  rm -f /var/lib/jenkins/*.xml
  if [ -d "#{configshared}" ]; then
    mkdir -p $(dirname #{configcheckout})
    ln -s #{configshared} #{configcheckout}
    chown -R jenkins:jenkins $(dirname #{configcheckout})
  else
    if [ -d #{configcheckout} ]; then
      rm -rf #{configcheckout}
    fi
    su - jenkins -c "git clone #{node['platform_jenkins']['master']['jenkins_config_git_url']} #{configcheckout}"
  fi
  for subdir in jobs users email-templates; do
    rm -rf /var/lib/jenkins/${subdir}/*
    if [ -d "#{configcheckout}/${subdir}" ]; then
      [ -d "/var/lib/jenkins/${subdir}" ] || mkdir /var/lib/jenkins/${subdir}
      cp -r #{configcheckout}/${subdir}/* /var/lib/jenkins/${subdir}/
      chown -R jenkins:jenkins /var/lib/jenkins/${subdir}/*
    fi
  done
  cp -r #{configcheckout}/*.xml /var/lib/jenkins/
  chown jenkins:jenkins /var/lib/jenkins/*.xml
  chown jenkins:jenkins /var/lib/jenkins/jobs
  service jenkins start
  EOL
  only_if "su - jenkins -c \"git ls-remote #{node['platform_jenkins']['master']['jenkins_config_git_url']} >/dev/null 2>&1\" || test -d #{configshared}"
end

log 'SCM-Synch log' do
  message 'ssh keys not valid. SCM Sync Configuration was not perfomed'
  not_if "su - jenkins -c \"git ls-remote #{node['platform_jenkins']['master']['jenkins_config_git_url']}\""
end
