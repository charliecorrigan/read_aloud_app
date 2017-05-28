require 'rails_helper'

RSpec.describe "Staff sees a user page" do
  it "they see a volunteers information" do
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")
    class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    volunteer = User.create(first_name: "Hermione",
                      last_name: "Granger",
                      username: "hgranger",
                      password: "supersecretpassword",
                      role: 0,
                      language: 0)

    visit login_path
    fill_in "Username", with: staff.username
    fill_in "Password", with: "supersecretpassword"
    click_on "Sign In"

    click_on "Manage"
    click_on "View All Volunteers"
    click_on "Hermione Granger"
    save_and_open_page
    # expect(current_path).to eq(staff_user_path(staff, volunteer))
    # expect(page).to have_content("Hermione")
    # expect(page).to have_content("Granger")
    # expect(page).to have_content("hgranger")
    # expect(page).to have_content("Hogwarts")
    # expect(page).to have_content("Prof. Snape")
    # expect(page).to have_content("Edit Volunteer Info")
    # expect(page).to have_content("Add School")
  end
end
