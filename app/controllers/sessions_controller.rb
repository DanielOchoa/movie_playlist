class SessionsController < ApplicationController

  def new
    if signed_in?
      redirect_to current_user
    end
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = 'You have logged in!'
      redirect_back_or root_path
    else
      flash[:error] = 'Invalid email/password combination'
      redirect_to signin_path
      # was like this, but this caused the path /sessions which doesn't work with GET (pressed enter on url)
      # flash.now[:error] = 'Invalid email/password combination'
      # render 'new'
    end
  end

  def destroy
    sign_out
    flash[:notice] = 'You have logged out.'
    redirect_to root_url
  end

end
