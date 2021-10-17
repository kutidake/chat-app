require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
end

describe 'ユーザー新規登録' do
  context '新規登録できる場合' do
    it "nameとemail、passwordとpassword_contirmationが存在すれば登録できる" do
      expect(@user).to be_valid
    
    end
    it 'passwordが６文字以上であれば登録できる' do
      @user.password = '000000'
      @user.password_confirmation = '000000'
      expect(@user).to be_valid
    end
  end
  context '新規登録できない場合' do
    it "nameが空では登録できない" do
      user = User.new(name: '', email: 'test@example', password: '000000',password_confirmation:'000000')
      user.valid?
      expect(user.errors.full_messages).to include("Name can't be blank")
    end
    it "emailが空では登録できない" do
      user = User.new(name: 'test', email:'', password:'000000', password_confirmation:'000000')
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it "passwordが空では登録できない" do
      user = User.new(name:'test',email:'internet',password:'',password_confirmation:'')
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordが5文字以下であれば登録できない' do
      @user.password = '00000'
      @user.password_confirmation = '00000'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'passwordとpassword_confirmationが不一致であれば登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it '重複したemailが存在する場合登録できない' do
      @user.save
      another_user = FactoryBot.build(:user,email: @user.email)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
  end
end
end