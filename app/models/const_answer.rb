class ConstAnswer < ApplicationRecord

  has_many :const_questions, dependent: :destroy

  validates :text, presence: true, uniqueness: true
  validates :vector, uniqueness: true, allow_nil: true

  serialize :vector, Array

  after_initialize do

  end

end
