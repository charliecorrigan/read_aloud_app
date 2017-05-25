require 'rails_helper'

RSpec.describe "Staff creates new volunteer" do
  it "they fill out new volunteer form" do
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")
    class1 = school.classrooms.create(teacher_name: "Prof. Snape", grade_level: "ECE", number_of_students_enrolled: 20)
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      active: true,
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    visit root
    fill_in "username", with: user.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "Manage"
    click_on "Add Volunteer"

    fill_in "first_name", with: "Hermione"
    fill_in "last_name", with: "Granger"
    fill_in "username", with: "hgranger"
    fill_in "password", with: "verysecretpassword"
    choose 'english' #Meant for radio button. If this doesn't work, inspect the element in tools and use element id
    select school.id, :from => "school_select"

    click_on "Next"
    select class1.id, :from => "classroom_select"
    click_on "Create Volunteer"
    volunteer = User.find_by(first_name: "Hermione")

    expect(current_path).to eq(staff_user_path(staff, volunteer))
    expect(page).to have_content("Hermione")
    expect(page).to have_content("Granger")
    expect(page).to have_content("hgranger")
    expect(page).to have_content("Hogwarts")
    expect(page).to have_content("Prof. Snape")
  end
end
