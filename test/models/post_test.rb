require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "not save post without a title" do
    post = Post.new
    assert_not post.valid?
  end

  test "should not save with a title, but no body" do
    post = Post.new(title: "testing post")
    assert_not post.save
  end

  test "should save with a title, body and user" do
    post = Post.new(title: "testing post", body: "blahblah", user: users(:one))
    assert_not post.save
  end
end
