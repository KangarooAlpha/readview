class PostLikingsController < ApplicationController
  before_action :authenticate_user!

  def react
    post = Post.find(params[:post_id])
    type = params[:reaction]
    puts type
    post_liking = PostLiking.find_or_initialize_by(user: current_user, post: post)

    if post_liking.reaction == REACTIONS[type]
      post_liking.reaction = REACTIONS["neutral"]
    else
      post_liking.reaction = REACTIONS[type]
    end

    post_liking.save
    redirect_to post
  end

  private
  REACTIONS = {
    "neutral" => 0,
    "like" => 1,
    "dislike" => -1
  }.freeze
end
