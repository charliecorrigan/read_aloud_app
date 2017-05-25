require 'rails_helper'

RSpec.describe "Staff visits a school page" do
  it "they see all classrooms for that school" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      active: true,
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")
    class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
    visit root
    fill_in "username", with: user.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "Manage"
    click_on "View Schools"
    click_on school.name
    within(:css, 'classrooms') { click_button "Edit" }

    expect(current_path).to eq(edit_school__classroom_path(school, class1))
    expect(page).to have_content("Prof. Snape")
  end