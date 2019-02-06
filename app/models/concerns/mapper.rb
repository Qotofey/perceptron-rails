require 'matrix'

class Mapper

  def self.bipolar matrix
    m = matrix.map { |value| num_bipolar value }
  end

  def self.derivative_bipolar matrix
    m = matrix.map { |value| num_derivative_bipolar value }
  end

  def self.sigmoid matrix
    m = matrix.map { |value| num_sigmoid value }
  end

  def self.derivative_sigmoid matrix
    m = matrix.map { |value| num_derivative_sigmoid value }
  end

  private

  def self.num_bipolar x
    y = Math::tanh x
  end

  def self.num_derivative_bipolar x
    y = 1 / (Math::cosh(x) ** 2)
  end

  def self.num_sigmoid x
    y = 1 / (1 + Math::exp(-x))
  end

  def self.num_derivative_sigmoid x
    y = num_sigmoid(x) * (1 - num_sigmoid(x))
  end

end