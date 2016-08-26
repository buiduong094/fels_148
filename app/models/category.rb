class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words

  query = "name like :search OR description like :search"
  scope :search_category, -> search {where query, search: "%#{search}%"}

end
