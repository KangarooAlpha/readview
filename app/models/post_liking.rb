class PostLiking < ApplicationRecord
  belongs_to :user
  belongs_to :post

  REACTIONS = {
    neutral: 0,
    like: 1,
    dislike: -1
}.freeze

  validates :user_id, uniqueness: { scope: :post_id }
  validates :reaction, inclusion: { in: REACTIONS.values }
end
