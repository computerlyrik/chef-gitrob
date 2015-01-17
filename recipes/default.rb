#
# Cookbook Name:: gitrob
# Recipe:: default
#
# Copyright (C) 2015 computerlyrik, Christian Fischer
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'postgresql::ruby'

database = node['gitrob']['database']['database']
database_user = node['gitrob']['database']['username']
database_password = node['gitrob']['database']['password']
database_host = node['gitrob']['database']['host']
database_connection = {
  host: database_host,
  port: '5432',
  username: 'postgres',
  password: node['postgresql']['password']['postgres']
}

# Create the database
postgresql_database database do
  connection database_connection
  action :create
end

# Create the database user Grant all privileges on database
postgresql_database_user database_user do
  connection database_connection
  password database_password
  database_name database
  action [:create, :grant]
end


execute "gem install gitrob"
#gem_package "gitrob"
