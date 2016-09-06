class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def show
    find_user params[:id]
    @users = @user.send("#{params[:query]}")
  end

  def index
    find_user params[:user_id]
    if @user
      flash[:danger] = t "page.users.profile.user_nil"
      redirect_to root_path
    else
      @users = @user.send(@relationship).paginate page: params[:page],
        per_page: Settings.size
    end
  end

  def create
    find_user params[:followed_id]
    unless current_user.following? @user
      current_user.follow @user
    end
    @active_relationship = current_user.active_relationships.
      find_by followed_id: @user.id
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @relationship = Relationship.find_by id: params[:id]
    if @relationship.nil?
      flash[:danger] = t "page.users.relationship.cant_find_relationship"
      redirect_to root_path
    else
      @user = @relationship.followed
      current_user.unfollow @user
      @active_relationship = current_user.active_relationships.build
    end
      respond_to do |format|
      format.js
    end
  end

  private
  def find_user user_id
    @user = User.find_by id: user_id
    if @user.nil?
      flash[:danger] = t "page.users.profile.user_nil"
      redirect_to root_path
    end
  end
end
