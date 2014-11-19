define :ipsec_tunnel, pfs: 'no' do

  template "/etc/ipsec.d/#{params[:name]}.conf" do
    cookbook "openswan"
    source "ipsec_tunnel.conf.erb"
    mode 0600
    owner "root"
    group "root"
    variables({
      name: params[:name],
      settings: params[:settings]
    })
    notifies :reload, 'service[ipsec]', :delayed
  end

  template "/etc/ipsec.d/#{params[:name]}.secrets" do
    cookbook "openswan"
    source "ipsec_tunnel.secrets.erb"
    mode 0600
    owner "root"
    group "root"
    variables({
      right: params[:settings][:right],
      secret: params[:secret]
    })
    notifies :reload, 'service[ipsec]', :delayed
  end

end
