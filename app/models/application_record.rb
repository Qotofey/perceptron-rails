class ApplicationRecord < ActiveRecord::Base
  require 'matrix'
  require_relative 'modules/mapper'

  self.abstract_class = true
end
