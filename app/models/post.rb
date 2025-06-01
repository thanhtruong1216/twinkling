class Post < ApplicationRecord
  before_create :generate_key

  extend FriendlyId
  friendly_id :slug, use: :slugged

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_one_attached :photo

  validates :user_id, presence: true
  validates :content, presence: true
  validates :photo, content_type: ['image/png', 'image/jpeg']
  validates :photo, size: { less_than: 3.megabytes, message: 'is not given between size' }

  private

  def generate_key
    self[:slug] = SecureRandom.uuid
  end
end
