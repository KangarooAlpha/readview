class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :google_oauth2, :github ]
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = generate_unique_username(auth.info.name)
      user.avatar_url = auth.info.image if auth.info.image.present?
      user.provider = auth.provider
      user.uid = auth.uid
    end
  end

  def self.generate_unique_username(name)
  base_username = name.parameterize(separator: "_")
  username = base_username
  counter = 1

  while User.exists?(username: username)
    username = "#{base_username}_#{counter}"
    counter += 1
  end

  username
  end

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
