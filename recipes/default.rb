package "openswan"

service "ipsec" do
  action [:enable, :start]
  supports [:start, :restart, :reload, :status]
end

template "/etc/ipsec.conf" do
  source "ipsec.conf.erb"
  notifies :reload, 'service[ipsec]', :delayed
end

cookbook_file "ipsec.secrets" do
  path "/etc/ipsec.secrets"
  mode 0600
  owner "root"
  group "root"
  notifies :reload, 'service[ipsec]', :delayed
end

