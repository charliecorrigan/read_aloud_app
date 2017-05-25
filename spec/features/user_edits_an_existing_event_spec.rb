require 'rails_helper'

RSpec.describe "User edits an existing event" do
  it "they fill out and save edit form" do
    user = User.create(first_name: "Hermione",
                      last_name: "Granger",
                      active: true,
                      username: "hgranger",
                      password: "supersecretpassword",
                      role: 0,
                      language: 0)
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")
    class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
    user_classroom = UserClassroom.create(user_id: user.id, classroom_id: class1.id)
    event1 = Event.create(user_classroom_id: user_classroom.id, event_date: "2016-09-30", kids: 18, adults: 3)

    visit root
    fill_in "username", with: user.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "History"
    click_on "2016-09-30 Prof. Snape"
    click_on "Edit"
    fill_in "How many kids", with: 17
    fill_in "How many adults", with: 4
    click_on "Save Changes"

    expect(current_path).to eq("/users/#{user.id}/events/#{user.events.last.id}")
    expect(page).to have_content "Event Date: 2016-09-30"
    expect(page).to have_content "Kids present: 17"
    expect(page).to have_content "Adults present: 4"
    expect(page).to have_link "Edit"
    expect(page).to have_link "Delete"
  end
end