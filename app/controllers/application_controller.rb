class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def handle_unverified_requests
    sign_out
    super
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin? && User.find(params[:id]) != current_user
  end

  def user_exists
    redirect_to(current_user) unless !signed_in?
  end

end
