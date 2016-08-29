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
end
