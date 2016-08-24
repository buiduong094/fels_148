class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers
  has_many :results
end
