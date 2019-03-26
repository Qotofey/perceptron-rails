class ConstQuestion < ApplicationRecord
  require 'concerns/porter_stemmer'
  include PorterStemmer
  require 'matrix'

  belongs_to :const_answer

  validates :const_answer_id, presence: true
  validates :text, presence: true, uniqueness: true
  validates :vector, uniqueness: true, allow_nil: true
  validates :basics, uniqueness: true, allow_nil: true

  serialize :vector, Array
  serialize :basics, Array

  before_create do
    self.text
        .downcase
        .scan(/(?:[а-яё+])+/)
        .map { |w| stem(w) }
        .each { |word| self.basics.push(Word.where(value: word).first.id) }
    self.vector = Vector.zero(Word.all.size).to_a

  end

end
