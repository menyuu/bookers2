class SearchesController < ApplicationController
  def search
    @model = params[:model]
    if @model == 'User'
      @users = User.looks(params[:word], params[:search])
    else
      @books = Book.looks(params[:word], params[:search])
    end
  end
end
