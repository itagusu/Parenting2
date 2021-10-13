class Public::SearchesController < ApplicationController

  def search
    @posts = Post.looks(params[:word])
    @genres = Genre.all
    #@users = User.looks(params[:word])
  end

  def genre
    @genre = Genre.find(params[:id])
    @posts = @genre.posts
    @genres = Genre.all
  end
end
