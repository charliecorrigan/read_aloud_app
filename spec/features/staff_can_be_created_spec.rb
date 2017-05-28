require 'rails_helper'

RSpec.describe "User visits new user page" do
  context "as admin" do
    it "enters data for new staff user" do
      admin = User.create(first_name: "Albus",
                        last_name: "Dumbledore",
                        username: "hogwarts4life",
                        password: "lemondrop",
                        role: 2,
                        language: 0)
      visit new_user_path
      fill_in "First name", with: "Minerva"
      fill_in "Last name", with: "McGonagall"
      fill_in "Username", with: "mmcgonagall"
      fill_in "Password", with: "supersecretpassword"
      select "staff", :from => "user_role"
      select "english", :from => "user_language"
      click_button "Create Account"

      expect(page).to have_content("Minerva")
    end
  end
end
