class WidgetsController < ApplicationController
  before_filter :fetch_user
  respond_to :json, :html

  def index
    respond_with @user.widgets
  end

  def show
    respond_with Widget.find(params[:id])
  end

  def create
    user = User.find(params[:user_id])
    respond_with user, Widget.create(params[:widget])
  end

  def update
    respond_with Widget.find(params[:id]).update_attributes(params[:widget])
  end

  def destroy
    widget = Widget.find(params[:id])
    respond_with widget.destroy
  end
end
