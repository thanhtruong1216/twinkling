class Option < ApplicationRecord
  belongs_to :poll
  has_many :votes, dependent: :destroy

  validates :text, presence: true
end

