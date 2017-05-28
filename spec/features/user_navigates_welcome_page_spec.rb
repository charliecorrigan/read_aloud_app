require 'rails_helper'

RSpec.describe "User navigates welcome page" do
  context "as admin" do
    it "they click on Read" do
      admin = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"
      click_on "Read"

      expect(current_path).to eq(new_user_event_path(admin))
    end

    it "they click on History" do
      admin = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"
      click_on "History"

      expect(current_path).to eq(user_events_path(admin))
    end

    it "they click on Profile" do
      admin = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"
      click_on "Profile"

      expect(current_path).to eq(user_profiles_path(admin))
    end

    it "they click on Manage" do
      admin = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"
      click_on "Manage"

      expect(current_path).to eq(staff_dashboards_path)
    end

    it "they click on Sign Out" do
      admin = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"
      click_on "Sign Out"

      expect(current_path).to eq(login_path)
    end
  end

  context "as staff" do
    it "they click on Read" do
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
      click_on "Read"

      expect(current_path).to eq(new_user_event_path(staff))
    end

    it "they click on History" do
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
      click_on "History"

      expect(current_path).to eq(user_events_path(staff))
    end

    it "they click on Profile" do
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
      click_on "Profile"

      expect(current_path).to eq(user_profiles_path(staff))
    end

    it "they click on Manage" do
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

      expect(current_path).to eq(staff_dashboards_path)
    end

    it "they click on Sign Out" do
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
      click_on "Sign Out"

      expect(current_path).to eq(login_path)
    end
  end

  context "as volunteer" do
    it "they click on Read" do
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
      click_on "Read"

      expect(current_path).to eq(new_user_event_path(volunteer))
    end

    it "they click on History" do
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
      click_on "History"

      expect(current_path).to eq(user_events_path(volunteer))
    end

    it "they click on Sign Out" do
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
      click_on "Sign Out"

      expect(current_path).to eq(login_path)
    end

    it "can't access Manage or Profile" do
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

      expect(page).to_not have_content("Manage")
      expect(page).to_not have_content("Profile")
    end
  end
end