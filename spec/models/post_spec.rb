# spec/models/post_spec.rb
require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) do
    User.create!(
      email: "user@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  let(:valid_attributes) do
    {
      title: "My First Post",
      body: "This is the content of the post.",
      user: user
    }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      post = Post.new(valid_attributes)
      expect(post).to be_valid
    end

    it 'is invalid without a title' do
      post = Post.new(valid_attributes.merge(title: nil))
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a body' do
      post = Post.new(valid_attributes.merge(body: nil))
      expect(post).not_to be_valid
      expect(post.errors[:body]).to include("can't be blank")
    end

    it 'is invalid without a user' do
      post = Post.new(valid_attributes.merge(user: nil))
      expect(post).not_to be_valid
      expect(post.errors[:user]).to include("must exist")
    end
  end

  describe 'editing' do
    let!(:post) { Post.create!(valid_attributes) }

    it 'successfully updates with valid attributes' do
      expect(post.update(title: "Updated Title", body: "Updated body content")).to be true
      expect(post.title).to eq("Updated Title")
      expect(post.body).to eq("Updated body content")
    end

    it 'fails to update with invalid title' do
      expect(post.update(title: nil)).to be false
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'fails to update with invalid body' do
      expect(post.update(body: nil)).to be false
      expect(post.errors[:body]).to include("can't be blank")
    end

    it 'does not allow user to be nil' do
      post.user = nil
      expect(post).not_to be_valid
      expect(post.errors[:user]).to include("must exist")
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      post = Post.create!(valid_attributes)
      expect(post.user).to eq(user)
    end
  end
end
