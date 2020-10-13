require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it "nameとemail、passwordとpassword_confirmationが存在すれば登録できること" do
      expect(@user).to be_valid
    end

    it "nameが空では登録できないこと" do
      user = @user
      user.username = ""
      user.valid?
      expect(user.errors.full_messages).to include("Username can't be blank")
    end

    it "emailが空では登録できないこと" do
      user = @user
      user.email = ""
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it "passwordが空では登録できないこと" do
      user = @user
      user.password = ""
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it "passwordが6文字以上であれば登録できること" do
      @user.password = "abcdefgh"
      @user.password_confirmation = @user.password
      expect(@user).to be_valid
    end

    it "passwordが5文字以下であれば登録できないこと" do
      @user.password = "abcde"
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "passwordとpassword_confirmationが不一致では登録できないこと" do
      @user.password_confirmation = "abcde"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "重複したemailが存在する場合登録できないこと" do
      @user.save
      user_b = User.new(username: "test", email: @user.email, password: "123456", password_confirmation: "123456")
      user_b.valid?
      expect(user_b.errors.full_messages).to include("Email has already been taken")
    end
  end
end