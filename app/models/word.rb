class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers
  has_many :results

  QUERY_LEARNED = "content like :search and id in (select word_id
    FROM results r INNER JOIN lessons l
    ON r.lesson_id = l.id AND l.user_id = :user_id)"
  QUERY_NOT_LEARNED = "content like :search and id not in (select word_id
    FROM results r INNER JOIN lessons l
    ON r.lesson_id = l.id AND l.user_id = :user_id)"

  scope :in_category, -> category_id do
    where category_id: category_id if category_id.present?
  end

  scope :show_all, -> user_id, search {}
  scope :learned, -> (user_id, search) {
    where QUERY_LEARNED, user_id: user_id, search: "%#{search}%"}
  scope :not_learned, -> (user_id, search) {
    where QUERY_NOT_LEARNED, user_id: user_id, search: "%#{search}%"}

end
