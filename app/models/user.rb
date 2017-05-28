class User < ApplicationRecord
  has_secure_password

  enum role: [:volunteer, :staff, :admin]

  has_many :user_classrooms, :dependent => :destroy
  has_many :classrooms, through: :user_classrooms
  has_many :events, through: :user_classrooms

  def events
    Event.where(user_classroom_id: self.user_classrooms)
  end
end
