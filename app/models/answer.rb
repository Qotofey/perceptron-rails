class Answer < ApplicationRecord
  has_many :questions, dependent: :destroy

  validates :text, presence: true, uniqueness: true
  # validates :vector, uniqueness: true, allow_nil: true

  serialize :vector, Array

  after_create :create_vectors
  before_create do
    self.vector = []
  end

  def create_vectors
    size = Answer.all.size - 1

    for i in 0...size do
      _a = Answer.all[i]
      _a.vector << 0
      _a.save
    end

    _answ = Answer.all[size]
    for i in 0...size do
      _answ.vector << 0
    end
    _answ.vector << 1
    _answ.save
  end

end
