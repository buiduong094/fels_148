class CategoriesController < ApplicationController
  before_action :logged_in_user

  def index
    if search = params[:search]
      @categories = (Category.search_category search)
        .paginate page: params[:page], per_page: Settings.category.per_page
      @categories = Category.search_category search, params[:page]
    else
      @categories = Category.all.paginate page: params[:page],
        per_page: Settings.category.per_page
    end
  end

  def new
    @category = Category.new
  end

  def show
    @category = Category.find_by id: params[:id]
    if @category.nil?
      flash[:danger] = t "page.category.check_category_nil"
      redirect_to root_path
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end
end
