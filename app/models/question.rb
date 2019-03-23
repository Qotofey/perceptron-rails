class Question < ApplicationRecord
  require 'concerns/porter_stemmer'
  include PorterStemmer

  belongs_to :answer

  validates :text, presence: true, uniqueness: true
  validates :vector, uniqueness: false
  validates :basics, uniqueness: false

  serialize :vector, Array
  serialize :basics, Array

  # after_create :filtered
  # after_create :after_event_add_new_question
  # after_update :after_event_add_new_question
  # after_update :filtered
  #
  # before_update :clean

  def filtered
    arr = text.downcase.scan(/(?:[a-zа-яё])+/)
    arr.each do |word|
      w = Word.create(value: stem(word))
      if w.id.nil?
        self.basics.push Word.all.where(value: w.value).first.id
      else
        self.basics.push w.id
      end
    end
    self.save
  end

  def clean
    self.basics = []
    self.vector = []
    self.save
  end

  def after_event_add_new_question
    Question.all.each { |q| q.vector = [] }
  end


end

#rake db:drop db:migrate db:seed
