
class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :load_user, except: [:index]
  before_action :find_user, only: [:following, :followers]

  def new
    @user = User.new
  end

  def index
    if params[:search]
      @users = User.search(params[:search]).paginate page: params[:page]
    else
      @users = User.paginate(page: params[:page])
    end
  end

  def show
    @lessons = Lesson.user_own current_user
    @lessons = Lesson.paginate page: params[:page],
      per_page: Settings.lesson.per_page
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

  def following
    @title = "Following"
    @user  = User.find_by id: params[:id]
    @users = @user.following.paginate(page: params[:page])
    render :show_follow
  end

  def followers
    @title = "Followers"
    @users = @user.followers.paginate(page: params[:page])
    render :show_follow
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def find_user
    unless @user = User.find_by(id: params[:id])
      flash[:danger] = t "page.users.profile.user_nil"
      redirect_to root_url
    end
  end
end
