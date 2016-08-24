class Answer < ActiveRecord::Base
  has_many :results
  belongs_to :word
end
