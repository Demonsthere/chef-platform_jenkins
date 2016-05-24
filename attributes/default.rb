default[:platform_jenkins][:java][:home] = '/usr/lib/jvm/default-java'

default[:platform_jenkins][:master][:home] = '/var/lib/jenkins'
default[:platform_jenkins][:master][:log_directory] = '/var/log/jenkins'
default[:platform_jenkins][:master][:listen_address] = '0.0.0.0'
default[:platform_jenkins][:master][:jenkins_args] = ''

default[:platform_jenkins][:master][:version] = '1.651.2'

default[:platform_jenkins][:master][:source] = "http://pkg.jenkins-ci.org/debian-stable/binary/jenkins_#{node[:platform_jenkins][:master][:version]}_all.deb"

default[:platform_jenkins][:apache][:url] = '192.168.24.100'
default[:platform_jenkins][:apache][:port] = '4280'
default[:platform_jenkins][:apache][:full_url] = "http://#{node[:platform_jenkins][:apache][:url]}:#{node[:platform_jenkins][:apache][:port]}"

default[:platform_jenkins][:master][:plugin_baseurl] = ['https://updates.jenkins-ci.org/download/plugins', "#{node[:platform_jenkins][:apache][:full_url]}/data/jenkins/plugins"]
default[:platform_jenkins][:master][:plugin_list] = [
  ['analysis-core', '1.71'],
  ['ansicolor', '0.4.1'],
  ['build-flow-plugin', '0.17'],
  ['build-monitor-plugin', '1.6+build.138'],
  ['build-pipeline-plugin', '1.4.5'],
  ['claim', '2.5'],
  ['clone-workspace-scm', '0.6'],
  ['conditional-buildstep', '1.3.3'],
  ['config-file-provider', '2.7.5'],
  ['copyartifact', '1.34'],
  ['credentials', '1.22'],
  ['cvs', '2.12'],
  ['dashboard-view', '2.9.4'],
  ['database', '1.3'],
  ['description-setter', '1.9'],
  ['disk-usage', '0.25'],
  ['doclinks', '0.6'],
  ['external-monitor-job', '1.4'],
  ['extra-columns', '1.14'],
  ['git', '2.3.4'],
  ['git-client', '1.15.0'],
  ['gradle', '1.24'],
  ['greenballs', '1.14'],
  ['groovy', '1.24'],
  ['javadoc', '1.3'],
  ['job-dsl', '1.35'],
  ['locale', '1.2'],
  ['nodelabelparameter', '1.5.1'],
  ['monitoring', '1.59.0'],
  ['pam-auth', '1.2'],
  ['Parameterized-Remote-Trigger', '2.1.3'],
  ['parameterized-trigger', '2.25'],
  ['plot', '1.9'],
  ['postbuild-task', '1.8'],
  ['purge-build-queue-plugin', '1.0'],
  ['rebuild', '1.25'],
  ['run-condition', '1.0'],
  ['scm-api', '0.2'],
  ['scm-sync-configuration', '0.0.8.2hybris'],
  ['shelve-project-plugin', '1.5'],
  ['ssh', '2.4'],
  ['ssh-credentials', '1.10'],
  ['ssh-slaves', '1.9'],
  ['subversion', '2.5'],
  ['swarm', '1.22'],
  ['token-macro', '1.10'],
  ['translation', '1.12'],
  ['violations', '0.7.11'],
  ['windows-slaves', '1.0'],
  ['ws-cleanup', '0.25'],
  ['xunit', '1.93']
]

# let jenkins run on a different port (9080 instead of the standard 8080)
default[:platform_jenkins][:master][:port] = 9080

# the var partition is very small therefore we move /var/lib/jenkins to a different location
default[:platform_jenkins][:real_var_path] = '/srv/jenkins'

# jenkins config git url
default[:platform_jenkins][:master][:jenkins_config_git_url] = 'git@github.com:Demonsthere/jenkins-platform_synch.git'

# configure jenkins full url that is seen in build_url
default[:platform_jenkins][:master][:jenkins_full_url] = "http://192.168.24.200:#{node[:platform_jenkins][:master][:port]}"
default[:platform_jenkins][:master][:jenkins_admin_email] = 'jakub.blaszczyk@sap.com'

# a bit more heap for the master
default[:platform_jenkins][:master][:jvm_options] = '-XX:MaxPermSize=1024m -Dorg.eclipse.jetty.server.Request.maxFormContentSize=500000'
default[:platform_jenkins][:slave][:jvm_options] = '-XX:MaxPermSize=1024m'

# slave config
default[:platform_jenkins][:slave][:home] = '/var/lib/jenkins'
default[:platform_jenkins][:slave][:shell] = '/bin/bash'
default[:platform_jenkins][:slave][:swarm_version] = '1.22'
default[:platform_jenkins][:slave][:swarm_jar] = "swarm-client-#{node[:platform_jenkins][:slave][:swarm_version]}-jar-with-dependencies.jar"
default[:platform_jenkins][:slave][:swarm_base_url] = "#{node[:platform_jenkins][:apache][:full_url]}/data/jenkins/bin"
default[:platform_jenkins][:slave][:master_url]           = "http://192.168.24.200:#{node[:platform_jenkins][:master][:port]}"
default[:platform_jenkins][:slave][:jenkins_ui_user]      = 'jenkins-ui-user'
default[:platform_jenkins][:slave][:jenkins_ui_password]  = 'jenkins-ui-password'
default[:platform_jenkins][:slave][:labels]               = 'swarm docker'
default[:platform_jenkins][:slave][:name]                 = 'jkslave'
default[:platform_jenkins][:slave][:executors]            = '2'
