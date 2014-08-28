include_recipe 'mysql::server'
include_recipe 'capistrano::default'

# provide Gemfile if it doesn't exist, e.g. during testing
template "/var/www/#{node['capistrano']['application']}/current/Gemfile" do
  source 'Gemfile.erb'
  owner node['capistrano']['deploy_user']
  group node['capistrano']['group']
  mode 0644
  action :create_if_missing
end

# install required gems via bundler
bash "bundle" do
  user node['capistrano']['deploy_user']
  cwd "/var/www/#{node['capistrano']['application']}/current"
  if node['capistrano']['rails_env'] == "development"
    code "bundle install"
  else
    code "bundle install --deployment"
  end
end

# precompile assets
if node['capistrano']['rails_env'] != "development"
  bash "RAILS_ENV=#{node['capistrano']['rails_env']} assets:precompile" do
    user node['capistrano']['deploy_user']
    cwd "/var/www/#{node['capistrano']['application']}/current"
  end
end

# create database and run migrations
db_app node['capistrano']['application'] do
  host node['capistrano']['db_host']
  username node['capistrano']['db_user']
  password node['capistrano']['db_password']
  cookbook "capistrano"
end