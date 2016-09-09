class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @activities = Activity.activity_in_user(current_user.id)
       .order("created_at DESC").paginate page: params[:page],
         per_page: Settings.activities.per_page
    end
  end
end
