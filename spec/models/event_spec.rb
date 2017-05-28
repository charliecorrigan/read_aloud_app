require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "validations" do
    it { should validate_presence_of(:kids) }
    it { should validate_presence_of(:adults) }
    it { should validate_presence_of(:date) }
  end

  describe "relationships" do
    it { should belong_to(:user_classroom) }
  end
end
