class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :check_admin
  before_action :load_word, only: [:show, :destroy]
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

  def show
  end

  def index
    params[:search] ||= ""
    params[:word_filter] ||= Settings.word_filter[:all]
    @categories = Category.all
    @words = Word.in_category(params[:category_id])
      .send(params[:word_filter], current_user.id, params[:search])
      .paginate page: params[:page], per_page: Settings.category.per_page
  end

  def destroy
    if @word
      @word.destroy
      respond_to do |format|
        format.html {redirect_to words_url}
        format.js
      end
    end
  end

  private
  def load_word
    @word = Word.find_by id: params[:id]
    redirect_to root_path if @word.nil?
  end

  def word_params
    params.require(:word).permit :content, :category_id,
      answers_attributes: [:content, :is_correct, :_destroy]
  end
end
