class Poll < ApplicationRecord
  belongs_to :user

  has_many :options, dependent: :destroy
  has_many :votes, through: :options
  has_one_attached :image

  accepts_nested_attributes_for :options

  validates :title, presence: true, length: { maximum: 255 }

  scope :visible, -> { where(visible: true) }
  scope :active_polls, -> { where(visible: true, status: :approved) }

  enum status: {
    pending: "pending",
    approved: "approved",
    rejected: "rejected"
  }
end

