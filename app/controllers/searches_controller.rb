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
    if params[:tag_word]
      if params[:tag_word] == ""
        @books = Book.all
        @tag_name = "All books"
      else
        @tag = Tag.find_by(tag_name: params[:tag_word])
        @books = @tag.books
        @tag_name = @tag.tag_name
      end
    else
      @tag = Tag.find(params[:tag_id])
      @books = @tag.books
      @tag_name = @tag.tag_name
    end
  end
end
