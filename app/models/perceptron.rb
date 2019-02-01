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
  #
  # # вычисляем ошибку
  # def predict_error
  #
  # end

end
