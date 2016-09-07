class Lesson < ActiveRecord::Base
  before_create :create_questions
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  validates :category, presence: true

  accepts_nested_attributes_for :results

  scope :user_own, -> (user) {where user_id: user.id }

  def create_questions
    if self.category.words.size >= Settings.lesson.number_words
      words = self.category.words.shuffle().take Settings.lesson.number_words
      words.each do |word|
        self.results.build word_id: word.id
      end
    else
      flash[:danger] = t "page.lesson.err_create_lesson"
      redirect_to @category
    end
  end

  def number_correct
    if self.is_complete?
      Answer.correct id
    end
  end
end
