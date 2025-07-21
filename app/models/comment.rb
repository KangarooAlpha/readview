class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  has_many :comment_likings, dependent: :destroy

  validates :body, presence: true

  def likes
    comment_likings.where(reaction: CommentLiking::REACTIONS[:like]).count
  end

  def dislikes
    comment_likings.where(reaction: CommentLiking::REACTIONS[:dislike]).count
  end
end
