require 'rails_helper'

RSpec.describe "User deletes school" do
  context "as admin" do
    it "they click delete" do
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
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
      click_link "Delete"

      expect(current_path).to eq(staff_schools_path)
      expect(page).to_not have_content("Hogwarts")
    end
  end

  context "as staff" do
    it "they click delete" do
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
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
      click_link "Delete"

      expect(current_path).to eq(staff_schools_path)
      expect(page).to_not have_content("Hogwarts")
    end
  end

  context "as volunteer" do
    it "they cannot see the page" do
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
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

      visit staff_schools_path
      expect(page).to_not have_content("Hogwarts")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end