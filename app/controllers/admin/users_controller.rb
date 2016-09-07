class Admin::UsersController < ApplicationController
  before_action :logged_in_user, except: [:show]
  before_action :check_admin, only: [:index, :show, :destroy]
  before_action :load_user, only: [:edit, :show, :destroy]

  def index
    if params[:search]
      @users = User.search(params[:search]).paginate page: params[:page],
        per_page: Settings.users.per_page
    else
      @users = User.all.paginate page: params[:page],
        per_page: Settings.admin.users.per_page
    end
  end

  def show
  end

  def destroy
    if @user.destroy
      flash[:success] = @user.name + t("page.admin.users.delete_user_success")
    else
      flash[:danger] = @user.name + t("page.admin.users.delete_user_fail")
    end
    redirect_to admin_users_url
  end
end
