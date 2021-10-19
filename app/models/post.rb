class Post < ApplicationRecord
  attachment :image
  belongs_to :user
  belongs_to :genre
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.looks(word)
    word == 'partial_match'
    @post = Post.where('body LIKE?', "%#{word}%")
    #@user = User.where('body LIKE?', "%#{word}%")
  end

  def create_notification_favorite?(current_user)
    # いいねがされているかを探す
    temp = Notification.where(['send_id = ? and receive_id = ? and post_id = ? and action = ? ', current_user.id,
                               user_id, id, 'favorite'])
    # いいねされていないとき通知
    if temp.blank?
      notification = current_user.active_notifications.new(post_id: id, receive_id: user_id, action: 'favorite')
      # 自分の投稿に自分でいいねした際は通知されないようにする
      notification.checked = true if notification.send_id == notification.receive_id
      notification.save if notification.valid?
    end
  end

  def create_notification_post_comment!(current_user, post_comment_id)
    # 自分以外のコメントしている人全員に通知を送る
    temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_post_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
    save_notification_post_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_post_comment!(current_user, post_comment_id, receive_id)
    notification = current_user.active_notifications.new(post_id: id, post_comment_id: post_comment_id,
                                                         receive_id: receive_id, action: 'post_comment')
    # 自分の投稿に自分でコメントした際は通知されないようにする
    notification.checked = true if notification.send_id == notification.receive_id
    notification.save if notification.valid?
  end

  validates :body, presence: true, length: {maximum: 150}
end
