class School < ApplicationRecord
  has_many :classrooms, :dependent => :destroy
end
