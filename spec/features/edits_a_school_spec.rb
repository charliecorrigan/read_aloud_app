require 'rails_helper'

RSpec.describe "User edits a school" do
  context "as admin" do
    it "they fill out edit school form" do
      school = School.create(name: "Hogwarts", address: "address unavailable")
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
      click_on "View All Schools"
      click_on "Edit"
      fill_in "Address", with: "123 Wizard Way"
      click_on "Update School"

      expect(current_path).to eq(staff_school_path(school))
      expect(page).to_not have_content("address unavailable")
      expect(page).to have_content("123 Wizard Way")
      expect(page).to have_content("Hogwarts")
    end
  end

  context "as staff" do
    it "they fill out edit school form" do
      school = School.create(name: "Hogwarts", address: "address unavailable")
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
      click_on "View All Schools"
      click_on "Edit"
      fill_in "Address", with: "123 Wizard Way"
      click_on "Update School"

      expect(current_path).to eq(staff_school_path(school))
      expect(page).to_not have_content("address unavailable")
      expect(page).to have_content("123 Wizard Way")
      expect(page).to have_content("Hogwarts")
    end
  end

  context "as volunteer" do
    it "they cannot see the page" do
      school = School.create(name: "Hogwarts", address: "address unavailable")
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
      expect(page).to_not have_content("Hogwarts")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end