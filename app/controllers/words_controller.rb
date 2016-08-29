class WordsController < ApplicationController
  before_action :logged_in_user

  def show
    @word = Word.find_by id: params[:id]
    redirect_to root_path if @word.nil?
  end

  def index
    params[:search] ||= ""
    params[:word_filter] ||= Settings.word_filter[:all]
    @categories = Category.all
    @words = Word.in_category(params[:category_id])
      .send(params[:word_filter], current_user.id, params[:search])
      .paginate page: params[:page], per_page: Settings.category.per_page
  end

end
