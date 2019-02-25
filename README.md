# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 2.6.0
```bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

rbenv install 2.6.0
rbenv global 2.6.0
```

* Rails version: 6.0.0

* System dependencies 
```bash
Linux | BSD | macOS | Unix
```

* Configuration

##### CentOS 7

```bash
ssh root@193.200.74.71
```

```bash
adduser deploy
passwd deploy
usermod -aG wheel deploy
```

```bash
su - deploy
```

```bash
ssh-copy-id deploy@193.200.74.71
```
Обновляем список пакетов
```bash
sudo yum update
sudo yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel
```
```bash
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install -v 2.6.0
rbenv global 2.6.0
```

```bash
sudo yum install nginx
```

```bash
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload

sudo systemctl start nginx
sudo nginx -s reload

sudo chown -R $USER:$USER /var/www/perceptron.qotofey.ru
sudo chmod -R 755 /var/www
```

* Database creation

* Database initialization

* How to run the test suite
```bash
rake test:models
rake test:controllers
```

* Services (job queues, cache servers, search engines, etc.)


* Deployment instructions
```bash
cap production deploy
```

* ...

## Этапы разработки
1. Создаем таблицу ответов
2. Создаём таблицу вопросов
3. Создаём таблицу основ слов
4. Создаём таблицу слоёв
5. Создаём таблицу персептронов
6. Создаём таблицу слоёв

## Открытые сущности для API
1) Answer
2) Question
3) Perceptron
    * perceptron.learn epochs: 50
    * perceptron.ask text: 'Где находится кнопка "меню"?'

## Тестирование
1. Word.new(value: 'где')
2. Question.new(text: 'Где находится кнопка "меню"?')
3. Answer.new(text: 'Кнопка "меню" находится в левом верхнем углу.')
4. Perceptron.new(size: 3)
5. Layer.new(size_inputs: 5, size_outputs: 5, perceptron: perceptron)
