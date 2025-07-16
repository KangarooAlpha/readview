class UsersController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  def index
    @posts = Post.all
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
