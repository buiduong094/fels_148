class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers
  has_many :results

  query = "content like :search"
  scope :search_word, -> search do
    where query, search: "%#{search}%" if search.present?
  end

end
