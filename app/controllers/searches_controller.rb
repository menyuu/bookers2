class SearchesController < ApplicationController
  def search
    @model = params[:model]
    if @model == 'user'
      @users = User.looks(params[:word], params[:search])
    else
      @books = Book.looks(params[:word], params[:search])
    end
  end

  def tag_search
    @tags = Tag.all
    unless params[:tag_word]
      @tag = Tag.find(params[:tag_id])
      @books = @tag.books
    else
      @tag = Tag.find_by(tag_name: params[:tag_word])
      @books = @tag.books
    end
  end

end
