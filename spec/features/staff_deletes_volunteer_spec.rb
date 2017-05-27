require 'rails_helper'

RSpec.describe "Staff deletes a volunteer" do
  it "they delete an existing volunteer" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      active: true,
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    volunteer = User.create(first_name: "Hermione",
                      last_name: "Granger",
                      active: true,
                      username: "hgranger",
                      password: "supersecretpassword",
                      role: 0,
                      language: 0)

    visit root
    fill_in "username", with: staff.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"

    click_on "Manage"
    click_on "View All Volunteers"
    click_on "Hermione Granger"
    click_on "Delete Volunteer"

    expect(current_path).to eq(staff_users_path(staff))
    expect(page).to_not have_content("Hermione")
    expect(page).to_not have_content("Granger")
    expect(page).to have_content("Minerva")
    expect(page).to have_content("McGonagall")
  end
end
