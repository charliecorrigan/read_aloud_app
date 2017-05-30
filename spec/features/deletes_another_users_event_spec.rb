require 'rails_helper'

RSpec.describe "User visits new event page" do
  context "as staff" do
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
      event1 = Event.create(user_classroom_id: user_classroom.id, date: "2016-09-30", kids: 18, adults: 3)
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
      click_on "View All Events"
      click_on "Delete"

      expect(current_path).to eq(staff_events_path)
      expect(page).to_not have_content("2016-09-30")
    end
  end

  context "as staff" do
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
      event1 = Event.create(user_classroom_id: user_classroom.id, date: "2016-09-30", kids: 18, adults: 3)
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
      click_on "View All Events"
      click_on "Delete"

      expect(current_path).to eq(staff_events_path)
      expect(page).to_not have_content("2016-09-30")
    end
  end

  context "as volunteer" do
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
      event1 = Event.create(user_classroom_id: user_classroom.id, date: "2016-09-30", kids: 18, adults: 3)
      volunteer2 = User.create(first_name: "Draco",
                        last_name: "Malfoy",
                        username: "dmalfoy",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)

      visit login_path
      fill_in "Username", with: volunteer2.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"

      visit staff_events_path
      expect(page).to_not have_content("18")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end