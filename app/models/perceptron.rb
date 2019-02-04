class Perceptron < ApplicationRecord
  has_many :layers, dependent: :destroy

  validates :size, presence: true

  after_create :build

  def build
    inputs = Word.all.size
    outputs = Answer.all.size

    for i in 0...size
      if i == size - 1
        Layer.create(inputs: inputs, outputs: outputs, perceptron: self)
      else
        Layer.create(inputs: inputs, outputs: inputs, perceptron: self)
      end
    end
  end

  # отправляем сигналы
  def put vector
    signals = Matrix[vector]
    self.layers.each do |layer|
      signals = layer.predict signals
    end
    signals
  end

  # вычисляем ошибку
  def predict_error sample

  end

  # обратное распространение ошибки, все итерации
  def learn sample_list, epochs

  end

  # обратное распространение ошибки, одна итерация
  def train inputs, expected
    actual = put inputs
    errors = actual - Matrix[expected]
    self.layers.reverse_each do |layer|
      errors = foreach_all_neurons layer, errors
    end
    e = 0
    errors.each do |error|
      e += error * error
    end
    e
  end

  def foreach_all_neurons layer, errors
    gradients = Mapper::derivative_bipolar layer.outputs
    delta_wights = Matrix.combine(errors, gradients) { |a, b| a * b }

    layer.weights -= (delta_wights.t * layer.inputs * 0.025).t
    return delta_wights * layer.weights.t
  end



end
