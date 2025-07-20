require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes) do
    {
      email: "testuser@example.com",
      password: "secure123",
      password_confirmation: "secure123"
    }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(valid_attributes)
      expect(user).to be_valid
    end

    it 'is invalid without an email' do
      user = User.new(valid_attributes.merge(email: nil))
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is invalid with a duplicate email' do
      User.create!(valid_attributes)
      user = User.new(valid_attributes)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it 'is invalid with a short password' do
      user = User.new(valid_attributes.merge(password: '123', password_confirmation: '123'))
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it 'is invalid when password and confirmation do not match' do
      user = User.new(valid_attributes.merge(password_confirmation: 'wrongpass'))
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

  describe '#valid_password?' do
    it 'returns true with correct password' do
      user = User.create!(valid_attributes)
      expect(user.valid_password?('secure123')).to be true
    end

    it 'returns false with incorrect password' do
      user = User.create!(valid_attributes)
      expect(user.valid_password?('wrongpassword')).to be false
    end
  end
end
