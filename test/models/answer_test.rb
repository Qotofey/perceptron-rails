require 'test_helper'

class AnswerTest < ActiveSupport::TestCase

  fixtures :answers

  test "свойство ответа text не должно быть пустым" do
    answer = Answer.new
    assert answer.invalid?
    assert answer.errors[:text].any?
    assert !answer.errors[:vector].any?
  end

  test "объект должен создаваться с одним аргументом text" do
    answer = Answer.new(text: 'text test answer')
    assert answer.valid?
    assert !answer.errors[:text].any?
    assert !answer.errors[:vector].any?
  end

  test "объект не должен создаваться с одним аргументом vector" do
    answer = Answer.new(vector: [0, 1, 0, 0, 0])
    assert answer.invalid?
    assert answer.errors[:text].any?
    assert !answer.errors[:vector].any?
  end

  test "объект не должен создаваться с аргументом vector" do
    answer = Answer.new(text: 'text test answer', vector: [0, 0, 1, 0, 0])
    assert answer.valid?
    assert !answer.errors[:text].any?
    assert !answer.errors[:vector].any?
  end

end
