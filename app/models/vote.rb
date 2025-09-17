class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :option

  validates :user_id, uniqueness: { scope: :option_id, message: "đã vote rồi" }
  validates :comment, length: { maximum: 500 }
end
