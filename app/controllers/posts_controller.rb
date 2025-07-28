class PostsController < ApplicationController
  before_action :authenticate_user!# , only: [ :new, :create ]

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.all
  end

  def new
    @post = Post.new()
  end

  def create
    @post = current_user.posts.build(post_params)
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

  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.user == current_user
        if @post.save
          format.html { redirect_to posts_path }
        end
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
