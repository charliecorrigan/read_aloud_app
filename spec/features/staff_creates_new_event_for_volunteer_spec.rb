require 'rails_helper'

RSpec.describe "Staff visits new volunteer event page" do
  it "they fill out event form" do
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
    user_classroom = UserClassroom.create(user_id: volunteer.id, classroom_id: class1.id)

    visit login_path
    fill_in "Username", with: staff.username
    fill_in "Password", with: "supersecretpassword"
    click_on "Sign In"

    click_on "Manage"
    click_on "View All Volunteers"
    click_on "Hermione Granger"
    click_on "Create New Event"
    select "Prof. Snape", from: "event[user_classroom_id]"
    fill_in "event[date]", with: "2016-09-30"
    fill_in "event[kids]", with: 18
    fill_in "event[adults]", with: 3
    click_on "Submit"

    event = Event.find_by(kids: 18)
    expect(current_path).to eq(user_event_path(volunteer, event))
  end
end
