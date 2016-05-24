# Install Jenkins plugins
directory '/var/lib/jenkins/plugins' do
  mode '0755'
  owner 'jenkins'
  group 'jenkins'
end

plugins_to_be_installed = []
node[:platform_jenkins][:master][:plugin_list].each_with_index do |plugin, _i|
  plugin_version_installed = ''
  plugin_manifest = "/var/lib/jenkins/plugins/#{plugin[0]}/META-INF/MANIFEST.MF"
  if File.file?(plugin_manifest)
    File.open(plugin_manifest) do |file|
      file.each_line do |line|
        if line =~ /^Plugin-Version:/
          plugin_version_installed = line.chomp.gsub(/^Plugin-Version:\s/, '')
          break
        end
      end
    end
    Chef::Log.info "Jenkins Plugin \"#{plugin[0]}\" Version installed: \"#{plugin_version_installed}\""
  else
    Chef::Log.info "Jenkins Plugin \"#{plugin[0]}\" is not installed yet!"
  end

  Chef::Log.info "Jenkins Plugin \"#{plugin[0]}\" Version desired:   \"#{plugin[1]}\""

  if !plugin_version_installed.eql? plugin[1]
    Chef::Log.info "Will INSTALL Jenkins Plugin #{plugin[0]}@#{plugin[1]}"
    plugins_to_be_installed.push([plugin[0], plugin[1], plugin[2]])
  else
    Chef::Log.info "Jenkins Plugin \"#{plugin[0]}\" is already UPTODATE."
  end
end

plugins_to_be_installed.each_with_index do |plugin, i|
  base_url = node[:platform_jenkins][:master][:plugin_baseurl]
  base_urls = []
  !base_url.is_a?(Array) ? base_urls.push(base_url) : base_urls = base_url
  urls = base_urls.map { |url| "#{url}/#{plugin[0]}/#{plugin[1]}/#{plugin[0]}.hpi" }
  plugin[2].nil? || urls.push(plugin[2] + "/#{plugin[0]}/#{plugin[1]}/#{plugin[0]}.hpi")
  Chef::Log.info "Jenkins Plugin possible locations: #{urls.join(', ')}"
  remote_file "/var/lib/jenkins/plugins/#{plugin[0]}.hpi" do
    source urls
    owner 'jenkins'
    group 'jenkins'
    retries 2
    retry_delay 2
    notifies :restart, 'service[jenkins]', :delayed if i == plugins_to_be_installed.size - 1
    action :create_if_missing
  end
end
