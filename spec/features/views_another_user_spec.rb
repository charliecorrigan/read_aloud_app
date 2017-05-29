require 'rails_helper'

RSpec.describe "User sees another user's page" do
  context "as admin" do
    it "they see a volunteers information" do
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

      click_on "Manage"
      click_on "View All Users"
      click_on "Hermione Granger"

      expect(current_path).to eq(user_profiles_path(volunteer))
      expect(page).to have_content("Hermione")
      expect(page).to have_content("Granger")
      expect(page).to have_content("hgranger")
      expect(page).to have_content("Hogwarts")
      expect(page).to have_content("Prof. Snape")
      expect(page).to have_content("Edit Profile")
      expect(page).to have_content("Select School")
    end
  end

  context "as staff" do
    it "they see a volunteers information" do
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      staff = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
      volunteer = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)
      user_classroom = UserClassroom.create(user_id: volunteer.id, classroom_id: class1.id)

      visit login_path
      fill_in "Username", with: staff.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"

      click_on "Manage"
      click_on "View All Users"
      click_on "Hermione Granger"

      expect(current_path).to eq(user_profiles_path(volunteer))
      expect(page).to have_content("Hermione")
      expect(page).to have_content("Granger")
      expect(page).to have_content("hgranger")
      expect(page).to have_content("Hogwarts")
      expect(page).to have_content("Prof. Snape")
      expect(page).to have_content("Edit Profile")
      expect(page).to have_content("Select School")
    end
  end

  context "as volunteer" do
    it "they do not see the page" do
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      staff = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
      volunteer = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)
      user_classroom = UserClassroom.create(user_id: staff.id, classroom_id: class1.id)

      visit login_path
      fill_in "Username", with: volunteer.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"

      visit user_profiles_path(staff)
      expect(page).to_not have_content("Minerva")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end