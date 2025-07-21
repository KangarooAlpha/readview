class CommentLiking < ApplicationRecord
  belongs_to :user
  belongs_to :comment

   REACTIONS = {
    neutral: 0,
    like: 1,
    dislike: -1
}.freeze

  validates :user_id, uniqueness: { scope: :comment_id }
  validates :reaction, inclusion: { in: REACTIONS.values }
end
