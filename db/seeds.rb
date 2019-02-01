# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Answer.delete_all
Question.delete_all
Word.delete_all

answer_one = Answer.create(text: 'Кнопка "меню" находится в левом верхнем углу.')
Question.create(text: 'Где находится кнопка "меню"?', answer: answer_one)
Question.create(text: 'Как зайти в "меню"?', answer: answer_one)

answer_two = Answer.create(text: 'Нажмите на кнопку в правом верхнем углу, обучение потребует время.')
Question.create(text: 'Как запустить обучение системы?', answer: answer_two)
Question.create(text: 'Не могу запустить обучение, что делать?', answer: answer_two)

answer_three = Answer.create(text: 'Во вкладке "меню"')
Question.create(text: 'Где находятся настройки?', answer: answer_three)
Question.create(text: 'Где находится вкладка "настройки"?', answer: answer_three)

# Word.create(value: 'где')
# Word.create(value: 'наход')
# Word.create(value: 'мен')
# Word.create(value: 'как')
# Word.create(value: 'запуст')
# Word.create(value: 'обучен')
# Word.create(value: 'настройк')
# Word.create(value: 'кнопк')
# Word.create(value: 'зайт')
# Word.create(value: 'в')
# Word.create(value: 'систем')
# Word.create(value: 'не')
# Word.create(value: 'мог')
# Word.create(value: 'что')
# Word.create(value: 'дела')
# Word.create(value: 'вкладк')