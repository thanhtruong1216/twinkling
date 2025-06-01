class FamousPerson < ApplicationRecord
  before_create :generate_key

  has_one_attached :photo

  validates :photo, content_type: ['image/png', 'image/jpeg']
  validates :photo, size: { less_than: 3.megabytes, message: 'is not given between size' }

  private

  def generate_key
    self[:key] = SecureRandom.uuid
  end
end
