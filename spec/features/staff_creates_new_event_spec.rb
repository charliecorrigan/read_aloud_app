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
    user_classroom = UserClassroom.create(user_id: staff.id, classroom_id: class1.id)

    visit root
    fill_in "username", with: staff.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"

    click_on "Read"
    fill_in "Event Date", with "2016-09-30"
    select staff.classrooms.find(class1.id).id, from => "classrooms"
    fill_in "How many kids", with: 18
    fill_in "How many adults", with: 3
    click_on "Submit"

    expect(current_path).to eq("/users/#{staff.id}/events/#{staff.events.last.id}")
    expect(page).to have_content("18")
  end
end
