class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image #ユーザーの画像投稿
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # 自分がフォローされる側のとき
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  # 自分がフォローする側のとき
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  # 自分がフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 自分がフォローされている人
  has_many :followings, through: :relationships, source: :followed

  #通知を送るアクションを押すとき　ex)フォローする人
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'send_id', dependent: :destroy
  #通知を受け取る側
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'receive_id', dependent: :destroy

  def follow(user_id)
    # relationships.create(followed_id: user_id)
    relationship = relationships.new(followed_id: user_id)
    relationship.save
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def active_for_authentication?
    is_deleted == false
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(['send_id = ? and receive_id = ? and action = ? ', current_user.id, id, 'follow'])

    if temp.blank?
      notification = current_user.active_notifications.new(
        receive_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
  #バリデーション設定
  validates :last_name, presence: true, length: {maximum: 20} #姓　空白投稿出来ない　最大２０文字
  validates :first_name, presence: true, length: {maximum: 20} #名　空白投稿出来ない　最大２０文字
  validates :introduction, length: {maximum: 100} #自己紹介文　最大１００文字
  validates :email, presence: true, uniqueness: true #メールアドレス　空白投稿出来ない　同じアドレスは２つ以上存在させない
end
