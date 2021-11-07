class Public::SearchesController < ApplicationController
  before_action :authenticate_user!,except: [:search, :genre]

  def search
    @posts = Post.looks(params[:word]).page(params[:page]).per(7)
    @genres = Genre.all
  end

  def genre
    @genre = Genre.find(params[:id])
    @posts = @genre.posts.page(params[:page]).per(7).order(created_at: :desc)
    @genres = Genre.all
  end
end
