require 'rails_helper'

RSpec.describe "User sees all events" do
  it "sees all recorded events in history" do
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
    event1 = Event.create(user_classroom_id: user_classroom.id, date: "2016-09-30", kids: 18, adults: 3)
    event2 = Event.create(user_classroom_id: user_classroom.id, date: "2016-10-03", kids: 20, adults: 3)
    event3 = Event.create(user_classroom_id: user_classroom.id, date: "2016-10-10", kids: 20, adults: 3)

    visit root
    fill_in "username", with: user.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "History"

    expect(current_path).to eq(user_events_path(user))
    expect(page).to have_link "2016-10-10 Prof. Snape"
    expect("2016-10-10 Prof. Snape").to appear_in_page_before("2016-10-03 Prof. Snape")
    expect("2016-10-03 Prof. Snape").to appear_in_page_before("2016-09-30 Prof. Snape")
  end
end
