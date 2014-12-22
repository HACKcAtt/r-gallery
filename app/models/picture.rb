class Picture < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  mount_uploader :link, PictureUploader

  has_many :comments, dependent: :destroy

end


