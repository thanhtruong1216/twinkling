class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :option
  has_many :comment_likes, dependent: :destroy
  has_many :liking_users, through: :comment_likes, source: :user

  validates :user_id, uniqueness: { scope: :option_id, message: "đã vote rồi" }
  validates :comment, length: { maximum: 500 }
end
