require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:language) }
    it { should validate_uniqueness_of(:username) }
  end

  describe "relationships" do
    it { should have_many(:user_classrooms) }
    it { should have_many(:classrooms) }
    it { should have_many(:events) }
  end

  describe "#volunteer?" do
    it "can be created as a volunteer" do
      user = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)

      expect(user.role).to eq("volunteer")
      expect(user).to be_volunteer
      expect(user.admin?).to be_falsey
      expect(user.staff?).to be_falsey
    end
  end

  describe "#staff?" do
    it "can be created as a staff" do
      user = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)

      expect(user.role).to eq("staff")
      expect(user).to be_staff
      expect(user.volunteer?).to be_falsey
      expect(user.admin?).to be_falsey
    end
  end

    describe "#admin?" do
    it "can be created as a admin" do
      user = User.create(first_name: "Albus",
                        last_name: "Dumbledore",
                        username: "adumbledore",
                        password: "pointstogryffindor",
                        role: 2,
                        language: 0)

      expect(user.role).to eq("admin")
      expect(user).to be_admin
      expect(user.volunteer?).to be_falsey
      expect(user.staff?).to be_falsey
    end
  end

  describe "#english?" do
    it "user can select english as language" do
      volunteer = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)

      staff = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)

      admin = User.create(first_name: "Albus",
                        last_name: "Dumbledore",
                        username: "adumbledore",
                        password: "pointstogryffindor",
                        role: 2,
                        language: 0)

      expect(volunteer.language).to eq("english")
      expect(staff.language).to eq("english")
      expect(admin.language).to eq("english")
      expect(volunteer.english?).to be_truthy
      expect(volunteer.spanish?).to be_falsey
      expect(staff.english?).to be_truthy
      expect(admin.english?).to be_truthy
    end
  end

  describe "#spanish?" do
    it "user can select spanish as language" do
      volunteer = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 0,
                        language: 1)

      staff = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 1)

      admin = User.create(first_name: "Albus",
                        last_name: "Dumbledore",
                        username: "adumbledore",
                        password: "pointstogryffindor",
                        role: 2,
                        language: 1)

      expect(volunteer.language).to eq("spanish")
      expect(staff.language).to eq("spanish")
      expect(admin.language).to eq("spanish")
      expect(volunteer.spanish?).to be_truthy
      expect(volunteer.english?).to be_falsey
      expect(staff.spanish?).to be_truthy
      expect(admin.spanish?).to be_truthy
    end
  end
end
