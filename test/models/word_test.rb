require 'test_helper'

class WordTest < ActiveSupport::TestCase

  test "нельзя создать слово с пустым полем value" do
    word = Word.new
    assert word.invalid?
    assert word.errors[:value].any?
    assert !word.errors[:vector].any?
  end

  test "нельзя создать объект без поля value" do
    word = Word.new(vector: [1, 0, 0])
    assert word.invalid?
    assert word.errors[:value].any?
    assert word.errors[:vector].any?
  end

  test "можно создать объект с полем value" do
    word = Word.new(value: 'поле')
    assert word.valid?
    assert !word.errors[:value].any?
    assert !word.errors[:vector].any?
  end

  test "можно создать объект если есть поле value" do
    word = Word.new(value: 'лалалала', vector: [0, 1, 0, 0])
    assert word.valid?
    assert !word.errors[:value].any?
    assert !word.errors[:vector].any?
  end
end
