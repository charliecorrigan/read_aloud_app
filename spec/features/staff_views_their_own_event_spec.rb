require 'rails_helper'

RSpec.describe "Staff visits new event page" do
  it "they fill out event form" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      active: true,
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)school = School.create(name: "Hogwarts", address: "123 Wizard Way")
    class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
    user_classroom = UserClassroom.create(user_id: staff.id, classroom_id: class1.id)
    event1 = Event.create(user_classroom_id: user_classroom.id, event_date: "2016-09-30", kids: 18, adults: 3)
    visit root
    fill_in "username", with: staff.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "History"
    click_on "2016-09-30 Prof. Snape"

    expect(current_path).to eq("/users/#{staff.id}/events/#{staff.events.last.id}")
    expect(page).to have_content("18")
  end