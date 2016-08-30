class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "page.update_user.message"
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to root_url unless current_user.current_user? @user
  end

  def load_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "page.user_nil"
      redirect_to root_path
    end
  end

  def load_category
    @category = Category.find_by id: params[:id]
      if @category.nil?
        flash[:danger] = t "page.admin.categories.find"
        redirect_to admin_categories_url
      end
  end

  def check_admin
      redirect_to root_path unless current_user.is_admin?
  end
end
