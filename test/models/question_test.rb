require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

  test "question attribute text must not be empty" do
    # свойство вопроса text не должно быть пустым
    question = Question.new
    assert question.invalid?
    assert question.errors[:text].any?
    assert question.errors[:answer].any?
    assert !question.errors[:vector].any?
  end

  test "объект не должен создаваться с одним аргументом text" do
    question = Question.new(text: 'Вопрос должен быть на русском языке?')
    assert question.invalid?
    assert question.errors[:answer].any?
    assert !question.errors[:text].any?
    assert !question.errors[:vector].any?
  end

  test "объект должен создаваться с аргументами text и answer" do
    question = Question.new(text: 'Вопрос на русском языке?', answer: Answer.create(text: 'text answer'))
    assert question.valid?
    assert !question.errors[:answer].any?
    assert !question.errors[:text].any?
    assert !question.errors[:basics].any?
    assert !question.errors[:vector].any?
  end

  test "объект не должен создаваться с одним аргументом vector" do
    question = Question.new(vector: [1, 0, 0, 0, 0])
    assert question.invalid?
    assert question.errors[:text].any?
    assert question.errors[:answer].any?
    assert !question.errors[:vector].any?
  end

  test "объект не должен создаваться с аргументами vector и answer" do
    question = Question.new(vector: [0, 1, 0, 0, 0], answer: Answer.create(text: 'text answer'))
    assert question.invalid?
    assert question.errors[:text].any?
    assert !question.errors[:answer].any?
    assert !question.errors[:vector].any?
  end

  test "объект не должен создаваться если нет аргумента answer" do
    question = Question.new(text: 'text test question', vector: [0, 0, 1, 0, 0])
    assert question.invalid?
    assert question.errors[:answer].any?
    assert !question.errors[:text].any?
    assert !question.errors[:vector].any?
  end

  test "объект должен создаваться если есть все аргументы" do
    question = Question.new(text: 'Все вопросы должны быть на русском языке', vector: [0, 0, 0, 1, 0], answer: Answer.create(text: 'text answer'))
    assert question.valid?
    assert !question.errors[:answer].any?
    assert !question.errors[:text].any?
    assert !question.errors[:vector].any?
    assert !question.errors[:basics].any?
  end

end
