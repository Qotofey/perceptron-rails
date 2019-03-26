require 'test_helper'

class PerceptronTest < ActiveSupport::TestCase

  fixtures :perceptrons

  test "create perceptron" do
    perceptron = Perceptron.create(size: 3)
    assert perceptron.valid?
    assert_equal 1, Perceptron.all.size # при генерации новой ИНС старая должна быть удалена

    assert !perceptron.errors[:size].any?
    assert !perceptron.errors[:layers].any?
  end

end
