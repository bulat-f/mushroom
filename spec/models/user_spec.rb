require 'spec_helper'

describe User do

  before { @user = User.new(surname: "Exaple", name: "User", email: "user@example.com", phone: "+79655925240", password: "foobar", password_confirmation: "foobar") }
  subject { @user }

  it { should respond_to(:surname) }
  it { should respond_to(:name) }
  it { should respond_to(:patronymic) }
  it { should respond_to(:sex) }
  it { should respond_to(:email) }
  it { should respond_to(:phone) }
  it { should respond_to(:wallet) }
  it { should respond_to(:tutor) }
  it { should respond_to(:admin) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when surname is not present" do
    before { @user.surname = " " }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "when phone number format is invalid" do
    it "should be invalid" do
      phones = %w[89655925240 +7-96-55-925240 79655925240 7-96-55-92-52-40]
      phones.each do |invalid_phone|
        @user.phone = invalid_phone
        @user.should_not be_valid
      end
    end
  end

  describe "when phone number format is valid" do
    before { @user.phone = "+79655925240" }
    it { should be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
end
