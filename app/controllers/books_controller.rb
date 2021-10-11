class BooksController < ApplicationController
  def new
  end

  def create
  end

  def index
    @user = User.find(current_user.id)
    @books = Book.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
