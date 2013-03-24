class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user

  private
    def current_user
      if session[:user_id]
        begin
          @current_user ||= User.find(session[:user_id])
        rescue Mongoid::Errors::DocumentNotFound
          logger.error("User ID #{session[:user_id]} tried to login but cannot be found.")
          cookies[:current_user] = nil
          session.delete(:user_id)
        end
      end
    end

    def fetch_user
      id = params[:user_id] || params[:id]

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
