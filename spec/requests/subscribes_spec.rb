require 'spec_helper'

describe "Subscribe pages" do

  let(:user) { FactoryGirl.create(:user) }
  let(:tutor) { FactoryGirl.create(:tutor) }
  let(:course) { FactoryGirl.create(:course, tutor_id: tutor.id) }

  subject { page }
  
  describe "non-signed user" do
    before { visit course_path(course) }
    it { should_not have_button("Subscribe") }
  end

  describe "signed in user" do
    before do
      sign_in user
      visit course_path(course)
    end

    it { should have_button("Subscribe") }
    
    describe "when click button" do
      it "change user's learning_courses count" do
        expect { click_button "Subscribe" }.to change(user.learning_courses, :count)
      end
    
      it "chaenge enrollment's count" do
        expect { click_button "Subscribe" }.to change(Enrollment, :count)
      end
    end

  end

  describe "unsubscribe" do
    before do
      sign_in user
      user.learn_course!(course)
      visit course_path(course)
    end

    it { should have_button("Unsubscribe") }
    
    describe "when click button" do
      it "change user's learning courses count" do
        expect { click_button "Unsubscribe" }.to change(user.learning_courses, :count).by(-1)
      end

      it "haenge enrollment's count" do
        expect { click_button "Unsubscribe" }.to change(Enrollment, :count).by(-1)
      end
    end
  end
end
