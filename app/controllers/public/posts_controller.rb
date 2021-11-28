class Public::PostsController < ApplicationController
  before_action :set_genres, only: %i[new create show index destroy]
  before_action :authenticate_user!,except: [:index, :show]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.score = Language.get_data(post_params[:body])
    if @post.save
    tags = Vision.get_image_data(@post.image)
      tags.each do |tag|
      @post.tags.create(name: tag)
      end
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page]).per(30).order(created_at: :desc)
    @genres = Genre.all
    # いいねの週間ランキング実装
    @ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user.id ==current_user.id
      @post.destroy
      redirect_to my_page_path
    else
      redirect_to post_path(@post)
    end
  end

  def set_genres
    @genres = Genre.all
  end

  private

  def post_params
    params.require(:post).permit(:id, :genre_id, :image, :body, :create_at)
  end
end
