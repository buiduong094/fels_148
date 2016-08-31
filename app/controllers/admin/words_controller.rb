class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :check_admin
  def new
    @categories = Category.all
    @word = Word.new
  end
  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t "page.admin.words.create_success"
    else
      flash[:danger] = @word.errors.full_messages
    end
    redirect_to :back
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id,
      answers_attributes: [:content, :is_correct, :_destroy]
  end

end
