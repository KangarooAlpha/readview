require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "not save post without a tittle" do
    post = Post.new
    assert_not post.save
  end
end
