require_relative '../spec_helper'
require 'busser/rubygems'

Busser::RubyGems.install_gem('faraday', '~> 0.9.0')
require 'faraday'

master_url = 'http://192.168.24.200:9080'
slave_name = 'jkslave'

describe service('jenkins-swarm-slave') do
  it { should be_enabled }
end

describe service('jenkins-swarm-slave') do
  it { should be_running }
end

describe file('/var/lib/jenkins') do
  it { should be_linked_to '/srv/jenkins' }
end

describe command('sudo -i -u jenkins export | grep JAVA_HOME') do
  its(:stdout) { should match '/usr/lib/jvm/default-java' }
end

describe 'slave is connected to master' do
  it 'should be connected to master' do
    res = Faraday.get "#{master_url}/computer/#{slave_name}/"
    expect(res.body).to match 'Connected via JNLP agent.'
  end
end
