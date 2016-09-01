class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_user, only: :create

  def index
    @user = User.find_by id: params[:user_id]
    if @user
      flash[:danger] = t "page.users.profile.user_nil"
      redirect_to root_path
    else
      @users = @user.send(@relationship).paginate page: params[:page],
        per_page: Settings.size
    end
  end

  def create
    unless current_user.following? @user
      current_user.follow @user
      @relationship = current_user.active_relationships.
        find_by(followed_id: @user.id)
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @relationship = Relationship.find_by id: params[:id]
    if @relationship.nil?
      flash[:danger] = t "page.relationship.cant_find_relationship"
      redirect_to root_path
    else
      @user = @relationship.followed
      current_user.unfollow @user
      @relationship = current_user.active_relationships.build
    end
    respond_to do |format|
      format.js
    end
  end

  private
  def find_user
    @user = User.find_by id: params[:followed_id]
    if @user.nil?
      flash[:danger] = t "page.users.profile.user_nil"
      redirect_to root_path
    end
  end
end
