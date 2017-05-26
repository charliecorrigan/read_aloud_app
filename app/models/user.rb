class User < ApplicationRecord
  has_secure_password

  has_many :user_classrooms
  has_many :classrooms, through: :user_classrooms
end
