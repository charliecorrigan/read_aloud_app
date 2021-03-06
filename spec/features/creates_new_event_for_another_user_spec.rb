require 'rails_helper'

RSpec.describe "User visits new_user_event page" do
  context "as admin" do
    it "they fill out event form" do
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      volunteer = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)
      user_classroom = UserClassroom.create(user_id: volunteer.id, classroom_id: class1.id)
      admin = User.create(first_name: "Albus",
                        last_name: "Dumbledore",
                        username: "hogwarts4life",
                        password: "lemondrop",
                        role: 2,
                        language: 0)

      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "lemondrop"
      click_button "Sign In"

      within(".button-list") do
        click_on("Manage")
      end
      click_on "View All Users"
      click_on "Hermione Granger"
      click_on "Create New Event"
      select "Prof. Snape", from: "event[user_classroom_id]"
      fill_in "event[date]", with: "2016-09-30"
      fill_in "event[kids]", with: 18
      fill_in "event[adults]", with: 3
      click_on "Submit"

      event = Event.find_by(kids: 18)
      expect(current_path).to eq(user_event_path(volunteer, event))
    end
  end

  context "as staff" do
    it "they fill out event form" do
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      other_staff = User.create(first_name: "R",
                        last_name: "Hagrid",
                        username: "rhagrid",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
      user_classroom = UserClassroom.create(user_id: other_staff.id, classroom_id: class1.id)
      staff = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)

      visit login_path
      fill_in "Username", with: staff.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"

      within(".button-list") do
        click_on("Manage")
      end
      click_on "View All Users"
      click_on "R Hagrid"
      click_on "Create New Event"
      select "Prof. Snape", from: "event[user_classroom_id]"
      fill_in "event[date]", with: "2016-09-30"
      fill_in "event[kids]", with: 18
      fill_in "event[adults]", with: 3
      click_on "Submit"

      event = Event.find_by(kids: 18)
      expect(current_path).to eq(user_event_path(other_staff, event))
    end
  end

  context "as volunteer" do
    it "they cannot see the page" do
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      staff = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
      user_classroom = UserClassroom.create(user_id: staff.id, classroom_id: class1.id)
      volunteer = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)

      visit login_path
      fill_in "Username", with: volunteer.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"

      visit new_user_event_path(staff)
      expect(page).to_not have_content("Minerva")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end