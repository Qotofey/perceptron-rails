class Word < ApplicationRecord

  validates :value, presence: true, uniqueness: true
  validates :vector, uniqueness: true, allow_nil: true

  serialize :vector, Array

  before_create do
    Word.all.each do |word|
      word.vector.push 0
      word.save
      self.vector << 0
    end
    self.vector << 1
  end

  # def create_vectors
  #   size = Word.all.size - 1
  #
  #   for i in 0...size do
  #     a = Word.all[i]
  #     a.vector << 0
  #     a.save
  #   end
  #
  #   a = Word.all[size]
  #   for i in 0...size do
  #     a.vector << 0
  #   end
  #   a.vector << 1
  #   a.save
  # end

end
