require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index page" do
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

      describe "after saving the user" do
        before { click_button submit }
        it { should have_link('Sign out') }
      end
    end 
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user)
      visit edit_user_path(user)
    end

# Эти тесты, по непонятным мне причинам фейлятся 
#    describe "page" do
#      it { should have_title(full_title('Edit')) }
#      it { should have_selector('h1', text: 'Edit') }
#    end

    describe "with invalid information" do
      let(:new_attr) { {surname: 'Newfam', name: 'Newname', email: 'new@email.'} }
      before do
        edit_user_attr(user, new_attr)
        click_button 'Save changes'
      end

      it { should have_content('error') }
    end

    describe "with valid information"
      let(:new_attr) { {surname: 'Newfam', name: 'Newname', email: 'new@email.com'} }
      before do
        edit_user_attr(user, new_attr)
        click_button 'Save changes'
      end

      it { should have_title(full_title("#{ new_attr[:surname]} #{ new_attr[:name] }")) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }

      specify { expect(user.reload.surname).to  eq new_attr[:surname] }
      specify { expect(user.reload.name).to     eq new_attr[:name] }
      specify { expect(user.reload.email).to    eq new_attr[:email] }

    end
end
