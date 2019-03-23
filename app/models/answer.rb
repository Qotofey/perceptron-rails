class Answer < ApplicationRecord
  has_many :questions, dependent: :destroy

  validates :text, presence: true, uniqueness: true
  # validates :vector, uniqueness: true, allow_nil: true

  serialize :vector, Array

  after_create :create_vectors

  def create_vectors
    size = Answer.all.size - 1

    for i in 0...size do
      a = Answer.all[i]
      a.vector << 0
      a.save
    end

    a = Answer.all[size]
    for i in 0...size do
      a.vector << 0
    end
    a.vector << 1
    a.save
    puts '!!!'
  end

end
