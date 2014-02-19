class Enrollment < ActiveRecord::Base

  belongs_to :user
  belongs_to :learning_course, class_name: "Course"

  validates :user_id, presence: true
  validates :learning_course_id, presence: true
end
