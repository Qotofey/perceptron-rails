require 'test_helper'

class ConstQuestionTest < ActiveSupport::TestCase

  # в качестве аргумента стоит использовать только поле text,
  # использовать остальные аргументы в конструкторе - бессмысленно

  fixtures :const_questions

  test "const question attribute text must not be empty" do
    # свойство вопроса text и const_answer_id не должно быть пустым
    question = ConstQuestion.new
    assert question.invalid?
    assert question.errors[:text].any?
    assert question.errors[:const_answer].any?
  end

  test "обязательно должно быть два атрибута " do
    # свойство вопроса text и const_answer_id не должно быть пустым
    question = ConstQuestion.new text: 'Вопрос должен быть на русском языке?'
    assert question.invalid? # потому что нет поля const_answer_id
    assert !question.errors[:text].any?
    assert question.errors[:const_answer].any? #возвращает ошибку
    answer = ConstAnswer.create(text: "Вопрос должен быть на кириллице")

    question = ConstQuestion.new const_answer: answer
    assert question.invalid? # потому что нет поля text
    assert question.errors[:text].any? #возвращает ошибку
    assert !question.errors[:const_answer].any?

    question = ConstQuestion.new text: 'Вопрос должен быть на русском языке?', const_answer_id: answer.id
    assert question.valid? # потому что все поля запонены
    assert_not question.errors[:text].any?
    assert_not question.errors[:const_answer].any?

    assert_not question.errors[:vector].any? #может быть пустым
    assert_not question.errors[:basics].any? #может быть пустым

  end

end
