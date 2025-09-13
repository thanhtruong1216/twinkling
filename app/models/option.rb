class Option < ApplicationRecord
  belongs_to :poll
  
  has_many :votes, dependent: :destroy
  has_one_attached :image

  validates :text, presence: true
end

