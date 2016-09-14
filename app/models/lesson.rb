class Lesson < ActiveRecord::Base
  before_create :create_questions
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  validates :category, presence: true
  validate :validate_words_size
  after_create :create_lesson_activity
  after_update :update_lesson_activity
  accepts_nested_attributes_for :results

  scope :user_own, -> (user) {where user_id: user.id }

  def create_questions
    words = self.category.words.shuffle().take Settings.lesson.number_words
    words.each do |word|
      self.results.build word_id: word.id
    end
  end

  def number_correct
    if self.is_complete?
      Answer.correct id
    end
  end

  private
  def create_lesson_activity
    create_activity Activity.activity_types[:create_lesson],
      I18n.t("page.activities.create_lesson")
  end

  def update_lesson_activity
    create_activity Activity.activity_types[:update_lesson],
      I18n.t("page.activities.update_lesson")
  end

  def create_activity action_type, content
    Activity.create user_id: self.user_id, target_id: self.id,
      action_type: action_type, content: content
  end
  def validate_words_size
    if self.category.words.size < Settings.lesson.number_words
      errors.add :word, I18n.t("page.lesson.err_create_lesson")
    end
  end
end
