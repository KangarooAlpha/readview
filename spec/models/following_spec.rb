require 'rails_helper'

RSpec.describe Following, type: :model do
  let(:user1) { User.create!(email: "user1@example.com", password: "password123", username: "user1") }
  let(:user2) { User.create!(email: "user2@example.com", password: "password123", username: "user2") }

  it "is valid with follower_user and followed_user" do
    following = Following.new(follower_user: user1, followed_user: user2)
    expect(following).to be_valid
  end

  it "validates uniqueness of follower_id scoped to followed_id" do
    Following.create!(follower_user: user1, followed_user: user2)
    duplicate = Following.new(follower_user: user1, followed_user: user2)
    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:follower_id]).to include("has already followed user")
  end

  it "allows different users to follow the same user" do
    Following.create!(follower_user: user1, followed_user: user2)
    following2 = Following.new(follower_user: User.create!(email: "user3@example.com", password: "password123", username: "user3"), followed_user: user2)
    expect(following2).to be_valid
  end

  it "allows a user to follow multiple different users" do
    Following.create!(follower_user: user1, followed_user: user2)
    following2 = Following.new(follower_user: user1, followed_user: User.create!(email: "user4@example.com", password: "password123", username: "user4"))
    expect(following2).to be_valid
  end
end
