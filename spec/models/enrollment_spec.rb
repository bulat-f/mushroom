require 'spec_helper'

describe Enrollment do

  let(:user) { FactoryGirl.create(:user) }
  let(:tutor) { FactoryGirl.create(:tutor) }
  let(:course) { FactoryGirl.create(:course, tutor_id: tutor.id) }
  let(:enrollment) { user.enrollments.build(learning_course_id: course.id) }

  subject { enrollment }

  it { should be_valid }

  describe "user and learning course methods" do
    it { should respond_to(:user) }
    it { should respond_to(:learning_course) }
    its(:user) { should eq user }
    its(:learning_course) { should eq course }
  end
end
