require 'rails_helper'

RSpec.describe User, type: :model do

  before (:each) do
    @user = User.create(first_name: "first name",
                        last_name: "last_name",
                        email: "email@email.email",
                        password: "password",
                        password_confirmation: "password")
  end

  describe "Validations" do

    it "should match password_digest and password_confirmation" do
      @user.password = "testpwd"
      @user.password_confirmation = "test"
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      p @user.errors.full_messages
    end

    it "should have a password" do
      @user.password_digest = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Password can't be blank"
      p @user.errors.full_messages
    end

    it "should have a unique email" do
      @newUser = User.create(first_name: "first",
                  last_name: "last",
                  email: "EMail@email.email",
                  password_digest: "password",
                  password_confirmation: "password")
      expect(@newUser).to_not be_valid
      expect(@newUser.errors.full_messages).to include "Email has already been taken"
      p @newUser.errors.full_messages
    end

    it "should have an email" do
      @user.email = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Email can't be blank"
      p @user.errors.full_messages
    end

    it "should have a first name" do
      @user.first_name = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "First name can't be blank"
      p @user.errors.full_messages
    end

    it "should have a last name" do
      @user.last_name = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Last name can't be blank"
      p @user.errors.full_messages
    end

    it "should have a minimum password length of 3" do
      @user.password_digest = "hi"
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Password digest is too short (minimum is 3 characters)"
      p @user.errors.full_messages
    end
  end

  describe '.authenticate_with_credentials' do

    it "should verify a user's credentials and return a new user" do
      @user1 = @user.authenticate_with_credentials("", "")
      expect(@user1).to_not be_valid
      expect(@user1.errors.full_messages).to include "Password digest is too short (minimum is 3 characters)", "Password can't be blank"
      p @user1.errors.full_messages
    end

    it "should authenticate a user with a few spaces before/after their email address" do
      @user1 = @user.authenticate_with_credentials("    email@email.email", "password")
      expect(@user1).to_not be_valid
      p @user1.errors.full_messages
    end

    it "should authenticate users with wron case for their email" do
      @user1 = @user.authenticate_with_credentials("EmaiL@email.email", "password")
      expect(@user1).to_not be_valid
      p @user1.errors.full_messages
    end

  end
end
