require 'spec_helper'

describe "StaticPages" do

  subject { page }
  describe "index" do
    before { visit root_path }

    it { should have_title(full_title('')) }
    it { should have_selector('h1', text: 'Wellcome to the Mushroom') }
    it { should have_link('Sign up now!', href: signup_path) }
  end

  describe "help" do
    before { visit help_path }

    it { should have_title(full_title('Help')) }
    it { should have_selector('h1', text: 'Help') }
  end

  describe "contact" do
    before { visit contact_path }

    it { should have_title(full_title('Contact')) }
    it { should have_selector('h1', text: 'Contact') }
  end

  describe "about" do
    before { visit about_path }

    it { should have_title(full_title('About Us')) }
    it { should have_selector('h1', text: 'About Us') }
  end
end
