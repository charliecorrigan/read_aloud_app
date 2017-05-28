require 'rails_helper'

RSpec.describe "Staff edits an existing volunteer" do
  it "they fill out edit volunteer form" do
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
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")
    class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
    class2 = school.classrooms.create(teacher_name: "Prof. Flitwick", grade_level: "ECE", number_of_students_enrolled: 12)

    user_classroom = UserClassroom.create(user_id: volunteer.id, classroom_id: class1.id)
    event1 = Event.create(user_classroom_id: user_classroom.id, date: "2016-09-30", kids: 18, adults: 3)

    visit login_path
    fill_in "Username", with: staff.username
    fill_in "Password", with: "supersecretpassword"
    click_on "Sign In"

    click_on "Manage"
    click_on "View All Volunteers"
    click_on "Hermione Granger"
    select "Hogwarts", from: "schools"
    click_on "Submit"
    select "Prof. Flitwick", from: "user_classroom[classroom_id]"

    click_on "Select Classroom"
    expect(current_path).to eq(user_profiles_path(volunteer))
    expect(page).to have_content("Hermione")
    expect(page).to have_content("Prof. Snape")
    expect(page).to have_content("Prof. Flitwick")
  end
end