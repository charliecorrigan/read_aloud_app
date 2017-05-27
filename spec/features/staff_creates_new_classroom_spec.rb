require 'rails_helper'

RSpec.describe "Staff creates new classroom" do
  it "they fill out new classroom form" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")

    visit login_path
    fill_in "Username", with: staff.username
    fill_in "Password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "Manage"
    click_on "View All Schools"
    click_on school.name
    click_on "Add Classroom"
    fill_in "Teacher name", with: "Prof. Snape"
    select "ECE", from: "classroom[grade_level]"

    fill_in "classroom[number_of_students_enrolled]", with: 20
    click_on "Add classroom"

    expect(current_path).to eq(staff_school_path(school))
    expect(page).to have_content("Prof. Snape")
    expect(page).to have_link('Add Classroom')
  end
end
