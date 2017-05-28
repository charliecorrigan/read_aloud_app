require 'rails_helper'

RSpec.describe "Staff visits a school page" do
  it "they see all classrooms for that school" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")
    class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
    class2 = school.classrooms.create(teacher_name: "Mr. Firenze", grade_level: "Kindergarten", number_of_students_enrolled: 12)

    visit login_path
    fill_in "Username", with: staff.username
    fill_in "Password", with: "supersecretpassword"
    click_on "Sign In"

    click_on "Manage"
    click_on "View All Schools"
    click_on school.name

    expect(current_path).to eq(staff_school_path(school))
    expect(page).to have_content("Prof. Snape")
    expect(page).to have_content("Mr. Firenze")
  end
end
