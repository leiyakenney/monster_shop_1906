require 'rails_helper'

RSpec.describe "User Login" do
  before :each do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop",
                address: '123 Bike Rd.',
                city: 'Richmond',
                state: 'VA',
                zip: 23137)
    @regular_user = User.create!(name: "George Jungle",
                  address: "1 Jungle Way",
                  city: "Jungleopolis",
                  state: "FL",
                  zipcode: "77652",
                  email: "junglegeorge@email.com",
                  password: "Tree123")
    @merchant_employee = @bike_shop.users.create!(name: "Dwight Schrute",
                  address: "175 Beet Rd",
                  city: "Scranton",
                  state: "PA",
                  zipcode: "18501",
                  email: "dwightkschrute@email.com",
                  password: "IdentityTheftIsNotAJoke",
                  role: 1)
    @merchant_user = @bike_shop.users.create!(name: "Michael Scott",
                  address: "1725 Slough Ave",
                  city: "Scranton",
                  state: "PA",
                  zipcode: "18501",
                  email: "michael.s@email.com",
                  password: "WorldBestBoss",
                  role: 2)
    @admin_user = User.create!(name: "Leslie Knope",
                  address: "14 Somewhere Ave",
                  city: "Pawnee",
                  state: "IN",
                  zipcode: "18501",
                  email: "recoffice@email.com",
                  password: "Waffles",
                  role: 3)
  end

  it "can log in a regular user" do
    visit "/login"

    fill_in :email, with: @regular_user.email
    fill_in :password, with: @regular_user.password

    click_button "Submit"

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Logged in as #{@regular_user.name}")

    visit "/login"

    expect(current_path).to eq("/profile")
    expect(page).to have_content("You are already logged in")
  end

  it "can log in a merchant employee" do
    visit "/login"

    fill_in :email, with: @merchant_employee.email
    fill_in :password, with: @merchant_employee.password

    click_button "Submit"

    expect(current_path).to eq("/merchant")
    expect(page).to have_content("Logged in as #{@merchant_employee.name}")

    visit "/login"

    expect(current_path).to eq("/merchant")
    expect(page).to have_content("You are already logged in")
  end

  it "can log in a merchant user" do
    visit "/login"

    fill_in :email, with: @merchant_user.email
    fill_in :password, with: @merchant_user.password

    click_button "Submit"

    expect(current_path).to eq("/merchant")
    expect(page).to have_content("Logged in as #{@merchant_user.name}")

    visit "/login"

    expect(current_path).to eq("/merchant")
    expect(page).to have_content("You are already logged in")
  end

  it "can log in an admin user" do
    visit "/login"

    fill_in :email, with: @admin_user.email
    fill_in :password, with: @admin_user.password

    click_button "Submit"

    expect(current_path).to eq("/admin")
    expect(page).to have_content("Logged in as #{@admin_user.name}")

    visit "/login"

    expect(current_path).to eq("/admin")
    expect(page).to have_content("You are already logged in")
  end

  it "displays a flash message for invalid entries" do
    visit "/login"

    fill_in :email, with: @admin_user.email
    fill_in :password, with: "Gibberish"

    click_button "Submit"

    expect(current_path).to eq("/login")
    expect(page).to have_content("Please enter valid user information")

    visit "/login"

    fill_in :email, with: ""
    fill_in :password, with: @merchant_user.password

    click_button "Submit"

    expect(current_path).to eq("/login")
    expect(page).to have_content("Please enter valid user information")
  end

  describe "When a regular user tries to access merchant or admin path" do
    it "should respond with 404 page" do
      visit "/login"

      fill_in :email, with: @regular_user.email
      fill_in :password, with: @regular_user.password

      click_button "Submit"

      visit '/merchant'
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit admin_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  describe "Visitor has items in cart and views cart show page" do
    it 'vistor prompted to either register or login to continue checkout process if cart has items' do

      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      cart = Cart.new({chain.id.to_s => 2})
      allow_any_instance_of(ApplicationController).to receive(:cart).and_return(cart)

      visit "/cart"

      expect(page).to have_content("Please register or login to continue your checkout process")
      expect(page).to have_link("Register")
      expect(page).to have_link("Login")
      expect(page).to_not have_button("Checkout")
    end

    it 'visit is not prompted to sign in on cart page if they have no items' do
      visit "/cart"

      expect(page).to have_content("Cart is currently empty")
    end
  end
end
