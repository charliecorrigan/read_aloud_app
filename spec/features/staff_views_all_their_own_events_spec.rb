require 'rails_helper'

RSpec.describe "Staff visits their events index" do
  it "they see a list of their events" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")
    class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
    user_classroom = UserClassroom.create(user_id: staff.id, classroom_id: class1.id)
    event1 = Event.create(user_classroom_id: user_classroom.id, date: "2016-09-30", kids: 18, adults: 3)
    event2 = Event.create(user_classroom_id: user_classroom.id, date: "2016-10-03", kids: 20, adults: 3)

    visit login_path
    fill_in "Username", with: staff.username
    fill_in "Password", with: "supersecretpassword"
    click_on "Sign In"

    click_on "History"

    expect(current_path).to eq(user_events_path(staff))
    expect(page).to have_content("2016-10-03 Prof. Snape")
    expect(page).to have_content("2016-09-30 Prof. Snape")
  end
end
