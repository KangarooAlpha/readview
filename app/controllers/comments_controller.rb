class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    Rails.logger.debug "📥 params: #{params.inspect}"
    Rails.logger.debug "params[:post_id] in new = #{params[:post_id].inspect}"
    @post = Post.find_by(id: params[:post_id])
    Rails.logger.debug "@post in new = #{@post.inspect}"
    @comment = Comment.new(parent_id: params[:parent_id])
    @parent_id = params[:parent_id]
    Rails.logger.debug "@parent_id = #{@parent_id.inspect}"
  end

  def create
    @post = Post.find(params[:post_id])
    @body = params[:comment][:body]
    @parent_id = params[:comment][:parent_id]

    @comment = @post.comments.build(user: current_user, body: @body, parent_id: @parent_id)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post }
        format.turbo_stream
      else
        format.html { redirect_to @post, status: :unprocessable_entity }
      end
    end
  end
end
