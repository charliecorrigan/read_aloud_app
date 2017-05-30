require 'rails_helper'

RSpec.describe "User sees all their events" do
  context "as admin" do
    it "they see a list of their events" do
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
      event2 = Event.create(user_classroom_id: user_classroom.id, date: "2016-10-03", kids: 20, adults: 3)

      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "lemondrop"
      click_on "Sign In"

      within(".button-list") {  click_on("History") }

      expect(current_path).to eq(user_events_path(admin))
      expect(page).to have_content("2016-10-03 Prof. Snape")
      expect(page).to have_content("2016-09-30 Prof. Snape")
    end
  end

  context "as staff" do
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

      within(".button-list") {  click_on("History") }

      expect(current_path).to eq(user_events_path(staff))
      expect(page).to have_content("2016-10-03 Prof. Snape")
      expect(page).to have_content("2016-09-30 Prof. Snape")
    end
  end

  context "as volunteer" do
    it "sees all recorded events in history" do
      volunteer = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      user_classroom = UserClassroom.create(user_id: volunteer.id, classroom_id: class1.id)
      event1 = Event.create(user_classroom_id: user_classroom.id, date: "2016-09-30", kids: 18, adults: 3)
      event2 = Event.create(user_classroom_id: user_classroom.id, date: "2016-10-03", kids: 20, adults: 3)
      event3 = Event.create(user_classroom_id: user_classroom.id, date: "2016-10-10", kids: 20, adults: 3)

      visit login_path
      fill_in "Username", with: volunteer.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"
      within(".button-list") {  click_on("History") }

      expect(current_path).to eq(user_events_path(volunteer))
      expect(page).to have_link "2016-10-10 Prof. Snape"
      expect("2016-10-10 Prof. Snape").to appear_in_page_before("2016-10-03 Prof. Snape")
      expect("2016-10-03 Prof. Snape").to appear_in_page_before("2016-09-30 Prof. Snape")
    end
  end
end
