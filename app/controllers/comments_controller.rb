class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @body = params[:comment][:body]
    @comment = @post.comments.build(user: current_user, body: @body)

    if @comment.save
      redirect_to @post
    else
      puts @comment.errors.full_messages
      redirect_to @post, status: :unprocessable_entity
    end
  end
end
