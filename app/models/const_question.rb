class ConstQuestion < ApplicationRecord

  belongs_to :const_answer

  validates :const_answer_id, presence: true
  validates :text, presence: true, uniqueness: true
  validates :vector, uniqueness: true, allow_nil: true
  validates :basics, uniqueness: true, allow_nil: true

  serialize :vector, Array
  serialize :basics, Array

  after_initialize do

  end

end
