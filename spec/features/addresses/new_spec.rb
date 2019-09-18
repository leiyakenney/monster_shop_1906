require 'rails_helper'

describe "new user creation" do
  before :each do
    @name = "Hank"
    @address = "123 A St"
    @city = "Olympia"
    @state = "WA"
    @zip = 98501
    @email = "hank@email.com"
    @password = "password"
  end

  describe "when a user registers" do
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

end
