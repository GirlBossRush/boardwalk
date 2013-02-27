class UsersController < ApplicationController
  respond_to :json, :html

  def index
    respond_with User.all
  end

  def show
    if Moped::BSON::ObjectId.legal?(params[:id])
      respond_with User.find(params[:id])
    else
      respond_with User.find_by(_slugs: /^#{params[:id]}$/i)
    end
  end

  def create
    respond_with User.create(params[:user])
  end

  def update
    respond_with User.find(params[:id]).update_attributes(params[:user])
  end

  def destroy
    respond_with User.destroy(params[:id])
  end

  def check
    if User.where(username: /^#{params[:username]}$/i).any?
      respond_with(available: false, message: "Username is taken.")
    else
      respond_with(available: true, message: "Username is available.")
    end
  end
end
