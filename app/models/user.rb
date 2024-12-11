class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # cursos en los que el usuario es instructor
  has_many :courses

  has_many :enrollments, dependent: :destroy
  
  has_many :enrolled_courses, through: :enrollments, source: :course
end
