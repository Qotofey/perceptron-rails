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
