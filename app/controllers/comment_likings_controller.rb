class CommentLikingsController < ApplicationController
  before_action :authenticate_user!

  def react
    comment = Comment.find(params[:comment_id])
    type = params[:reaction]
    puts type
    comment_liking = CommentLiking.find_or_initialize_by(user: current_user, comment: comment)

    if comment_liking.reaction == REACTIONS[type]
      comment_liking.reaction = REACTIONS["neutral"]
    else
      comment_liking.reaction = REACTIONS[type]
    end

    if comment_liking.save
      puts "yay"
    else
      puts "nay"
    end
    redirect_to comment.post
  end

  private
  REACTIONS = {
    "neutral" => 0,
    "like" => 1,
    "dislike" => -1
  }.freeze
end
