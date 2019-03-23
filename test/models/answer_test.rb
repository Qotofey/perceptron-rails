require 'test_helper'

class AnswerTest < ActiveSupport::TestCase

  fixtures :answers

  test "свойство ответа text не должно быть пустым" do
    answer = Answer.new
    assert answer.invalid?
    assert answer.errors[:text].any?
  end

  test "объект должен создаваться с одним аргументом text" do
    answer = Answer.new(text: 'Во вкладке "меню" находится кнопка "настройки".')
    assert answer.valid?
    assert !answer.errors[:text].any?
    assert !answer.errors[:vector].any?
  end

  test "свойстов ответа text должно быть уникальным " do
    answer = Answer.new(text: 'Нажмите на кнопку в правом верхнем углу, обучение потребует время.')
    assert answer.invalid?
  end


end
