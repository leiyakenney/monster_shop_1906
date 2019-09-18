require 'rails_helper'

RSpec.describe "Registering User" do
  it "creates new user" do
    visit "/register"

    user_name = "Larry Pug"
    user_address = "123 Sesame St"
    user_city = "Denver"
    user_state = "CO"
    user_zipcode = "80222"
    user_email = "larrypug@email.com"
    user_password = "password123"
    user_confirm_password = "password123"

    fill_in "Name", with: user_name
    fill_in "Address", with: user_address
    fill_in "City", with: user_city
    fill_in "State", with: user_state
    fill_in "Zip", with: user_zipcode
    fill_in "Email", with: user_email
    fill_in "Password", with: user_password
    fill_in "Password confirmation", with: user_confirm_password

    click_on "Submit"

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Welcome #{user_name}! You are now registered and logged in.")
    expect(page).to have_content("Hello, #{user_name}!")
    expect(page).to_not have_link("Login")
    expect(page).to_not have_link("Register")
  end

  it "when I visit the user registration page and do not fill in the form completely, I am returned to the registration page and see a flash message that I am missing required fields" do

    visit "/register"

    click_on "Submit"

    expect(current_path).to eq("/register")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Address can't be blank")
    expect(page).to have_content("City can't be blank")
    expect(page).to have_content("State can't be blank")
    expect(page).to have_content("Zipcode can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Email is invalid")
    expect(page).to have_content("Password can't be blank")
  end

  it "confirms passwords match" do
    visit "/register"

    user_name = "Larry Pug"
    user_address = "123 Sesame St"
    user_city = "Denver"
    user_state = "CO"
    user_zipcode = "80222"
    user_email = "larrypug@email.com"
    user_password = "password123"
    user_confirm_password = "password456"

    fill_in "Name", with: user_name
    fill_in "Address", with: user_address
    fill_in "City", with: user_city
    fill_in "State", with: user_state
    fill_in "Zipcode", with: user_zipcode
    fill_in "Email", with: user_email
    fill_in "Password", with: user_password
    fill_in "Password confirmation", with: user_confirm_password

    click_on "Submit"

    expect(page).to have_content("Password confirmation doesn't match")
  end

  it "doesn't allow duplicate email registrations and returns me to the registration page with a filled-out form, without saving my details and I see a flash message saying that email is already in use" do

    regular_user = User.create!(name: "George Jungle",
                  address: "1 Jungle Way",
                  city: "Jungleopolis",
                  state: "FL",
                  zipcode: "77652",
                  email: "junglegeorge@email.com",
                  password: "Tree123")

    visit "/register"

    fill_in "Name", with: "George Jungle"
    fill_in "Address", with: "1 Jungle Way"
    fill_in "City", with: "Jungleopolis"
    fill_in "State", with: "FL"
    fill_in "Zipcode", with: "77652"
    fill_in "Email", with: "junglegeorge@email.com"
    fill_in "Password", with: "Tree123"
    fill_in "Password confirmation", with: "Tree123"

    click_on "Submit"

    expect(page).to have_content("Email has already been taken")

    expect(find_field('Name').value).to eq "George Jungle"
    expect(find_field('Address').value).to eq "1 Jungle Way"
    expect(find_field('City').value).to eq "Jungleopolis"
    expect(find_field('State').value).to eq "FL"
    expect(find_field('Zipcode').value).to eq "77652"
    expect(find_field('Email').value).to eq nil
    expect(find_field('Password').value).to eq nil
  end
end
