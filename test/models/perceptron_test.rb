require 'test_helper'

class PerceptronTest < ActiveSupport::TestCase

  fixtures :answers
  fixtures :questions
  fixtures :perceptrons

  setup do

    @perceptron = Perceptron.create size: 3
  end

  test "create perceptron" do
    perceptron = Perceptron.create(size: 3)
    assert perceptron.valid?
    assert_equal 1, Perceptron.all.size # при генерации новой ИНС старая должна быть удалена
    assert !perceptron.errors[:size].any?
    assert !perceptron.errors[:layers].any?
    assert !perceptron.errors[:coefficient].any?
    puts perceptron.learn( 100)[:result_error]

    # perceptron = Perceptron.create(size: 4)
    # assert perceptron.valid?
    # puts perceptron.learn( 100)[:result_error]
  end

  test "проверка работоспособности функций персептрона" do
    assert @perceptron.valid?
    assert_equal 3, @perceptron.layers.size
    assert_equal 1, Perceptron.all.size
    assert_equal @perceptron.layers.first.size_inputs, Word.all.size
    assert_equal @perceptron.layers.first.size_inputs, ConstQuestion.first.vector.size
    assert_equal @perceptron.layers.last.size_outputs, ConstQuestion.all.size

  end

  test "корректность обучения" do
    assert @perceptron.learn 1
    assert @perceptron.learn 10
    assert @perceptron.learn 100
  end

  test "задать вопрос" do
    assert @perceptron.ask 'как добавить новую обучающую выборку?'
  end

end
