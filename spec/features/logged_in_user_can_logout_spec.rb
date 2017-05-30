require 'rails_helper'

RSpec.describe "Logged in user clicks sign out" do
  context "as admin" do
    it "they successfully sign out" do
      admin = User.create(first_name: "Albus",
                        last_name: "Dumbledore",
                        username: "hogwarts4life",
                        password: "lemondrop",
                        role: 2,
                        language: 0)
      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "lemondrop"
      click_on "Sign In"
      within(".button-list") {  click_on("Sign Out") }

      expect(current_path).to eq(login_path)
      expect(page).to have_button("Sign In")
      expect(page).to_not have_content("Albus")
    end
  end

  context "as staff" do
    it "they successfully sign out" do
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
      within(".button-list") {  click_on("Sign Out") }

      expect(current_path).to eq(login_path)
      expect(page).to have_button("Sign In")
      expect(page).to_not have_content("Minerva")
    end
  end

  context "as user" do
    it "they successfully sign out" do
      user = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)
      visit login_path
      fill_in "Username", with: user.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"
      within(".button-list") {  click_on("Sign Out") }

      expect(current_path).to eq(login_path)
      expect(page).to have_button("Sign In")
      expect(page).to_not have_content("Hermione")
    end
  end
end