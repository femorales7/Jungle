require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    before(:each) do
      @user = User.new(
        first_name: 'new',
        last_name: 'user',
        email: 'my_email@email.com',
        password: 'pasword8caracters',
        password_confirmation: 'pasword8caracters'
      )
    end
    it 'should be created with password and password_confirmation fields' do
      expect(@user.password).to eq(@user.password_confirmation)
    end

    it 'Should be same password and confirmation_password' do
      @user.password = 'pasworddifferent'
      expect(@user.password === @user.password_confirmation).to be false
    end
    it 'should require password and password_confirmation fields' do
      @user.password = nil
      @user.password_confirmation = nil
      expect(@user.valid?).to be false
      
    end

    it 'should require unique email (case-insensitive)' do
      User.create(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Jane',
        last_name: 'Doe'
      )
      duplicate_user = User.new(
        email: 'test@test.com',
        password: 'anotherpassword',
        password_confirmation: 'anotherpassword',
        first_name: 'John',
        last_name: 'Smith'
      )
      expect(duplicate_user.valid?).to be false
    end

    it 'should require email, first name, and last name' do
      @user.email = nil
      @user.first_name = nil
      @user.last_name = nil
      expect(@user.valid?).to be false
      
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )
    end

    it 'should return an instance of the user if successfully authenticated' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'should return nil if authentication fails' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrongpassword')
      expect(authenticated_user).to be_nil
    end

    it 'should successfully authenticate with spaces around the email address' do
      authenticated_user = User.authenticate_with_credentials(' test@example.com ', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'should successfully authenticate with different cases in the email address' do
      authenticated_user = User.authenticate_with_credentials('TeSt@ExAmPlE.cOm', 'password')
      expect(authenticated_user).to eq(@user)
    end

  end
end
