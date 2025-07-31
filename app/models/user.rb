class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true
  has_one_attached :avatar

  has_many :posts
  has_many :post_likings

  has_many :comments
  has_many :comment_likings

  has_many :active_rel, class_name: "Following", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_rel, class_name: "Following", foreign_key: "followed_id", dependent: :destroy

  has_many :follower_users, through: :passive_rel, source: :follower_user
  has_many :followed_users, through: :active_rel, source: :followed_user
end
