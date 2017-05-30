require 'rails_helper'

RSpec.describe "user deletes another user" do
  context "as admin deleting another admin" do
    it "they delete another account" do
      admin = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 2,
                        language: 0)
      other_admin = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 2,
                        language: 0)
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      user_classroom = UserClassroom.create(user_id: other_admin.id, classroom_id: class1.id)
      event1 = Event.create(user_classroom_id: user_classroom.id, date: "2016-09-30", kids: 18, adults: 3)

      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"
      within(".button-list") do
        click_on("Manage")
      end
      click_on "View All Users"
      click_on "Hermione Granger"
      click_on "Delete Account"

      expect(current_path).to eq(users_path)
      expect(page).to_not have_content("Hermione")
      expect(page).to have_content("Minerva")
    end
  end

  context "as admin deleting a staff" do
    it "they delete another account" do
      admin = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 2,
                        language: 0)
      staff = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      user_classroom = UserClassroom.create(user_id: staff.id, classroom_id: class1.id)
      event1 = Event.create(user_classroom_id: user_classroom.id, date: "2016-09-30", kids: 18, adults: 3)

      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"
      within(".button-list") do
        click_on("Manage")
      end
      click_on "View All Users"
      click_on "Hermione Granger"
      click_on "Delete Account"

      expect(current_path).to eq(users_path)
      expect(page).to_not have_content("Hermione")
      expect(page).to have_content("Minerva")
    end
  end

  context "as admin deleting a volunteer" do
    it "they delete another account" do
      admin = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 2,
                        language: 0)
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

      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"
      within(".button-list") do
        click_on("Manage")
      end
      click_on "View All Users"
      click_on "Hermione Granger"
      click_on "Delete Account"

      expect(current_path).to eq(users_path)
      expect(page).to_not have_content("Hermione")
      expect(page).to have_content("Minerva")
    end
  end

  context "as staff deleting another staff" do
    it "they can not see an Delete Account button" do
      staff = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
      other_staff = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      user_classroom = UserClassroom.create(user_id: other_staff.id, classroom_id: class1.id)
      event1 = Event.create(user_classroom_id: user_classroom.id, date: "2016-09-30", kids: 18, adults: 3)

      visit login_path
      fill_in "Username", with: staff.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"

      within(".button-list") do
        click_on("Manage")
      end
      click_on "View All Users"
      click_on "Hermione Granger"

      expect(current_path).to eq(user_profiles_path(other_staff))
      expect(page).to have_content("Hermione")
      expect(page).to_not have_content("Delete Account")
    end
  end

  context "as staff deleting an admin" do
    it "they can not see an Delete Account button" do
      staff = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
      admin = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 2,
                        language: 0)
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      user_classroom = UserClassroom.create(user_id: admin.id, classroom_id: class1.id)
      event1 = Event.create(user_classroom_id: user_classroom.id, date: "2016-09-30", kids: 18, adults: 3)

      visit login_path
      fill_in "Username", with: staff.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"

      within(".button-list") do
        click_on("Manage")
      end
      click_on "View All Users"
      click_on "Hermione Granger"

      expect(current_path).to eq(user_profiles_path(admin))
      expect(page).to have_content("Hermione")
      expect(page).to_not have_content("Delete Account")
    end
  end

  context "as staff deleting a volunteer" do
    it "they delete another account" do
      staff = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 1,
                        language: 0)
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

      visit login_path
      fill_in "Username", with: staff.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"
      within(".button-list") do
        click_on("Manage")
      end
      click_on "View All Users"
      click_on "Hermione Granger"
      click_on "Delete Account"

      expect(current_path).to eq(users_path)
      expect(page).to_not have_content("Hermione")
      expect(page).to have_content("Minerva")
    end
  end

  context "as volunteer trying to edit another volunteer" do
    it "they can't see the page" do
      volunteer = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)
      other_volunteer = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      user_classroom = UserClassroom.create(user_id: other_volunteer.id, classroom_id: class1.id)
      event1 = Event.create(user_classroom_id: user_classroom.id, date: "2016-09-30", kids: 18, adults: 3)

      visit login_path
      fill_in "Username", with: volunteer.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"
  
      visit user_profiles_path(other_volunteer)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context "as volunteer trying to edit staff" do
    it "they can't see the page" do
      volunteer = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)
      staff = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      user_classroom = UserClassroom.create(user_id: staff.id, classroom_id: class1.id)
      event1 = Event.create(user_classroom_id: user_classroom.id, date: "2016-09-30", kids: 18, adults: 3)

      visit login_path
      fill_in "Username", with: volunteer.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"
  
      visit user_profiles_path(staff)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context "as volunteer trying to edit admin" do
    it "they can't see the page" do
      volunteer = User.create(first_name: "Minerva",
                        last_name: "McGonagall",
                        username: "mmcgonagall",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)
      admin = User.create(first_name: "Hermione",
                        last_name: "Granger",
                        username: "hgranger",
                        password: "supersecretpassword",
                        role: 0,
                        language: 0)
      school = School.create(name: "Hogwarts", address: "123 Wizard Way")
      class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
      user_classroom = UserClassroom.create(user_id: admin.id, classroom_id: class1.id)
      event1 = Event.create(user_classroom_id: user_classroom.id, date: "2016-09-30", kids: 18, adults: 3)

      visit login_path
      fill_in "Username", with: volunteer.username
      fill_in "Password", with: "supersecretpassword"
      click_on "Sign In"
  
      visit user_profiles_path(admin)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
