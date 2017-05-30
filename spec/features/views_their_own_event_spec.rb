require 'rails_helper'

RSpec.describe "User sees a specific events" do
  context "as admin" do
    it "they see a specific event" do
      admin = User.create(first_name: "Albus",
                        last_name: "Dumbledore",
                        username: "hogwarts4life",
                        password: "lemondrop",
                        role: 2,
                        language: 0)
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      user_classroom = UserClassroom.create(user_id: admin.id, classroom_id: class1.id)
      event1 = Event.create(user_classroom_id: user_classroom.id, date: "2016-09-30", kids: 18, adults: 3)

      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "lemondrop"
      click_on "Sign In"

      within(".button-list") {  click_on("History") }
      click_on "2016-09-30 Prof. Snape"

      expect(current_path).to eq("/users/#{admin.id}/events/#{admin.events.last.id}")
      expect(page).to have_content("18")
    end
  end

  context "as staff" do
    it "they see a specific event" do
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

      visit login_path
      fill_in "Username", with: staff.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"

      within(".button-list") {  click_on("History") }
      click_on "2016-09-30 Prof. Snape"

      expect(current_path).to eq("/users/#{staff.id}/events/#{staff.events.last.id}")
      expect(page).to have_content("18")
    end
  end

  context "as volunteer" do
    it "sees stats about that event" do
      user = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      user_classroom = UserClassroom.create(user_id: user.id, classroom_id: class1.id)
      event1 = Event.create(user_classroom_id: user_classroom.id, date: "2016-10-10", kids: 20, adults: 3)

      visit login_path
      fill_in "Username", with: user.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"
      within(".button-list") {  click_on("History") }
      click_on "2016-10-10 Prof. Snape"

      expect(current_path).to eq(user_event_path(user, event1))
      expect(page).to have_content "Event Date: #{event1.date}"
      expect(page).to have_content "School: #{school.name}"
      expect(page).to have_content "Teacher: #{class1.teacher_name}"
      expect(page).to have_content "Grade: #{class1.grade_level}"
      expect(page).to have_content "Kids present: #{event1.kids}"
      expect(page).to have_content "Adults present: #{event1.adults}"
      expect(page).to have_link "Edit"
      expect(page).to have_link "Delete"
    end
  end
end
