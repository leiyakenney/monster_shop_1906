require 'rails_helper'

RSpec.describe "Regular Users" do
  before :each do
    @regular_user = User.create!(name: "George Jungle",
                  address: "1 Jungle Way",
                  city: "Jungleopolis",
                  state: "FL",
                  zipcode: "77652",
                  email: "junglegeorge@email.com",
                  password: "Tree123")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@regular_user)
  end

  it "cannot access merchant or admin paths" do
    visit '/merchant'
    expect(page).to have_content("The page you were looking for doesn't exist.")

    visit admin_path
    expect(page).to have_content("The page you were looking for doesn't exist.")

    visit admin_users_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
