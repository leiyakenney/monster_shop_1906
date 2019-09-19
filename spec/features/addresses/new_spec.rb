require 'rails_helper'

describe "new user creation" do

  describe "when a user registers" do
    before :each do
      @name = "Hank"
      @address = "123 A St"
      @city = "Olympia"
      @state = "WA"
      @zip = 98501
      @email = "hank@email.com"
      @password = "password"
    end

    it "they will still provide an address; this will become their first address entry in the database and will be nicknamed 'home'" do
      visit root_path

      click_link 'Register'

      fill_in 'Name', with: @name
      fill_in 'Address', with: @address
      fill_in 'City', with: @city
      fill_in 'State', with: @state
      fill_in 'Zip', with: @zip
      fill_in 'Email', with: @email
      fill_in 'Password', with: @password
      fill_in 'Password confirmation', with: @password

      click_on 'Submit'

      new_user = User.last
      hank_address = Address.last

      expect(new_user.name).to eq('Hank')
      expect(hank_address.name).to eq(@name)
      expect(hank_address.address).to eq(@address)
      expect(hank_address.city).to eq(@city)
      expect(hank_address.state).to eq(@state)
      expect(hank_address.zip).to eq(@zip)
      expect(hank_address.nickname).to eq('home')
    end
  end
  describe 'crud functionality' do
    before :each do
      @user = User.create!(name: "George Jungle",
                    email: "junglegeorge@email.com",
                    password: "Tree123")
      @address = @user.addresses.create!(name: @user.name, address: "1 Jungle Way",
                    city: "Jungleopolis",
                    state: "FL",
                    zip: "77652",
                    nickname: 'home')
    end

    it "users can create a new address from their profile page" do
      visit login_path

      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_on "Submit"

      expect(current_path).to eq(profile_path)

      expect(page).to have_content("Add Address")
      expect(page).to have_content("Update Address")
      expect(page).to have_content("Delete Address")

      click_link "Add Address"
      expect(current_path).to eq(new_user_address_path(@user))

      visit profile_path(@user)

      within "#user-addresses" do
        click_link "Update Address"
      end

      expect(current_path).to eq(edit_user_address_path(@user,@address))

      visit profile_path(@user)

      within "#user-addresses" do
        click_link "Delete Address"
      end
      expect(current_path).to eq(profile_path)
      expect(page).not_to have_content('home')
    end

  end
end
