class Transfer < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validates :amount, numericality: { greater_than: 0 }
end
