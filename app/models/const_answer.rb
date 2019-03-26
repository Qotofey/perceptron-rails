class ConstAnswer < ApplicationRecord

  has_many :const_questions, dependent: :destroy

  validates :text, presence: true, uniqueness: true
  validates :vector, uniqueness: true, allow_nil: true

  serialize :vector, Array

  before_create do
    puts "before_create"
    ConstAnswer.all.each do |answer|
      answer.vector.push 0
      answer.save
      self.vector << 0
    end
    self.vector << 1
  end

end
