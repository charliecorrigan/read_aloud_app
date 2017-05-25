require 'rails_helper'

RSpec.describe "Staff creates new classroom" do
  it "they fill out new classroom form" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      active: true,
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")
    visit root
    fill_in "username", with: user.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "Manage"
    click_on "View Schools"
    click_on school.name
    click_on "Add Classroom"
    fill_in "Teacher Name", with: "Prof. Snape"
    fill_in "Grade Level", with: "ECE"
    fill_in "Number of Students Enrolled", with: 20
    click_on "Add Classroom"

    expect(current_path).to eq(school_path(school))
    expect(page).to have_content("Prof. Snape")
    expect(page).to have_link('Add Classroom')
  end