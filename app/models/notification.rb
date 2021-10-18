class Notification < ApplicationRecord
  # default_scopeは並び順を作成日時を新しい順番に取得できるように記述
  default_scope -> { order(created_at: :desc) }

  # optional: trueはnilを許可するため　ex)フォローの際の通知には投稿やいいねはnil
  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true
  belongs_to :post_send, class_name: 'User', foreign_key: 'send_id', optional: true
  belongs_to :receive, class_name: 'User', foreign_key: 'receive_id', optional: true
end
