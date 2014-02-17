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
end
