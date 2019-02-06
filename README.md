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

* System dependencies 

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Этапы разработки
1. Создаем таблицу ответов
2. Создаём таблицу вопросов
3. Создаём таблицу основ слов
4. Создаём таблицу слоёв
5. Создаём таблицу персептронов
6. Создаём таблицу слоёв