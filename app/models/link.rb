class Link < ApplicationRecord

  # include CustomValidators
  include ::ApplicationHelper

  belongs_to :user

  before_create :set_slug

  validates :url, presence: true
  # validates :url, format: { with: VALID_URL_REGEX }
  validates :slug, uniqueness: true, length: { maximum: 9 }

  def shortener
    "#{backend_base_url}/#{slug}"
  end

  def set_slug
    self.slug = ([*('A'..'Z'), *('a'..'z'), *('0'..'9')] - %w[0 1 I O]).sample(9).join
  end
end
