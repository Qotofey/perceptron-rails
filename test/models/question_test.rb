require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

  # в качестве аргумента стоит использовать только поле text,
  # использовать остальные аргументы в конструкторе - бессмысленно

  fixtures :questions

  test "question attribute text must not be empty" do
    # свойство вопроса text не должно быть пустым
    question = Question.new
    assert question.invalid?
    assert question.errors[:text].any?
    assert question.errors[:answer].any?
  end

  test "объект не должен создаваться с одним аргументом text" do
    question = Question.new(text: 'Вопрос должен быть на русском языке?')
    assert question.invalid?
    assert !question.errors[:text].any?
    assert question.errors[:answer].any?
  end

  test "объект должен создаваться с аргументами text и answer" do
    question = Question.new(text: 'Вопрос на русском языке?', answer: Answer.create(text: 'Вопрос должен быть написан на кирилице'))
    assert question.valid?
    assert !question.errors[:text].any?
    assert !question.errors[:answer].any?
  end

  test "объект не должен создаваться с аргументами vector и answer" do
    question = Question.new(answer: Answer.create(text: 'Вопрос должен быть написан на кирилице'))
    assert question.invalid?
    assert question.errors[:text].any?
    assert !question.errors[:answer].any?
  end

  test "объект не должен создаваться если нет аргумента answer" do
    question = Question.new(text: 'Вопрос на русском языке?')
    assert question.invalid?
    assert !question.errors[:text].any?
    assert question.errors[:answer].any?
  end

  test "объект должен создаваться если есть все аргументы" do
    question = Question.new(
        text: 'Все вопросы должны быть на русском языке',
        answer: Answer.create(text: 'Вопрос должен быть написан на кирилице')
    )
    assert question.valid?
    assert_not question.errors[:text].any?
    assert_not question.errors[:answer].any?
  end

end
