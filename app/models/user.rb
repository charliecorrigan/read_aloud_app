class User < ApplicationRecord
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :role, presence: true
  validates :language, presence: true

  enum role: [:volunteer, :staff, :admin]
  enum language: [:english, :spanish]

  has_many :user_classrooms
  has_many :classrooms, through: :user_classrooms
  has_many :events, through: :user_classrooms

  def events
    Event.where(user_classroom_id: self.user_classrooms)
  end
end
