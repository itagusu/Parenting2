class Public::SearchesController < ApplicationController

  def search
    @posts = Post.looks(params[:word])
  end

  def genre
    @genre = Genre.find(params[:id])
    @posts = @genre.posts
  end
end
