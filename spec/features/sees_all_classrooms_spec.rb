require 'rails_helper'

RSpec.describe "User visits a school page" do
  context "as admin" do
    it "they see all classrooms for that school" do
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      class2 = school.classrooms.create(teacher_name: "Mr. Firenze", grade_level: "Kindergarten", number_of_students_enrolled: 12)
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

      expect(current_path).to eq(staff_school_path(school))
      expect(page).to have_content("Prof. Snape")
      expect(page).to have_content("Mr. Firenze")
    end
  end

  context "as staff" do
    it "they see all classrooms for that school" do
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      class2 = school.classrooms.create(teacher_name: "Mr. Firenze", grade_level: "Kindergarten", number_of_students_enrolled: 12)
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

      expect(current_path).to eq(staff_school_path(school))
      expect(page).to have_content("Prof. Snape")
      expect(page).to have_content("Mr. Firenze")
    end
  end

  context "as volunteer" do
    it "they cannot see the page" do
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      class2 = school.classrooms.create(teacher_name: "Mr. Firenze", grade_level: "Kindergarten", number_of_students_enrolled: 12)
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

      visit staff_school_path(school)
      expect(page).to_not have_content("Mr. Firenze")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end