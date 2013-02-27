class UsersController < ApplicationController
  before_filter :fetch_user, only: [:show, :update, :destroy]
  respond_to :json, :html

  def index
    respond_with User.all
  end

  def show
    respond_with @user
  end

  def create
    respond_with User.create(params[:user])
  end

  def update
    respond_with @user.update_attributes(params[:user])
  end

  def destroy
    respond_with @user.destroy
  end

  def check
    if User.where(username: /^#{params[:username]}$/i).any?
      respond_with(available: false, message: "Username is taken.")
    else
      respond_with(available: true, message: "Username is available.")
    end
  end
end
