require 'spec_helper'

describe "Transfers" do
  let(:user) { FactoryGirl.create(:user, wallet: 10000) }
  subject { page }
  describe "non-signed user" do
    describe "redirect to sign in page" do
      before { get finance_user_path(user) }
      specify { expect(response).to redirect_to(signin_path) }

      describe "submitting to the create action" do
        before { post transfers_path }
        specify { expect(response).to redirect_to(signin_path) }
      end

      describe "submitting to the create action" do
        before { delete transfer_path(user) }
        specify { expect(response).to redirect_to(signin_path) }
      end
    end
  end

  describe "signed in user" do
    let(:other_user) { FactoryGirl.create(:user) }
    describe "don't correct user" do
      before do
        sign_in(user, no_capybara: true)
        get finance_user_path(other_user)
      end
      specify { expect(response).to redirect_to(root_path) }
    end

    describe "correct user" do
      before do
        sign_in(user)
        visit finance_user_path(user)
      end
      it { should have_selector(:xpath, '//span[@class]', text: user.wallet.to_s) }
    end
    
    describe "transfer other user moneys" do
      before do
        sign_in(user, no_capybara: true)
      end
      let(:transfer_other_params) { {:transfer => { sender_id: other_user.id, recipient_id: user.id, amount: 1000, message: "Hello World" } } }
      
      it "should have error message" do
        expect { post transfers_path, transfer_other_params }.to_not change(Transfer, :count)
      end
    end


    describe "transfer self moneys" do
      before do
        sign_in(user, no_capybara: true)
      end
      let(:transfer_params) { {:transfer => { sender_id: user.id, recipient_id: other_user.id, amount: 1000, message: "Hello World" } } }
      
      it "should have change transfers count" do
        expect { post transfers_path, transfer_params }.to change(Transfer, :count).by(1)
      end

      describe "redirect to finance page" do
        before { post transfers_path, transfer_params }
        specify { expect(response).to redirect_to(finance_user_path(user)) }
        
        it { should have_selector('div.alert.alert-warning') }
      end
    end
  end
end
