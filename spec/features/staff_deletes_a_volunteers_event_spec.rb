require 'rails_helper'

RSpec.describe "Staff visits new event page" do
  it "they fill out event form" do
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")
    class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      active: true,
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    volunteer = User.create(first_name: "Hermione",
                      last_name: "Granger",
                      active: true,
                      username: "hgranger",
                      password: "supersecretpassword",
                      role: 0,
                      language: 0)
    user_classroom = UserClassroom.create(user_id: volunteer.id, classroom_id: class1.id)
    event1 = Event.create(user_classroom_id: user_classroom.id, event_date: "2016-09-30", kids: 18, adults: 3)
    event2 = Event.create(user_classroom_id: user_classroom.id, event_date: "2016-10-03", kids: 20, adults: 3)
    visit root
    fill_in "username", with: staff.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "Manage"
    click_on "View All Events"
    click_on "2016-10-03 Prof. Snape"
    click_on "Delete Event"

    expect(current_path).to eq(users_events_path)
    expect(page).to_not have_content("2016-10-03 Prof. Snape")
  end
end
