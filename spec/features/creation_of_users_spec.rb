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
      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "lemondrop"
      click_button "Sign In"

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

    it "enters data for new admin user" do
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

      visit new_user_path
      fill_in "First name", with: "Aberforth"
      fill_in "Last name", with: "Dumbledore"
      fill_in "Username", with: "abdumbledore"
      fill_in "Password", with: "supersecretpassword"
      select "admin", :from => "user_role"
      select "english", :from => "user_language"
      click_button "Create Account"

      expect(page).to have_content("Aberforth")
    end

    it "enters data for new volunteer" do
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

      visit new_user_path
      fill_in "First name", with: "Hermione"
      fill_in "Last name", with: "Granger"
      fill_in "Username", with: "hgranger"
      fill_in "Password", with: "supersecretpassword"
      select "volunteer", :from => "user_role"
      select "english", :from => "user_language"
      click_button "Create Account"

      expect(page).to have_content("Hermione")
    end
  end

  context "as staff" do
    it "enters data for new volunteer" do
      staff = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "lemondrop",
                        role: 1,
                        language: 0)
      visit login_path
      fill_in "Username", with: staff.username
      fill_in "Password", with: "lemondrop"
      click_button "Sign In"

      visit new_user_path
      fill_in "First name", with: "Hermione"
      fill_in "Last name", with: "Granger"
      fill_in "Username", with: "hgranger"
      fill_in "Password", with: "supersecretpassword"
      select "english", :from => "user_language"
      expect(page).to_not have_content("Position")
      
      click_button "Create Account"

      user = User.find_by(first_name: "Hermione")
      expect(current_path).to eq(user_profiles_path(user))
      expect(page).to have_content("Hermione")
      expect(user).to be_volunteer
    end
  end

  context "as volunteer" do
    it "doesn't see the page" do
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

      visit new_user_path
      expect(page).to_not have_content("Create Account")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
