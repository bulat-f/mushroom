require 'spec_helper'

describe Transfer do

  let(:first_user) { FactoryGirl.create(:user) }
  let(:second_user) { FactoryGirl.create(:user) }
  before { @transfer = Transfer.new(sender_id: first_user.id, recipient_id: second_user.id, amount: 1000, message: "Hello! My name is Bulat") }

  subject { @transfer }

  it { should respond_to(:amount) }
  it { should respond_to(:message) }

  it { should be_valid }

  describe "sender and recipient methods" do
    it { should respond_to(:sender) }
    it { should respond_to(:recipient) }
    its(:sender) { should eq first_user }
    its(:recipient) { should eq second_user }
  end
end
