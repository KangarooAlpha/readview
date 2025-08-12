module PostsHelper
  def post_preview_image(post)
    image = post.contents
      .select { |c| c.contentable.is_a?(ImageContent) }
      .flat_map { |c| c.contentable.images }
      .first

    image if image.present?
  end
end
