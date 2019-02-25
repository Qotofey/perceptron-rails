class Perceptron < ApplicationRecord
  require 'concerns/porter_stemmer'
  include PorterStemmer

  has_many :layers, dependent: :destroy

  validates :size, presence: true

  after_create :build

  def build
    size_inputs = Word.all.size
    size_outputs = Answer.all.size

    for i in 0...size
      if i == size - 1
        Layer.create(size_inputs: size_inputs, size_outputs: size_outputs, perceptron: self)
      else
        Layer.create(size_inputs: size_inputs, size_outputs: size_inputs, perceptron: self)
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
  def learn epochs
    Question.all.each do |question|
      _vector = Vector.zero(Word.all.size)
      question.basics.each do |num|
        _vector += Vector[*Word.find(num).vector]
      end
      question.vector = _vector.to_a
      question.save
    end

    for i in (0..epochs)
      error = 0
      Question.all.each do |question|
        error += train question.vector, question.answer.vector
      end
    end
  end

  # обратное распространение ошибки, одна итерация
  def train inputs, expected
    actual = put inputs # actual of Matrix
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
    gradients = Mapper::derivative_bipolar Matrix[*layer.outputs]
    delta_wights = Matrix.combine(errors, gradients) { |a, b| a * b }

    _weights = Matrix[*layer.weights]
    _weights -= (delta_wights.t * Matrix[*layer.inputs] * 0.025).t
    layer.weights = _weights
    layer.save
    return delta_wights * _weights.t
  end

  def ask text
    _vector = Vector.zero(Word.all.size)
    arr = text.downcase.scan(/(?:[a-zа-яё])+/)
    arr.each do |word|
      w = Word.where(value: stem(word)).first
      _vector += Vector[*w.vector] unless w.nil?
    end
    out = put(_vector).to_a[0]
    Answer.all[out.index(out.max)].text
  end

end

=begin
p = Perceptron.first
p.learn 0
i = Question.first.vector
e = Answer.first.vector
p.learn 40
p.put i
p.ask Question.find(1).text

=end