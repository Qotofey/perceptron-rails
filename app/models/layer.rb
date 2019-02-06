class Layer < ApplicationRecord

  belongs_to :perceptron

  validates :size_outputs, presence: true
  validates :size_inputs, presence: true

  serialize :weights, JSON

  serialize :inputs, JSON
  serialize :outputs, JSON

  after_create :generate_weights

  def generate_weights
    self.weights = Matrix.build(self.size_inputs, self.size_outputs) { rand -1.0..1.0 }
    # puts self.weights
    self.save
  end

  def predict vector
    outs = Mapper::bipolar(vector * Matrix[*self.weights])

    self.inputs = vector
    self.outputs = outs
    self.save

    return outs
  end

end

=begin
p = Perceptron.first
i = Word.first.vector
e = Answer.first.vector
p.put i
=end