class UserClassroom < ApplicationRecord
  belongs_to :user
  belongs_to :classroom
  has_many :events
end
