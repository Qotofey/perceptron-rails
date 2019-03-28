#!/usr/bin/env bash

echo "Hello, CentOS!"

PROJECT_NAME="perceptron-rails"
USERNAME="vagrant"
VM_IP="192.168.33.16"

sudo yum update -y

sudo yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel

cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install -v 2.6.1
rbenv global 2.6.1

echo "gem: --no-document" > ~/.gemrc
gem install bundler

sudo yum install -y epel-release yum-utils
sudo yum-config-manager --enable epel
sudo yum clean all && sudo yum update -y

sudo yum update -y

sudo yum install -y ntp
sudo chkconfig ntpd on
sudo ntpdate pool.ntp.org
sudo service ntpd start

sudo yum install -y pygpgme curl

sudo curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo

sudo yum install -y nginx passenger || sudo yum-config-manager --enable cr && sudo yum install -y nginx passenger

sudo cat > /etc/nginx/nginx.conf << EOL
server {
    listen                    80;
    server_name               $VM_IP
                              local.$PROJECT_NAME.dev;

    root                      /home/$USERNAME/$PROJECT_NAME/public;

    passenger_enabled         on;
    passenger_sticky_sessions on;
    passenger_app_env         development;

    access_log                /var/log/nginx/$PROJECT_NAME.access.log;

    error_page                500 502 503 504
                              /var/log/nginx/$PROJECT_NAME.error.50x.html;
}
EOL

sudo systemctl start nginx.service

sudo yum install -y https://download.postgresql.org/pub/repos/yum/11/redhat/rhel-7-x86_64/pgdg-centos11-11-2.noarch.rpm
sudo yum install -y postgresql11-server postgresql11 postgresql11-libs postgresql-libs
sudo yum install -y libpqxx libpqxx-devel

sudo /usr/pgsql-11/bin/postgresql-11-setup initdb

sudo systemctl start postgresql-11
sudo systemctl enable postgresql-11

sudo yum install -y postgresql-devel #for gem 'pg'

#sudo vi /var/lib/pgsql/11/data/postgresql.conf

sudo cat > /var/lib/pgsql/11/data/postgresql.conf << EOL
listen_addresses = '*'
EOL

#sudo vi /var/lib/pgsql/11/data/pg_hba.conf

sudo cat > /var/lib/pgsql/11/data/pg_hba.conf << EOL
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
# Allow replication connections from localhost, by a user with the
# replication privilege.
#local   replication     all                                     peer
#host    replication     all             127.0.0.1/32            ident
#host    replication     all             ::1/128                 ident
EOL

sudo su - postgres
###
psql
###
\l
\dg
create user vagrant with password '123123';
create database "perceptron_dev" with owner=vagrant;
\l
\q
exit
###
cd ~/perceptron-rails/

gem uninstall fileutils
gem update --default

bundle install

rake db:migrate

sudo systemctl restart postgresql-11