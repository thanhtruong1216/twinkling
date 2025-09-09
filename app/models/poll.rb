class Poll < ApplicationRecord
  belongs_to :user
  has_many :options, dependent: :destroy
  has_many :votes, through: :options
  accepts_nested_attributes_for :options

  validates :title, presence: true, length: { maximum: 255 }
end

