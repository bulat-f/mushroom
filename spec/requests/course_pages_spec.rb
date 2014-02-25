require 'spec_helper'

describe "CoursePages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:tutor) { FactoryGirl.create(:tutor) }
  let(:course) { FactoryGirl.create(:course, tutor_id: tutor.id) }

  describe "show" do
    before { visit course_path(course.id) }

    it { should have_title(course.title) }
  end

  describe "new course page" do

    describe "signed in user" do

      describe "as tutor" do

        before do
          sign_in tutor
          visit new_course_path
        end

        let(:create) { "Create course" }

        describe "with invalid information" do

          it "should not create a new course" do
            expect { click_button create }.not_to change(Course, :count)
          end
        end

        describe "with valid information" do
          before { valid_course }

          it "should create a new course" do
            expect { click_button create }.to change(Course, :count)
          end
        end
      end

      describe "as not tutor" do
        before do
          sign_in(user)
          visit new_course_path
        end

        it { should_not have_button("Create course") }
        it { should have_selector('div.alert.alert-info') }
      end
    end

    describe "with non signed user" do
      before { visit new_course_path }
      
      it { should have_title('Sign in') }
    end
  end 
end
