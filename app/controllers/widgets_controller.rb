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
    respond_with Widget.create(params[:widget])
  end

  def update
    respond_with Widget.find(params[:id]).update_attributes(params[:widget])
  end

  def destroy
    respond_with Widget.destroy(params[:id])
  end
end
