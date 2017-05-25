require 'rails_helper'

RSpec.describe "Staff visits single school" do
  it "they see school info" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      active: true,
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")

    visit root
    fill_in "username", with: user.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"

    click_on "Manage"
    click_on "View Schools"
    click_on "Hogwarts"

    expect(current_path).to eq(school_path(school))
    expect(page).to have_content("123 Wizard Way")
    expect(page).to have_content("Hogwarts")
  end
end
