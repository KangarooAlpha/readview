class FollowingsController < ApplicationController
  before_action :authenticate_user!

  def create
    followed_user = User.find(params[:followed_id])
    following = Following.new(followed_user: followed_user, follower_user: current_user)

    if following.save
      flash[:alert] = "#{followed_user.username} followed successfully!"
      redirect_to followed_user
    else
      flash[:alert] = "Could not follow user"
      redirect_to followed_user
    end
  end

  def destroy
    follow = Following.find(params[:id])

    if follow.follower_user == current_user
      flash[:alert] = "You unfollowed #{follow.followed_user.username}"
      follow.destroy
    else
      flash[:alert] = "Could not unfollow user"
    end
    redirect_to follow.followed_user
  end
end
