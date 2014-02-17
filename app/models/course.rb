class Course < ActiveRecord::Base

  belongs_to :user

  validates :title, presence: true
  validates :subject, presence: true
  validates :hours, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true
  validates :hours, numericality: { greater_than: 0 }
end
