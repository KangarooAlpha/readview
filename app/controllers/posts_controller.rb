class PostsController < ApplicationController
  before_action :authenticate_user!

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.all
    @contents = @post.contents.includes(contentable: { images_attachments: :blob })
    @images = @contents
      .select { |content| content.contentable.is_a?(ImageContent) }
      .flat_map { |content| content.contentable.images }
  end

  def new
    @post = Post.new()
    @context = params[:context] || "index"
  end

  def create
    @post = current_user.posts.build(post_params)
    @context = params[:context] || "index"
    content = []

    if params[:body].present?
      text = TextContent.create(body: params[:body])
      content << Content.new(contentable: text, postable: @post)
    end

    if params[:images].present?
      params[:images].each do |i|
        img = ImageContent.new
        img.images.attach(i)
        img.save!
        content << Content.new(contentable: img, postable: @post)
      end
    end

    if params[:video].present?
      vid = VideoContent.new
      vid.video.attach(params[:video])
      vid.save!
      content << Content.new(contentable: vid, postable: @post)
    end

    @post.contents = content

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
    content = []

    if params[:body].present?
      text = TextContent.create(body: params[:body])
      content << Content.new(contentable: text, postable: @post)
    end

    if params[:images].present?
      params[:images].each do |i|
        img = ImageContent.new
        img.images.attach(i)
        img.save!
        content << Content.new(contentable: img, postable: @post)
      end
    end

    if params[:video].present?
      vid = VideoContent.new
      vid.video.attach(params[:video])
      vid.save!
      content << Content.new(contentable: vid, postable: @post)
    end

    if content.present?
      @post.contents.destroy_all
      @post.contents += content
    end


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
    params.require(:post).permit(:title)
  end
end
