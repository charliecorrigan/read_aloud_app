require 'rails_helper'

RSpec.describe UserClassroom, type: :model do
  describe "relationships" do
    it { should belong_to(:user) }
    it { should belong_to(:classroom) }
    it { should have_many(:events) }
  end
end
