require 'rails_helper'

RSpec.describe "User creates a new event" do
  it "they fill out and save event form" do
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

    visit root
    fill_in "username", with: user.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "Read"
    # select class1.id, from => "classrooms"
    select user.classrooms.find(class1.id).id, from => "classrooms"
    fill_in "Event Date", with "2016-09-30"
    fill_in "How many kids", with: 18
    fill_in "How many adults", with: 3
    click_on "Submit"

    expect(current_path).to eq("/users/#{user.id}/events/#{user.events.last.id}")
    expect(page).to have_content "Event Date: 2016-09-30"
    expect(page).to have_content "Kids present: 18"
    expect(page).to have_content "Adults present: 3"
    expect(page).to have_link "Edit"
    expect(page).to have_link "Delete"
  end
end
