class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      @activities = Activity.activity_in_user(current_user.id)
        .order("created_at DESC").paginate page: params[:page],
          per_page: Settings.activities.per_page
      respond_to do |format|
        format.html
        format.json {render json: {
          content: render_to_string({
            partial: "shared/activities", formats: "html", layout: false
          })
        }}
      end
    end
  end
end
