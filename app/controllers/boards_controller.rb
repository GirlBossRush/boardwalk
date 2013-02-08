class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def show
  end

  def create
    @board = Board.create params[:board]
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
