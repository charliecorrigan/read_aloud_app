require 'rails_helper'

RSpec.describe "User visits login page" do
  context "as admin" do
    it "has account and can log in" do
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

      expect(current_path).to eq(user_path(admin))
      expect(page).to have_content("Welcome, Albus")
      expect(page).to have_content("Read")
      expect(page).to have_content("Profile")
      expect(page).to have_content("History")
      expect(page).to have_content("Manage")
      expect(page).to have_content("Sign Out")
    end

    it "has account but enters wrong password" do
      admin = User.create(first_name: "Albus",
                        last_name: "Dumbledore",
                        username: "hogwarts4life",
                        password: "lemondrop",
                        role: 2,
                        language: 0)
      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "thisisthewrongpassword"
      click_on "Sign In"

      expect(current_path).to eq(login_path)
      # expect(page).to have_content("The username or password you entered doesn't match our records")
    end

    it "has account but enters wrong username" do
      admin = User.create(first_name: "Albus",
                        last_name: "Dumbledore",
                        username: "hogwarts4life",
                        password: "lemondrop",
                        role: 2,
                        language: 0)
      visit login_path
      fill_in "Username", with: "kalsjdafkj"
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"

      expect(current_path).to eq(login_path)
      # expect(current_path).to have_content("The username or password you entered doesn't match our records")
    end
  end

  context "as staff" do
    it "has account and can log in" do
      staff = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
      visit login_path
      fill_in "Username", with: staff.username
      fill_in "Password", with: "supersecretpassword"
    
      click_button "Sign In"

      expect(current_path).to eq(user_path(staff))
      expect(page).to have_content("Welcome, Minerva")
      expect(page).to have_content("Read")
      expect(page).to have_content("Profile")
      expect(page).to have_content("History")
      expect(page).to have_content("Manage")
      expect(page).to have_content("Sign Out")
    end

    it "has account but enters wrong password" do
      staff = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
      visit login_path
      fill_in "Username", with: staff.username
      fill_in "Password", with: "thisisthewrongpassword"
      click_on "Sign In"

      expect(current_path).to eq(login_path)
      # expect(page).to have_content("The username or password you entered doesn't match our records")
    end

    it "has account but enters wrong username" do
      staff = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
      visit login_path
      fill_in "Username", with: "grangerh"
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"

      expect(current_path).to eq(login_path)
      # expect(current_path).to have_content("The username or password you entered doesn't match our records")
    end
  end

  context "as volunteer" do
    it "has account and can log in" do
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

      expect(current_path).to eq(user_path(volunteer))
      expect(page).to have_content("Welcome, Hermione")
      expect(page).to have_content("Read")
      expect(page).to_not have_content("Profile")
      expect(page).to_not have_content("Manage")
      expect(page).to have_content("Sign Out")
    end

    it "has no account and can't log in" do
      visit login_path
      fill_in "Username", with: "John Snow"
      fill_in "Password", with: "youknownothing"
      click_on "Sign In"

      expect(current_path).to eq(login_path)
      # expect(current_path).to have_content("The username or password you entered doesn't match our records")
    end

    it "has account but enters wrong password" do
      volunteer = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)
      visit login_path
      fill_in "Username", with: volunteer.username
      fill_in "Password", with: "thisisthewrongpassword"
      click_on "Sign In"

      expect(current_path).to eq(login_path)
      # expect(current_path).to have_content("The username or password you entered doesn't match our records")
    end

  it "has account but enters wrong username" do
      volunteer = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)
      visit login_path
      fill_in "Username", with: "grangerh"
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"

      expect(current_path).to eq(login_path)
      # expect(current_path).to have_content("The username or password you entered doesn't match our records")
    end
  end
end
