class Public::PostsController < ApplicationController
  before_action :set_genres, only:[:new, :create, :show, :index, :destroy]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # byebug
    if @post.save
      redirect_to post_path(@post)
    else
      byebug
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to my_page_path
  end

  def set_genres
    @genres = Genre.all
  end

  private

  def post_params
    params.require(:post).permit(:id, :genre_id, :image, :body, :create_at)
  end
end
