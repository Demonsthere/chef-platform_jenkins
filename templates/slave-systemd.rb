[Unit]
Description=jenkins-swarm-slave
After=syslog.target
After=network.target

[Service]
WorkingDirectory=<%= node['rpi_jenkins']['slave']['home'] %>
ExecStart=/usr/bin/java \
 -jar <%= node['rpi_jenkins']['slave']['home'] %>/swarm-client-1.22-jar-with-dependencies.jar \
 -description "Jenkins Swarm Slave Description" \
 -executors <%= node['rpi_jenkins']['slave']['executors'] %> \
 -master "<%= node['rpi_jenkins']['slave']['master_url'] %>" \
 -fsroot "<%= node['rpi_jenkins']['slave']['home'] %>" \
 -labels "<%= node['rpi_jenkins']['slave']['labels'] %>" \
 -name "<%= node['rpi_jenkins']['slave']['name'] %>" \
 -username "<%= node['rpi_jenkins']['slave']['jenkins-ui-user'] %>" \
 -password "<%= node['rpi_jenkins']['slave']['jenkins-ui-password'] %>"
User=jenkins
Restart=always

[Install]
WantedBy=multi-user.target