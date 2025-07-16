class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true
  has_many :posts
  has_many :followers, class_name: "Following", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Following", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_users, through: :followers, source: :follower_user
  has_many :followed_users, through: :followed, source: :followed_user
end
