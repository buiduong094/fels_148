class Answer < ActiveRecord::Base
  scope :correct, -> {where is_correct: true}
  has_many :results
  belongs_to :word
  validates :content, length: {maximum: 45}

  QUERY = "is_correct = :is_correct AND id in (select word_answer_id
    FROM results r INNER JOIN lessons l
    ON r.lesson_id = l.id AND r.lesson_id = :lesson_id)"

  scope :correct_answers, -> lesson_id {where QUERY, is_correct: true,
    lesson_id: lesson_id}
end
