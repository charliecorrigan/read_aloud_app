require 'rails_helper'

RSpec.describe "User views all users" do
  context "as admin" do
    it "they see a list of all volunteers" do
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      volunteer = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)
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

      expect(current_path).to eq(users_path)
      expect(page).to have_content("Hermione")
      expect(page).to have_content("Granger")
      expect(page).to have_content("hgranger")
      expect(page).to have_content("volunteer")

      expect(page).to have_content("Albus")
      expect(page).to have_content("Dumbledore")
      expect(page).to have_content("hogwarts4life")
      expect(page).to have_content("admin")
    end
  end

context "as staff" do
    it "they see a list of all volunteers" do
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
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

      visit login_path
      fill_in "Username", with: staff.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"

      within(".button-list") do
        click_on("Manage")
      end
      click_on "View All Users"

      expect(current_path).to eq(users_path)
      expect(page).to have_content("Hermione")
      expect(page).to have_content("Granger")
      expect(page).to have_content("hgranger")
      expect(page).to have_content("volunteer")

      expect(page).to have_content("Minerva")
      expect(page).to have_content("McGonagall")
      expect(page).to have_content("mmcgonagall")
      expect(page).to have_content("staff")
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
      staff = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)

      visit login_path
      fill_in "Username", with: volunteer.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"

      visit users_path
      expect(page).to_not have_content("Minerva")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end

