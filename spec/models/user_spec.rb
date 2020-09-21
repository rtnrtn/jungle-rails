require 'rails_helper'

RSpec.describe User, type: :model do
  
  let (:user_name) { "tania" }
  let (:user_email) { "test@test.com" }
  let (:user_password) { "thisismypassword" }
  let (:user_password_confirmation) { "thisismypassword" }
  let (:user) do
    User.new(
      name: user_name,
      email: user_email,
      password: user_password,
      password_confirmation: user_password_confirmation
    )
  end

  describe 'Validations' do
  
    context "given a user with all fields present" do
      it "saves successfully" do
        expect(user.save!).to eq(true)
        expect(User.count).to eq(1)
      end
    end

    context "given an empty name field" do
      let (:user_name) { "" }

      it "does not save" do
        expect(user.save).to eq(false)
        expect(user.errors.full_messages).to include("Name can't be blank")
        expect(User.count).to eq(0)
      end
    end
    
    context "given an empty email field" do
      let (:user_email) { "" }

      it "does not save" do
        expect(user.save).to eq(false)
        expect(user.errors.full_messages).to include("Email can't be blank")
        expect(User.count).to eq(0)
      end
    end
    
    context "given an empty password field" do
      let (:user_password) { "" }

      it "does not save" do
        expect(user.save).to eq(false)
        expect(user.errors.full_messages).to include("Password can't be blank")
        expect(User.count).to eq(0)
      end
    end

    context "given an empty password confirmation field" do
      let (:user_password_confirmation) { "" }

      it "does not save" do
        expect(user.save).to eq(false)
        expect(user.errors.full_messages).to include("Password confirmation can't be blank")
        expect(User.count).to eq(0)
      end
    end

    context "given different inputs for the password and password confirmation fields" do
      let (:user_password_confirmation) { "oopswrongpassword" }

      it "does not save" do
        expect(user.save).to eq(false)
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
        expect(User.count).to eq(0)
      end
    end

    context "given an already registered email, whether same case or not," do
      let (:user2) do
        User.new(
          name: "bob",
          email: "TEST@TEST.com",
          password: "anotherpassword",
          password_confirmation: "anotherpassword"
        )
      end
    
      it "does not save" do
        expect(user.save!).to eq(true)
        expect(user2.save).to eq(false)
        expect(user2.errors.full_messages).to include("Email has already been taken")
        expect(User.count).to eq(1)
      end
    end
  
    context "given a password that is too short" do
      let (:user_password) { "abc" }

      it "does not save" do
        expect(user.save).to eq(false)
        expect(user.errors.full_messages).to include("Password is too short (minimum is 10 characters)")
        expect(User.count).to eq(0)
      end
    end

  end

  describe '.authenticate_with_credentials' do
    
    before { user.save }

    context "given the correct email and password input" do
      it "should log the user in" do
        expect(User.authenticate_with_credentials(user.email, user.password)).to eq(user)
      end
    end

    context "given an incorrect email" do
      it "should not log the user in" do
        expect(User.authenticate_with_credentials("wrong@test.com", user.password)).to eq(nil)
      end
    end

    context "given an incorrect password" do
      it "should not log the user in" do
        expect(User.authenticate_with_credentials(user.email, "wrongpassword")).to eq(nil)
      end
    end

    context "given extra spaces around email address" do
      it "should still log the user in" do
        expect(User.authenticate_with_credentials("  #{user.email} ", user.password)).to eq(user)
      end
    end

    context "given the correct email with the wrong case" do
      it "should still log the user in" do
        expect(User.authenticate_with_credentials(user.email.upcase, user.password)).to eq(user)
      end
    end

  end
end
