class UsersController < ApplicationController
  def index
  end

  def show
    @user = current_user
    @book = Book.new
    @books = @user.books
  end

  def edit
  end
end
