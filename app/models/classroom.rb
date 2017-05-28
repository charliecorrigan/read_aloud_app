class Classroom < ApplicationRecord
  validates :teacher_name, presence: true
  validates :grade_level, presence: true
  validates :number_of_students_enrolled, presence: true

  belongs_to :school
  has_many :user_classrooms
  has_many :users, through: :user_classrooms
end
