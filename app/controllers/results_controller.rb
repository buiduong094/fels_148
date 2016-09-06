class ResultsController < ApplicationController
  before_action :load_lesson, only: :new
  def new
    @list_words = @lesson.create_questions
    @result  = Result.new
  end

  private
  def load_lesson
    @lesson = Lesson.find_by id: params[:lesson_id]
  end
end
