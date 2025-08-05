class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(user: current_user))
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
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    respond_to do |format|
      if @comment.user == current_user
        if @comment.update(comment_params)
          format.html { redirect_to @post }
          format.turbo_stream
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      else
        redirect_to post_path(@post), notice: "You can't edit another user's comment."
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
          format.html { redirect_to post_path(@comment.post), notice: "Couldn't delete the comment" }
          format.turbo_stream { redirect_to @comment.post }
        end
      else
        redirect_to post_path(@comment.post), notice: "You can't delete another user's comment."
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
