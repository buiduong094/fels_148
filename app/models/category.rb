class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  query = "name like :search OR description like :search"
  scope :search_category, -> search {where query, search: "%#{search}%"}

end
