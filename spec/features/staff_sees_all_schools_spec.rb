require 'rails_helper'

RSpec.describe "Staff visits schools index" do
  it "they see all schools" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")

    visit login_path
    fill_in "Username", with: staff.username
    fill_in "Password", with: "supersecretpassword"
    click_on "Sign In"

    click_on "Manage"
    click_on "View All Schools"

    expect(current_path).to eq(staff_schools_path)
    expect(page).to have_content("123 Wizard Way")
    expect(page).to have_content("Hogwarts")
  end
end
