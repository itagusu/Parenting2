class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  # 自分がフォローされる側のとき
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分がフォローする側のとき
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 自分がフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 自分がフォローされている人
  has_many :followings, through: :relationships, source: :followed

  def follow(user_id)
    #relationships.create(followed_id: user_id)
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
end
