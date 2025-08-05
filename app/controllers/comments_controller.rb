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

  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def update
    @comment = current_user.comments.find(params[:id])
    respond_to do |format|
      if @comment.user == current_user
        if @comment.update
          format.html { redirect_to @comment.post, locals: { post: @comment.post } }
          format.turbo_stream
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      else
        redirect_to users_path, notice: "You can't edit another user's comment."
      end
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    respond_to do |format|
      if @comment.user == current_user
        if @comment.destroy
          format.html { redirect_to post_path(@comment.post) }
          format.turbo_stream
        else
          format.html { redirect_to users_path, notice: "Couldn't delete the comment" }
          format.turbo_stream { redirect_to @comment.post }
        end
      else
        redirect_to users_path, notice: "You can't delete another user's comment."
      end
    end
  end
end
