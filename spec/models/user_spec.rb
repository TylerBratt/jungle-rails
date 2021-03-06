require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid with all fields filled' do
      @user = User.create(firstname:"hans", lastname:"moleman", email:"wassayingboourns@springfield.com", password:"boink", password_confirmation:"boink")
      expect(@user).to be_valid
    end

    it 'is not valid without a password' do
      @user = User.create(firstname:"hans", lastname:"moleman", email:"wassayingboourns@springfield.com", password:nil)
      expect(@user).to_not be_valid
    end

    it 'is not valid without a password_confirmation' do
      @user = User.create(firstname:"hans", lastname:"moleman", email:"wassayingboourns@springfield.com", password:"boink", password_confirmation:"boink")
      expect(@user).to be_valid
    end

    it 'is not valid if password != password_confirmation' do
      @user = User.create(firstname:"hans", lastname:"moleman", email:"wassayingboourns@springfield.com", password:"boink", password_confirmation:"bonk")
      expect(@user).to_not be_valid
    end

    it 'is not valid if email is not unique' do
      @user1 = User.create(firstname:"hans", lastname:"moleman", email:"wassayingboourns@springfield.com", password:"boink", password_confirmation:"boink")
      @user2 = User.create(firstname:"hans", lastname:"moleman", email:"wassayingboourns@springfield.com", password:"boink", password_confirmation:"boink")
      expect(@user2).to_not be_valid
    end

    it 'is not valid without an email' do
      @user = User.create(firstname:"hans", lastname:"moleman", email:nil, password:"boink", password_confirmation:"boink")
      expect(@user).to_not be_valid
    end

    it 'is not valid without a first name' do
      @user = User.create(firstname:nil, lastname:"moleman", email:"wassayingboourns@springfield.com", password:"boink", password_confirmation:"boink")
      expect(@user).to_not be_valid
    end

    it 'is not valid without a last name' do
      @user = User.create(firstname:"hans", lastname:nil, email:"wassayingboourns@springfield.com", password:"boink", password_confirmation:"boink")
      expect(@user).to_not be_valid
    end

    it 'is not valid if password is less than minimum length' do
      @user = User.create(firstname:"hans", lastname:"moleman", email:"wassayingboourns@springfield.com", password:"12", password_confirmation:"12")
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return a user if the user is authentic' do
      @user1 = User.create(firstname:"hans", lastname:"moleman", email:"wassayingboourns@springfield.com", password:"boink", password_confirmation:"boink")
      @user2 = User.authenticate_with_credentials(@user1.email, @user1.password)
      expect(@user2.firstname).to eq("hans")
    end

    it 'should return nil if the user is not authenticated' do
      @user = User.authenticate_with_credentials("wassayingboourns@springfield.com", "bonk")
      expect(@user).to eq(nil)
    end

    it 'is valid if email contains spaces before or after' do
      @user1 = User.create(firstname:"hans", lastname:"moleman", email:"wassayingboourns@springfield.com", password:"boink", password_confirmation:"boink")
      @user2 = User.authenticate_with_credentials(" wassayingboourns@springfield.com ", @user1.password)
      expect(@user2.firstname).to eq("hans")
    end

    it 'is valid if email is without case sensitivity' do
      @user1 = User.create(firstname:"hans", lastname:"moleman", email:"wassayingboourns@springfield.com", password:"boink", password_confirmation:"boink")
      @user2 = User.authenticate_with_credentials("wassayingBOOurns@springfield.com", @user1.password)
      expect(@user2.firstname).to eq("hans")
    end
  end
end