class Public::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = PostComment.new(post_comment_params)
    comment.user_id = current_user.id
    comment.post_id = @post.id
    comment.save
    @post.create_notification_post_comment!(current_user, comment.id)
    # 非同期通信のため app/view/public/post_comments/create.js
    # redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = @post.post_comments.find(params[:id])
    comment.destroy
    # 非同期通信のため app/view/public/post_comments/destroy.js
    # redirect_to post_path(@post)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
