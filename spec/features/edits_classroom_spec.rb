require 'rails_helper'

RSpec.describe "User edits a classroom" do
  context "as admin" do
    it "they fill out new data for existing classroom" do
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
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

      click_on "Manage"
      click_on "View All Schools"
      click_on school.name
      click_on "Edit"
      fill_in "Teacher name", with: "Horace Slughorn"
      click_on "Update Classroom"

      expect(current_path).to eq(staff_school_path(school))
      expect(page).to_not have_content("Prof. Snape")
      expect(page).to have_content("Horace Slughorn")
    end
  end

  context "as staff" do
    it "they fill out new data for existing classroom" do
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
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

      click_on "Manage"
      click_on "View All Schools"
      click_on school.name
      click_on "Edit"
      fill_in "Teacher name", with: "Horace Slughorn"
      click_on "Update Classroom"

      expect(current_path).to eq(staff_school_path(school))
      expect(page).to_not have_content("Prof. Snape")
      expect(page).to have_content("Horace Slughorn")
    end
  end

  context "as volunteer" do
    it "they cannot see the page" do
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
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

      visit edit_staff_school_path(school)
      expect(page).to_not have_content("123 Wizard Way")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end