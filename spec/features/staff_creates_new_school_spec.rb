require 'rails_helper'

RSpec.describe "Staff creates new school" do
  it "they fill out new school form" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)

    visit login_path
    fill_in "Username", with: staff.username
    fill_in "Password", with: "supersecretpassword"
    click_on "Sign In"

    click_on "Manage"
    click_on "Add School"
    fill_in "Name", with: "Hogwarts"
    fill_in "Address", with: "123 Wizard Way"
    click_on "Create School"
    school = School.find_by(name: "Hogwarts")

    expect(current_path).to eq(staff_school_path(school))
    expect(page).to have_content("Hogwarts")
    expect(page).to have_link('Add Classroom')
  end
end
