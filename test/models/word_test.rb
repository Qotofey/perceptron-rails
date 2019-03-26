require 'test_helper'

class WordTest < ActiveSupport::TestCase

  # в качестве аргумента стоит использовать только поле value,
  # использовать остальные аргументы в конструкторе - бессмысленно

  fixtures :words

  test "нельзя создать слово с пустым полем value" do
    word = Word.new
    assert word.invalid?
    assert word.errors[:value].any?
  end

  test "нельзя создать объект без поля value" do
    word = Word.new(vector: [1, 0, 0])
    assert word.invalid?
  end

  test "можно создать объект с полем value" do
    word = Word.new(value: 'поле')
    assert word.valid?
    assert !word.errors[:value].any?
  end

  test "value должен быть уникальным" do
    word = Word.new(value: 'кнопк')
    assert word.invalid?
    assert word.errors[:value].any?

    word = Word.new(value: 'лалалал')
    assert word.valid?
    assert !word.errors[:value].any?
  end
end
