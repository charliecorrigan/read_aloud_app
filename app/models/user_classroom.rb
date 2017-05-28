class UserClassroom < ApplicationRecord
  belongs_to :user
  belongs_to :classroom
  has_many :events, :dependent => :destroy

  def teacher_name
    self.classroom.teacher_name
  end
end
