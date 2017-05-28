class Event < ApplicationRecord
  validates :kids, presence: true
  validates :adults, presence: true
  validates :date, presence: true

  belongs_to :user_classroom
end
