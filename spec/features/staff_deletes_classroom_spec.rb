require 'rails_helper'

RSpec.describe "Staff deletes a classroom" do
  it "they click delete" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")
    class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)

    visit login_path
    fill_in "Username", with: staff.username
    fill_in "Password", with: "supersecretpassword"
    click_on "Sign In"

    click_on "Manage"
    click_on "View All Schools"
    click_on school.name
    within(".classroom") do
      click_on("Delete")
    end
    expect(current_path).to eq(staff_school_path(school))
    expect(page).to_not have_content("Prof. Snape")
  end
end
