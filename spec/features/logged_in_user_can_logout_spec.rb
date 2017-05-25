require 'rails_helper'

RSpec.describe "Logged in user clicks sign out" do
  it "they successfully sign out" do
    user = User.create(first_name: "Hermione",
                      last_name: "Granger",
                      active: true,
                      username: "hgranger",
                      password: "supersecretpassword",
                      role: 0,
                      language: 0)
    visit root
    fill_in "username", with: user.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "Sign Out"

    expect(current_path).to eq(root)
    expect(page).to have_content("Sign In")
    expect(page).to_not have_content("Hermione")
  end
end