class PostsController < ApplicationController
  before_action :authenticate_user!# , only: [ :new, :create ]

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.all
  end

  def new
    @post = Post.new()
    @context = params[:context] || "index"
  end

  def create
    @post = current_user.posts.build(post_params)
    @context = params[:context] || "index"
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post }
        format.turbo_stream { render :create, locals: { post: @post } }
      else
        format.html { render :new, status: :unprocessable_entity }
        # format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end
  def edit
    @post = current_user.posts.find(params[:id])
    @context = params[:context] || "index"
  end

  def update
    @post = current_user.posts.find(params[:id])
    @context = params[:context]
    respond_to do |format|
      if @post.user == current_user
        if @post.update(post_params)
          format.html { redirect_to @post, locals: { post: @post } }
          format.turbo_stream
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      else
        redirect_to users_path, notice: "You can't edit another user's post."
      end
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    respond_to do |format|
      if @post.user == current_user
        if @post.destroy
          format.html { redirect_to users_path }
          format.turbo_stream
        else
          format.html { redirect_to users_path, notice: "Couldn't delete the post" }
          format.turbo_stream { redirect_to @post_path }
        end
      else
        redirect_to users_path, notice: "You can't delete another user's post."
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
