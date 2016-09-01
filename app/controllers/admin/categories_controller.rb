class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user, except: [:show]
  before_action :check_admin
  before_action :load_category, except: [:index, :new, :create]

  def index
    @categories = Category.all.order("created_at DESC")
      .paginate page: params[:page], per_page: Settings.admin.category.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "page.admin.categories.create_category_success"
      redirect_to admin_categories_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "page.admin.categories.update_success"
      redirect_to admin_categories_url
    else
      flash[:danger] = t "page.admin.categories.update_fail"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      respond_to do |format|
        format.html {redirect_to categories_url}
        format.js
      end
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end
end
