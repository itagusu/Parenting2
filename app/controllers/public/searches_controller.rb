class Public::SearchesController < ApplicationController
  def search
    @posts = Post.looks(params[:word]).page(params[:page]).per(7).order(created_at: :desc)
    @genres = Genre.all
    @users = User.looks(params[:word])
  end

  def genre
    @genre = Genre.find(params[:id])
    @posts = @genre.posts.page(params[:page]).per(7).order(created_at: :desc)
    @genres = Genre.all
  end
end
