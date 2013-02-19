class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user

  private
    def current_user
      if session[:user_id]
        @current_user ||= User.find(session[:user_id])
      end
    end

    helper_method :current_user
  #end_private
end
