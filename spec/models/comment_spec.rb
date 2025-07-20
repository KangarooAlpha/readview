# spec/models/comment_spec.rb
require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) do
    User.create!(
      email: "user@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  let(:post) do
    Post.create!(
      title: "Test Post",
      body: "Some content here.",
      user: user
    )
  end

  let(:valid_attributes) do
    {
      body: "Nice post!",
      user: user,
      post: post
    }
  end


  describe 'validations' do
    it 'is valid with valid attributes' do
      comment = Comment.new(valid_attributes)
      expect(comment).to be_valid
    end

    it 'is invalid without a body' do
      comment = Comment.new(valid_attributes.merge(body: nil))
      expect(comment).not_to be_valid
      expect(comment.errors[:body]).to include("can't be blank")
    end

    it 'is invalid without a user' do
      comment = Comment.new(valid_attributes.merge(user: nil))
      expect(comment).not_to be_valid
      expect(comment.errors[:user]).to include("must exist")
    end

    it 'is invalid without a post' do
      comment = Comment.new(valid_attributes.merge(post: nil))
      expect(comment).not_to be_valid
      expect(comment.errors[:post]).to include("must exist")
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      comment = Comment.create!(valid_attributes)
      expect(comment.user).to eq(user)
    end

    it 'belongs to a post' do
      comment = Comment.create!(valid_attributes)
      expect(comment.post).to eq(post)
    end
  end
end
