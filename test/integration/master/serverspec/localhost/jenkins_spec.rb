require_relative '../spec_helper'

# ----------------------------
# jenkins version & setup
# ----------------------------

describe package('jenkins') do
  it { should be_installed.by('apt').with_version('1.570') }
end

describe process('java') do
  its(:args) { should match '-jar /usr/share/jenkins/jenkins.war' }
end

describe process('java') do
  its(:args) { should match '--httpPort=9080' }
end

describe port(9080) do
  it { should be_listening }
end

describe process('daemon') do
  its(:args) { should match '--env=JENKINS_HOME=/var/lib/jenkins' }
end

describe user('jenkins') do
  it { should have_home_directory '/var/lib/jenkins' }
end

describe file('/var/lib/jenkins') do
  it { should be_linked_to '/srv/jenkins' }
end

describe command('sudo -i -u jenkins export | grep JAVA_HOME') do
  its(:stdout) { should match '/usr/lib/jvm/default-java' }
end

describe file('/usr/local/lib/jenkins') do
  it { should be_directory }
  it { should be_mode('755') }
end

describe file('/usr/local/lib/jenkins/jenkins-cli.jar') do
  it { should be_file }
  it { should be_readable.by('others') }
end

describe file('/var/lib/jenkins/scm-sync-configuration/checkoutConfiguration') do
  it { should be_directory }
  it { should be_owned_by('jenkins') }
end
