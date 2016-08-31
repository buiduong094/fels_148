class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :load_lesson, :correct_lesson_of_user, only: [:edit, :update, :show]
  before_action :load_category, only: :create
  before_action :is_completed_lesson, only: [:edit, :update]
  before_action :uncompleted_lesson, only: :show

  def create
    @lesson = Lesson.new category_id: @category.id, user_id: current_user.id
    if @lesson.save
      flash[:success] = t "page.lessons.create_lesson_success"
      redirect_to edit_lesson_path @lesson
    else
      flash[:danger] = t "page.lessons.create_lesson_fail"
      redirect_to categories_path
    end
  end

  def index
  end

  def edit
  end

  def update
    is_completed_lesson_params = lesson_params
    if params[:commit].eql? t("page.lessons.btn_submit")
      is_completed_lesson_params[:is_complete] = true
      @lesson.update_attributes is_completed_lesson_params
      flash[:success] = t "page.lessons.submit_success"
      redirect_to @lesson
    else
      is_completed_lesson_params[:is_complete] = false
      @lesson.update_attributes is_completed_lesson_params
      flash[:success] = t "page.lessons.save_success"
      redirect_to user_path current_user
    end
  end

  def show
  end

  private
  def is_completed_lesson
    if @lesson.is_complete?
      flash[:danger] = "page.lessons.already_submit"
      flash.now[:info] = t "page.lessons.flash_iscompleted"
      redirect_to lesson_path @lesson
    end
  end

  def uncompleted_lesson
    unless @lesson.is_complete?
      flash[:danger] = t "page.lessons.flash_uncompleted"
      redirect_to edit_lesson_path @lesson
    end
  end

  def load_category
    @category = Category.find_by id: params[:category_id]
    unless @category
      flash[:danger] = t "page.lessons.msg_category_nil"
      redirect_to categories_path
    end
  end

  def load_lesson
    @lesson= Lesson.find_by id: params[:id]
    unless @lesson
      flash[:danger] = t "page.lessons.not_found_user"
      redirect_to categories_path
    end
  end

  def correct_lesson_of_user
    unless current_user.current_user? @lesson.user
      flash[:danger] =  t "page.lessons.not_found_lesson"
      redirect_to root_url
    end
  end

  def lesson_params
    params.require(:lesson).permit :is_complete,
      results_attributes: [:id, :word_answer_id]
  end
end
