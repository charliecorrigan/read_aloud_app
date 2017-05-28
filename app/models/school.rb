class School < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  has_many :classrooms, :dependent => :destroy
end
