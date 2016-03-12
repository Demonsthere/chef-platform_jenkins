default['platform_jenkins']['java']['home'] = '/usr/lib/jvm/default-java'

default['platform_jenkins']['master']['home'] = '/var/lib/jenkins'
default['platform_jenkins']['master']['log_directory'] = '/var/log/jenkins'
default['platform_jenkins']['master']['listen_address'] = '0.0.0.0'
default['platform_jenkins']['master']['jenkins_args'] = ''

default['platform_jenkins']['master']['version'] = '1.650'

default['platform_jenkins']['master']['source'] = "http://192.168.42.100:80/data/jenkins/bin/jenkins_#{node['platform_jenkins']['master']['version']}_all.deb"

default['platform_jenkins']['master']['plugin_baseurl'] = %w(https://updates.jenkins-ci.org/download/plugins http://192.168.42.100:80/data/jenkins/plugins)
default['platform_jenkins']['master']['plugin_list'] = [
  ['dashboardintegration', '441+git4c1d13d', 'https://dash.pingworks.net/plugins'],
  ['antisamy-markup-formatter', '1.1'],
  ['build-flow-plugin', '0.17'],
  ['build-name-setter', '1.3'],
  ['build-pipeline-plugin', '1.4.5'],
  ['claim', '2.5'],
  ['conditional-buildstep', '1.3.3'],
  ['copyartifact', '1.32.1'],
  ['credentials', '1.18'],
  ['cvs', '2.11'],
  ['dashboard-view', '2.9.4'],
  ['emotional-jenkins-plugin', '1.2'],
  ['envinject', '1.90'],
  ['external-monitor-job', '1.2'],
  ['git-client', '1.12.0'],
  ['git', '2.3.1'],
  ['greenballs', '1.14'],
  ['groovy-postbuild', '2.1'],
  ['jacoco', '1.0.18'],
  ['javadoc', '1.1'],
  ['jenkinswalldisplay', '0.6.27'],
  ['jobConfigHistory', '2.10'],
  ['join', '1.15'],
  ['m2release', '0.14.0'],
  ['mailer', '1.8'],
  ['matrix-auth', '1.1'],
  ['matrix-project', '1.4'],
  ['maven-info', '0.2.0'],
  ['maven-plugin', '2.3'],
  ['multiple-scms', '0.3'],
  ['pam-auth', '1.1'],
  ['parameterized-trigger', '2.25'],
  ['performance', '1.11'],
  ['postbuild-task', '1.8'],
  ['preSCMbuildstep', '0.3'],
  ['PrioritySorter', '2.9'],
  ['rebuild', '1.22'],
  ['repository', '1.2'],
  ['run-condition', '1.0'],
  ['scm-api', '0.2'],
  ['scm-sync-configuration', '0.0.8.2hybris'],
  ['script-security', '1.12'],
  ['ssh-credentials', '1.10'],
  ['ssh-slaves', '1.5'],
  ['subversion', '1.54'],
  ['swarm', '1.22'],
  ['token-macro', '1.10'],
  ['translation', '1.10'],
  ['windows-slaves', '1.0'],
  ['xvfb', '1.0.13'],
  ['purge-build-queue-plugin', '1.0']
]

# let jenkins run on a different port (9080 instead of the standard 8080)
default['platform_jenkins']['master']['port'] = 9080

# the var partition is very small therefore we move /var/lib/jenkins to a different location
default['platform_jenkins']['real_var_path'] = '/srv/jenkins'

# jenkins config git url
default['platform_jenkins']['master']['jenkins_config_git_url'] = 'git@github.com:Demonsthere/jenkins-platform_synch.git'

# configure jenkins full url that is seen in build_url
default['platform_jenkins']['master']['jenkins_full_url'] = "http://192.168.42.200:9080"
default['platform_jenkins']['master']['jenkins_admin_email'] = 'jakub.blaszczyk@sap.com'

# a bit more heap for the master
default['platform_jenkins']['master']['jvm_options'] = '-XX:MaxPermSize=1024m -Dorg.eclipse.jetty.server.Request.maxFormContentSize=500000'
default['platform_jenkins']['slave']['jvm_options'] = '-XX:MaxPermSize=512m'

# slave config
default['platform_jenkins']['slave']['home'] = '/var/lib/jenkins'
default['platform_jenkins']['slave']['shell'] = '/bin/bash'
default['platform_jenkins']['slave']['swarm_version'] = '1.22'
default['platform_jenkins']['slave']['swarm_jar'] = "swarm-client-#{node['platform_jenkins']['slave']['swarm_version']}-jar-with-dependencies.jar"
default['platform_jenkins']['slave']['swarm_base_url'] = 'http://192.168.42.100:80/data/jenkins/bin/'
default['platform_jenkins']['slave']['swarm_version']        = '1.22'
default['platform_jenkins']['slave']['master_url']           = 'http://192.168.42.200:4290'
default['platform_jenkins']['slave']['jenkins_ui_user']      = 'jenkins-ui-user'
default['platform_jenkins']['slave']['jenkins_ui_password']  = 'jenkins-ui-password'
default['platform_jenkins']['slave']['labels']               = 'swarm'
default['platform_jenkins']['slave']['name']                 = 'jkslave'
default['platform_jenkins']['slave']['executors']            = '1'

# profiling config
default['platform_jenkins']['profiling']['pkg'] = 'pipeline-profiling_0.0.9_amd64.deb'
default['platform_jenkins']['profiling']['pkg_url'] = "http://depot.fra.hybris.com/rpi/tool-releases/pipeline-profiling/#{node['platform_jenkins']['profiling']['pkg']}"