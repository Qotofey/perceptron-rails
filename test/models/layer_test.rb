require 'test_helper'

class LayerTest < ActiveSupport::TestCase

  test "create layer" do
    layer = Layer.new(size_inputs: 4, size_outputs: 4, perceptron: Perceptron.new(size: 2))
    assert layer.valid?
    assert !layer.errors[:inputs].any?
    assert !layer.errors[:outputs].any?
    assert !layer.errors[:weights].any?
    assert !layer.errors[:perceptron].any?
  end

end
