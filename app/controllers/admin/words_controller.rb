class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :check_admin
  before_action :load_word, except: [:index, :new, :create]
  before_action :load_all_category, except: [:show, :create, :destroy]

  def new
    @word = Word.new
    @button_in_form = t "page.admin.words.create"
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
    @words = Word.in_category(params[:category_id])
      .send(params[:word_filter], current_user.id, params[:search])
      .paginate page: params[:page], per_page: Settings.category.per_page
  end

  def edit
    params[:category_id] = @word.category_id if @word
    @button_in_form = t "page.admin.words.update"
  end

  def update
    if @word.update_attributes word_params
      @word.save
      flash[:success] = t "page.admin.words.update_success"
      params[:category_id] = @word.category_id if @word
      redirect_to [:admin, @word]
    else
      render "edit"
    end
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

  def load_all_category
    @categories = Category.all
  end

  def word_params
    params.require(:word).permit :content, :category_id,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
