class Course < ApplicationRecord
  belongs_to :user
  has_many :enrollments
  has_many :users, through: :enrollments, dependent: :destroy
end
