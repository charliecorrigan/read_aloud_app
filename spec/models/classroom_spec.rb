require 'rails_helper'

RSpec.describe Classroom, type: :model do
  describe "validations" do
    it { should validate_presence_of(:teacher_name) }
    it { should validate_presence_of(:grade_level) }
    it { should validate_presence_of(:number_of_students_enrolled) }
  end

  describe "relationships" do
    it { should have_many(:user_classrooms) }
    it { should have_many(:users) }
    it { should belong_to(:school) }
  end
end
