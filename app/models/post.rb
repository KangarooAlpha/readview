class Post < ApplicationRecord
  validates :title, presence: true

  belongs_to :user

  has_many :contents, as: :postable, dependent: :destroy
  accepts_nested_attributes_for :contents, allow_destroy: true

  has_many :comments, dependent: :destroy

  has_many :post_likings, dependent: :destroy

  def likes
    post_likings.where(reaction: 1).count
  end

  def dislikes
    post_likings.where(reaction: -1).count
  end
end
