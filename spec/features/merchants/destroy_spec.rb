require 'rails_helper'

RSpec.describe "As an admin user" do
  describe "When I visit a merchant show page" do
    before(:each) do
      admin = create(:user, role: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end

    it "I can delete a merchant" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)

      visit merchants_path

      click_on "Delete"

      expect(current_path).to eq(merchants_path)
      expect(page).to_not have_content("Brian's Bike Shop")
    end

    it "I can delete a merchant that has items" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      visit merchants_path

      click_on "Delete"

      expect(current_path).to eq(merchants_path)
      expect(page).to_not have_content("Brian's Bike Shop")
    end

    it "I can't delete a merchant that has orders" do
      mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      brian = Merchant.create(name: "Brian's Dog Shop", address: '123 Dog Rd.', city: 'Denver', state: 'CO', zip: 80204)

      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      pulltoy = brian.items.create(name: "Pulltoy", description: "It'll never fall apart!", price: 14, image: "https://www.valupets.com/media/catalog/product/cache/1/image/650x/040ec09b1e35df139433887a97daa66f/l/a/large_rubber_dog_pull_toy.jpg", inventory: 7)

      regular_user = User.create!(name: "George Jungle",
                    address: "1 Jungle Way",
                    city: "Jungleopolis",
                    state: "FL",
                    zipcode: "77652",
                    email: "junglegeorge@email.com",
                    password: "Tree123")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(regular_user)


      visit item_path(paper)
      click_on "Add To Cart"
      visit item_path(paper)
      click_on "Add To Cart"
      visit item_path(tire)
      click_on "Add To Cart"
      visit item_path(pencil)
      click_on "Add To Cart"

      visit "/cart"
      click_on "Checkout"

      name = "Bert"
      address = "123 Sesame St."
      city = "NYC"
      state = "New York"
      zip = 10001

      fill_in "Name", with: name
      fill_in "Address", with: address
      fill_in "City", with: city
      fill_in "State", with: state
      fill_in "Zip", with: zip

      click_button "Create Order"

      visit merchants_path
      expect(page).to_not have_link("Delete")
    end
  end
end
