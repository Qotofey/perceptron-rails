require 'test_helper'

class PerceptronTest < ActiveSupport::TestCase

  test "create perceptron" do
    perceptron = Perceptron.new(size: 3)
    assert perceptron.valid?
    assert !perceptron.errors[:size].any?
    assert !perceptron.errors[:layers].any?
  end

end
