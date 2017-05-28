require 'rails_helper'

RSpec.describe "User creates a new event" do
  context "as admin" do
    it "they fill out event form" do
      admin = User.create(first_name: "Albus",
                        last_name: "Dumbledore",
                        username: "hogwarts4life",
                        password: "lemondrop",
                        role: 2,
                        language: 0)
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      user_classroom = UserClassroom.create(user_id: admin.id, classroom_id: class1.id)

      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "lemondrop"
      click_on "Sign In"

      click_on "Read"
      fill_in "event[date]", with: "2016-09-30"
      select "Prof. Snape", from: "event[user_classroom_id]"
      fill_in "event[kids]", with: 18
      fill_in "event[adults]", with: 3
      click_on "Submit"

      expect(current_path).to eq(user_event_path(admin, admin.events.first))
    end
  end

  context "as staff" do
    it "they fill out event form" do
      staff = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      user_classroom = UserClassroom.create(user_id: staff.id, classroom_id: class1.id)

      visit login_path
      fill_in "Username", with: staff.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"

      click_on "Read"
      fill_in "event[date]", with: "2016-09-30"
      select "Prof. Snape", from: "event[user_classroom_id]"
      fill_in "event[kids]", with: 18
      fill_in "event[adults]", with: 3
      click_on "Submit"

      expect(current_path).to eq(user_event_path(staff, staff.events.first))
    end
  end

  context "as volunteer" do
    it "they fill out and save event form" do
      volunteer = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      user_classroom = UserClassroom.create(user_id: volunteer.id, classroom_id: class1.id)

      visit login_path
      fill_in "Username", with: volunteer.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"
      click_on "Read"

      select "Prof. Snape", from: "event[user_classroom_id]"
      fill_in "event[date]", with: "2016-09-30"
      fill_in "event[kids]", with: 18
      fill_in "event[adults]", with: 3
      click_on "Submit"

      expect(current_path).to eq(user_event_path(volunteer, volunteer.events.last))
      expect(page).to have_content "Event Date: 2016-09-30"
      expect(page).to have_content "Kids present: 18"
      expect(page).to have_content "Adults present: 3"
      expect(page).to have_link "Edit"
      expect(page).to have_link "Delete"
    end
  end
end
