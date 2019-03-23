class Answer < ApplicationRecord
  has_many :questions, dependent: :destroy

  validates :text, presence: true, uniqueness: true
  # validates :vector, uniqueness: true, allow_nil: true

  serialize :vector, Array

  after_create :create_vectors

  def create_vectors
    size = Answer.all.size - 1

    for i in 0...size do
      Answer.all[i].vector << 0
      Answer.all[i].save
    end

    a = Answer.all[size]
    for i in 0...size do
      a.vector << 0
    end
    a.vector << 1
    a.save
  end

end

=begin
git add .
git commit -am "fix prod"
git push
cap production deploy
=end