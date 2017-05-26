class Classroom < ApplicationRecord
  belongs_to :school
  has_many :user_classrooms
  has_many :users, through: :user_classrooms
end
