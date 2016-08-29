class WordsController < ApplicationController
  before_action :logged_in_user

  def show
    @word = Word.find_by id: params[:id]
    redirect_to root_path if @word.nil?
  end

  def index
    params[:search] ||= ""
    @words = (Word.search_word params[:search]).order(category_id: :desc)
      .paginate page: params[:page], per_page: Settings.category.per_page
    @categories = Category.all
  end

end
