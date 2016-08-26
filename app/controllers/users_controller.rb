class UsersController < ApplicationController
  before_action :logged_in_user, :load_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "page.register.sign_up_successful"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "page.update_user.update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def load_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "page.user_nil"
      redirect_to root_path
    end
  end
end
