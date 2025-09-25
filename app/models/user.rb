class User < ApplicationRecord
  before_create :generate_key

  extend FriendlyId
  friendly_id :slug, use: :slugged

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  validates :user_name, length: { maximum: 16 }
  validates :full_name, length: { maximum: 30 }
  validates :email, presence: true

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
                                   foreign_key: 'follower_id',
                                   dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :links
  has_many :polls, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comment_likes, dependent: :destroy
  has_many :liked_votes, through: :comment_likes, source: :vote

  has_one_attached :avatar

  def follow(other_user)
    active_relationships.find_or_create_by(followed_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id)&.destroy
  end

  def following?(other_user)
    @followed_ids ||= active_relationships.pluck(:followed_id).to_set
    @followed_ids.include?(other_user.id)
  end

  private

  def generate_key
    self[:slug] = SecureRandom.uuid
  end
end
