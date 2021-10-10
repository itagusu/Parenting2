class Post < ApplicationRecord
  attachment :image
  belongs_to :user
  belongs_to :genre
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.looks(word)
    word == "partial_match"
    @post = Post.where("body LIKE?","%#{word}%")
  end
end
