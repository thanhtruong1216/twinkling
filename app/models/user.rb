class User < ApplicationRecord
  before_create :generate_key
  # after_create  :send_email

  extend FriendlyId
  friendly_id :slug, use: :slugged

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  validates :user_name, length: { maximum: 16 }
  validates :full_name, length: { maximum: 30 }
  validates :email, presence: true
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name:  'Relationship',
                                   foreign_key: 'follower_id',
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :links

  has_one_attached :avatar

  def follow(other_user)
    following << other_user
  end

  private

  def generate_key
    self[:slug] = SecureRandom.uuid
  end

  def set_confirmed_at
    self.update(confirmed_at: Time.now)
  end

  # def send_email
  #   UserNotifierMailer.send_signup_email(self).deliver_now
  # end
end
