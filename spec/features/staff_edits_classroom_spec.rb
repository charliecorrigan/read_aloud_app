require 'rails_helper'

RSpec.describe "Staff edits a classroom" do
  it "they fill out new data for existing classroom" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")
    class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)

    visit login_path
    fill_in "Username", with: staff.username
    fill_in "Password", with: "supersecretpassword"
    click_on "Sign In"

    click_on "Manage"
    click_on "View All Schools"
    click_on school.name
    click_on "Edit"
    fill_in "Teacher name", with: "Horace Slughorn"
    click_on "Update Classroom"

    expect(current_path).to eq(school_path(school))
    expect(page).to_not have_content("Prof. Snape")
    expect(page).to have_content("Horace Slughorn")
  end
end
