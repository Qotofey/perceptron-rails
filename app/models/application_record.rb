class ApplicationRecord < ActiveRecord::Base
  require 'matrix'
  require_relative 'concerns/mapper'

  self.abstract_class = true
end
