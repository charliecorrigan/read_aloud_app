require 'rails_helper'

RSpec.describe "User creates a new event" do
  it "they fill out and save event form" do
    user = User.create(first_name: "Hermione",
                      last_name: "Granger",
                      username: "hgranger",
                      password: "supersecretpassword",
                      role: 0,
                      language: 0)
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")
    class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
    user_classroom = UserClassroom.create(user_id: user.id, classroom_id: class1.id)

    visit login_path
    fill_in "Username", with: user.username
    fill_in "Password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "Read"

    select "Prof. Snape", from: "event[user_classroom_id]"
    fill_in "event[date]", with: "2016-09-30"
    fill_in "event[kids]", with: 18
    fill_in "event[adults]", with: 3
    click_on "Submit"

    expect(current_path).to eq(user_event_path(user, user.events.last))
    expect(page).to have_content "Event Date: 2016-09-30"
    expect(page).to have_content "Kids present: 18"
    expect(page).to have_content "Adults present: 3"
    expect(page).to have_link "Edit"
    expect(page).to have_link "Delete"
  end
end
