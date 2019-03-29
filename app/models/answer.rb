class Answer < ApplicationRecord
  require 'concerns/porter_stemmer'
  include PorterStemmer

  has_many :questions, dependent: :destroy

  validates :text, presence: true, uniqueness: true
  validates :stem_text, presence: true, uniqueness: true

  serialize :stem_text, Array

  after_initialize :stemming_text
  before_update :stemming_text

  def stemming_text
    word_array = self.text.to_s.downcase.scan(/(?:[а-яё+])+/)
    self.stem_text = word_array.map { |w| stem(w) }
  end

  # before_create :normalize_other_vectors
  # after_create :create_vectors

  # def create_vectors
  #   size = Answer.all.size - 1
  #
  #   a = Answer.all[size]
  #   for i in 0...size do
  #     a.vector << 0
  #   end
  #   a.vector << 1
  #   a.save
  # end
  #
  # def normalize_other_vectors
  #   for i in 0...Answer.all.size do
  #     answer = Answer.all[i]
  #     answer.vector << 0
  #     answer.save
  #   end
  # end

end

=begin
git add .
git commit -am "fix prod"
git push
cap production deploy

=end