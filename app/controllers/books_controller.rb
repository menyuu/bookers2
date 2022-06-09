class BooksController < ApplicationController

  before_action :correct_book, only: [:edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  def index
    @book = Book.new
    @books = Book.all.order("#{sort_column} #{sort_direction}")
    @user = current_user
    @tags = Tag.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list = params[:book][:tag_name].split(",")
    if @book.save
      @book.save_tag(tag_list)
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.new
    book = Book.find(params[:id])
    @user = book.user
    @book_comment_new = BookComment.new
    @book_show = book
    @tags = book.tags
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if  @book.update(book_params)
     flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body, :rate)
  end

  def correct_book
    book = Book.find(params[:id])
    if current_user.id != book.user_id
      redirect_to books_path
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_column
    Book.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

end