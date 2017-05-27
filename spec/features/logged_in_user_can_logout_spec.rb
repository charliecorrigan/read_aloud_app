require 'rails_helper'

RSpec.describe "Logged in user clicks sign out" do
  it "they successfully sign out" do
    user = User.create(first_name: "Hermione",
                      last_name: "Granger",
                      username: "hgranger",
                      password: "supersecretpassword",
                      role: 0,
                      language: 0)
    visit login_path
    fill_in "Username", with: user.username
    fill_in "Password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "Sign Out"

    expect(current_path).to eq(login_path)
    expect(page).to have_button("Sign In")
    expect(page).to_not have_content("Hermione")
  end
end