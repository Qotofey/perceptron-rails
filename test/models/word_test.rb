require 'test_helper'

class WordTest < ActiveSupport::TestCase

  # в качестве аргумента стоит использовать только поле value,
  # использовать остальные аргументы в конструкторе - бессмысленно

  fixtures :words

  test "нельзя создать слово с пустым полем value" do
    word = Word.new
    assert word.invalid? # если нет поля value
    assert word.errors[:value].any? # значит поле value возвращают ошибку
    # assert word.errors[:vector].any? # значит поле vector возвращают ошибку
  end

  test "нельзя создать пустое слово value" do
    word = Word.new(value: '')
    assert word.invalid? # такой ереси не должно быть вообще
  end

  test "можно создать объект с полем value" do
    word = Word.new(value: 'поле')
    assert word.valid? # в данному месте value имеет уникальное значение
    assert !word.errors[:value].any?
    assert !word.errors[:vector].any? # тест проходит - вектор может быть пустым, все верно
  end

  test "vector должен быть уникальным" do
    word = Word.new(value: 'поле', vector: [ 1, 0, 0 ])
    assert word.invalid? # в данному месте value имеет уникальное значение
    assert !word.errors[:value].any?
    assert word.errors[:vector].any? # тест проходит - вектор может быть пустым, все верно
  end

  test "value должен быть уникальным" do
    word = Word.new(value: 'кнопк') # не уникален
    assert word.invalid?
    assert word.errors[:value].any? # возвращает ошибку потому-что должен быть уникален
    assert !word.errors[:vector].any? # тест проходит - вектор может быть пустым, все верно

    word = Word.new(value: 'лалалал') # уникален
    assert word.valid?
    assert !word.errors[:value].any?
    assert !word.errors[:vector].any? # тест проходит - вектор может быть пустым, все верно
  end
end
