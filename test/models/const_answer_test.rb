require 'test_helper'

class ConstAnswerTest < ActiveSupport::TestCase

  # в качестве аргумента стоит использовать только поле text,
  # использовать остальные аргументы в конструкторе - бессмысленно

  fixtures :const_answers

  test "обязательно должен быть text" do
    answer = ConstAnswer.new
    assert answer.invalid?
    assert answer.errors[:text].any?
    assert !answer.errors[:vector].any?
  end

  test "достаточно отправить лишь аргумент text" do
    answer = ConstAnswer.new text: 'Для добавления новой выборки нажмите на кнопку "+" в правом нижнем углу'
    assert answer.valid?
    assert !answer.errors[:text].any?
    assert !answer.errors[:vector].any?
  end

  test "проверака на уникальность text" do
    answer = ConstAnswer.new text: 'Нажмите на кнопку в правом верхнем углу, обучение потребует время.'
    assert answer.invalid?
    assert answer.errors[:text].any?
    assert !answer.errors[:vector].any?
  end

  test "проверака на уникальность vector" do
    answer = ConstAnswer.new text: 'Для добавления новой выборки нажмите на кнопку "+" в правом нижнем углу', vector: [ 0, 1 ]
    assert answer.invalid?
    assert !answer.errors[:text].any?
    assert answer.errors[:vector].any?
  end

end
