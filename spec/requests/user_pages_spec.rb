require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "index" do
    before do
      35.times { FactoryGirl.create(:user) }
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_selector('h1', text: 'All users') }

    describe "pagination" do
      it { should have_selector('div.pagination') }
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end
  end

  describe "signup page" do
    before { visit signup_path }

    let(:submit) { "Create my account" }

    it { should have_selector('h1', text: 'Signup') }
    it { should have_title(full_title('Signup')) }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      it "should have error message" do
        click_button submit
        should have_content('error')
      end
    end

    describe "with valid information" do
      before { valid_sign_up }

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

# Только после реализации входа пользователя
#      describe "after saving the user" do
#        before { click_button submit }
#        it { should have_link('Sign out') }
#      end
    end 
  end
end
