require 'spec_helper'

describe Course do
  before { @course = Course.new(title: 'Hello World', subject: 'programing', hours: 6, description: 'Learn the programing', price: 100, tutor_id: 1) }

  subject { @course }

  it { should respond_to(:title) }
  it { should respond_to(:subject) }
  it { should respond_to(:hours) }
  it { should respond_to(:description) }
  it { should respond_to(:price) }
  it { should respond_to(:tutor_id) }
  it { should respond_to(:reverse_enrollments) }
  it { should respond_to(:users) }

  describe "recorded users" do
    let(:user) { FactoryGirl.create(:user) }
    let(:tutor) { FactoryGirl.create(:tutor) }
    let(:course) { FactoryGirl.create(:course, tutor_id: tutor.id) }
    before do
      user.save
      user.learn_course!(course)
    end

    subject { course }

    its(:users) { should include(user) }
  end
end
