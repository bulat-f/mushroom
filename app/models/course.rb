class Course < ActiveRecord::Base

  belongs_to :tutor, class_name: "User"
  has_many :reverse_enrollments, foreign_key: "learning_course_id", class_name: "Enrollment", dependent: :destroy
  has_many :users, through: :reverse_enrollments

  validates :title, presence: true
  validates :subject, presence: true
  validates :hours, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true
  validates :hours, numericality: { greater_than: 0 }
end
