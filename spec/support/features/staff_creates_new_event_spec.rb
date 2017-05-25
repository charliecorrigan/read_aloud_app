require 'rails_helper'

RSpec.describe "Staff visits new event page" do
  it "they fill out event form" do
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
    fill_in "username", with: staff.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "Read"
    #------------------------------------------------
    # Unsure of classroom/school/grade dropdown setup
    #------------------------------------------------
    fill_in "How many kids", with: 18
    fill_in "How many adults", with: 3
    fill_in "How many minutes", with: 20
    click_on "Next"
    #------------------------------------------------
    # Will this create a new event?
    # Will users confirm BEFORE creating? (before_action will redirect to confirmation)
    # If users can edit -- probably just create with no confirmation
    #------------------------------------------------

    #expect(current_path).to eq(new_user_event_path(user))
  end