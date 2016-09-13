class SessionsController < ApplicationController

  def create
    if params[:session][:email]
      user = User.find_by email: params[:session][:email]
      if user && user.authenticate(params[:session][:password])
        log_in user
        params[:session][:remember_me] == Settings.remembered ? remember(user) :
          forget(user)
        redirect_to root_path
      else
        flash.now[:danger] = t "page.invalid_email"
        render :new
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
