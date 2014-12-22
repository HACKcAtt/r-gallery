class Comment < ActiveRecord::Base
  validates :user_id, presence: true
  validates :picture_id, presence: true
  belongs_to :picture

  default_scope -> {order('created_at ASC')}

  validates :content, presence: true, length: {maximum: 200}
end

