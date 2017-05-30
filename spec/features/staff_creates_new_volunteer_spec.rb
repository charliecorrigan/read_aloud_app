require 'rails_helper'

RSpec.describe "Staff creates new volunteer" do
  it "they fill out new volunteer form" do
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")
    class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
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

    within(".button-list") do
        click_on("Manage")
      end
    click_on "Add Volunteer"

    fill_in "First name", with: "Hermione"
    fill_in "Last name", with: "Granger"
    fill_in "Username", with: "hgranger"
    fill_in "Password", with: "verysecretpassword"
    select 'english', from: 'user_language'

    click_on "Create Account"
    volunteer = User.find_by(first_name: "Hermione")

    expect(current_path).to eq(user_profiles_path(volunteer))
    expect(page).to have_content("Hermione")
    expect(page).to have_content("Granger")
    expect(page).to have_content("hgranger")
  end
end
