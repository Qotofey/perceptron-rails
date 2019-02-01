class Layer < ApplicationRecord

  belongs_to :perceptron

  validates :outputs, presence: true
  validates :inputs, presence: true

  serialize :weights, JSON

  after_create :generate_weights

  def generate_weights
    # row_count =
    self.weights = Matrix.build(self.inputs, self.outputs) { rand -1.0..1.0 }
    self.save
  end

  def predict vector
    Mapper::bipolar(vector * Matrix[*self.weights])
  end

end
