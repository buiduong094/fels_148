class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  validate :number_answer_overflow

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc{|attributes| attributes["content"].blank?}
  after_initialize :build_word_answers
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

  scope:search, ->(keyword, category_id) {
    where("content LIKE ? OR category_id = ?", "%#{keyword}%", "#{category_id}")
  }
  scope:search_category, ->(category_id = 0) {
    where("category_id is null OR category_id = ?", "#{category_id}")
  }
  scope:filter_category, ->(category_id = 0){
    where("category_id = ?", "#{category_id}")
  }

  def update_category! category
    if self.results.blank?
      return self.update_attributes category_id: category.id
    end
    return false
  end

  def destroy_category!
    if self.results.blank?
      return self.update_attributes category_id: nil
    end
    return false
  end

  private
  def build_word_answers
    if self.new_record? && self.answers.size == 0
      Settings.admin.words.default_size_word_answers.times {self.answers.build}
    end
  end

  def number_answer_overflow
    if answers.length > Settings.admin.words.max_size_word_answers
      errors.add :word, I18n.t("page.admin.words.create_overflow")
    end
  end
end
