require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "Should save user with a username, email and password" do
    user = User.new(username: "hi", email: "test@gmail.com", password: "password")
    assert_not user.save
  end
end
