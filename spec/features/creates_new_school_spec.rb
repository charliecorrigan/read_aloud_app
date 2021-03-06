require 'rails_helper'

RSpec.describe "User creates new school" do
    context "as admin" do
    it "they fill out new school form" do
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

      within(".button-list") do         click_on("Manage")       end
      click_on "Add School"
      fill_in "Name", with: "Hogwarts"
      fill_in "Address", with: "123 Wizard Way"
      click_on "Create School"
      school = School.find_by(name: "Hogwarts")

      expect(current_path).to eq(staff_school_path(school))
      expect(page).to have_content("Hogwarts")
      expect(page).to have_link('Add Classroom')
    end
  end

  context "as staff" do
    it "they fill out new school form" do
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

      within(".button-list") do         click_on("Manage")       end
      click_on "Add School"
      fill_in "Name", with: "Hogwarts"
      fill_in "Address", with: "123 Wizard Way"
      click_on "Create School"
      school = School.find_by(name: "Hogwarts")

      expect(current_path).to eq(staff_school_path(school))
      expect(page).to have_content("Hogwarts")
      expect(page).to have_link('Add Classroom')
    end
  end

  context "as volunteer" do
    it "they can't visit page" do
      volunteer = User.create(first_name: "Hermione",
                      last_name: "Granger",
                      username: "hgranger",
                      password: "supersecretpassword",
                      role: 0,
                      language: 0)
      visit login_path
      fill_in "Username", with: volunteer.username
      fill_in "Password", with: "supersecretpassword"
      click_button "Sign In"

      visit new_staff_school_path
      expect(page).to_not have_content("Create School")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
