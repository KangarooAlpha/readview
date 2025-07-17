class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true

  has_many :post_likings

  def likes
    post_likings.where(reaction: 1).count
  end

  def dislikes
    post_likings.where(reaction: -1).count
  end
end
