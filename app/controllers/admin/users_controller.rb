class Admin::UsersController < ApplicationController
  before_action :logged_in_user, except: [:show]
  before_action :check_admin, only: [:index, :show, :destroy]
  before_action :load_user, only: [:show, :destroy]

  def index
    if params[:search]
      @users = User.search(params[:search]).paginate page: params[:page]
    else
      @users = User.paginate page: params[:page]
    end
  end

  def show
  end

  def destroy
    if @user.destroy
      flash[:success] = @user.name + "page.admin.users.delete_success"
    else
      flash[:danger] = @user.name + "page.admin.users.delete_fail"
    end
    redirect_to admin_users_url
  end
end
