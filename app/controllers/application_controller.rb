class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user

  private
    def current_user
      if session[:user_id]
        @current_user ||= User.find(session[:user_id])
      end
    end

    def fetch_user
      id = params[:id] || params[:user_id]

      if Moped::BSON::ObjectId.legal?(id)
        @user = User.find(id)
      else
        @user = User.find_by(_slugs: /^#{id}$/i)
      end
    end

    helper_method :current_user
    helper_method :fetch_user
  #end_private
end
