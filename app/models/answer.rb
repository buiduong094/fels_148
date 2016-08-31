class Answer < ActiveRecord::Base
  has_many :results
  belongs_to :word
  validates :content, presence: true, length: {maximum: 45}
end
