require 'rails_helper'

RSpec.describe School, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "relationships" do
    it { should have_many(:classrooms) }
  end
end
