require 'rails_helper'

RSpec.describe 'Cart show' do
  describe 'When I have added items to my cart' do
    before(:each) do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @regular_user = User.create!(name: "George Jungle",
                    email: "junglegeorge@email.com",
                    password: "Tree123")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@regular_user)


      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      visit item_path(@paper)
      click_on "Add To Cart"
      visit item_path(@tire)
      click_on "Add To Cart"
      visit item_path(@pencil)
      click_on "Add To Cart"
      @items_in_cart = [@paper,@tire,@pencil]
    end

    it 'Theres a link to checkout' do
      visit "/cart"

      expect(page).to have_link("Checkout")

      click_on "Checkout"

      expect(current_path).to eq('/profile/orders/new')
    end
  end

  describe 'When I havent added items to my cart' do
    it 'There is not a link to checkout' do
      visit "/cart"

      expect(page).to_not have_link("Checkout")
    end
  end

  describe 'When a user checks out' do
    before :each do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

      @user = User.create!(name: "George Jungle",
                    email: "junglegeorge@email.com",
                    password: "Tree123")

      @address_1 = @user.addresses.create!(name: @user.name, address: '123 J St', city: 'Denver', state: 'CO', zip: 80210, nickname: 'home')

      @address_2 = @user.addresses.create!(name: @user.name, address: '836 B St', city: 'Denver', state: 'CO', zip: 80216, nickname: 'work')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "they have the option to choose the shipping address" do
      visit item_path(@paper)
      click_on "Add To Cart"
      visit cart_path
      click_link "Checkout"

      expect(current_path).to eq(profile_orders_new_path)

      expect(page).to have_content("Shipping Address:")
      select "home", from: :address
      select "work", from: :address
    end

  end

  describe 'When a user checks out' do
    before :each do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

      @user = User.create!(name: "George Jungle",
                    email: "junglegeorge@email.com",
                    password: "Tree123")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "shows an error message when a person tries to check out without having any addresses" do
      visit item_path(@paper)
      click_on "Add To Cart"
      visit cart_path
      click_link "Checkout"

      expect(page).to have_content("Please add an address to continue checking out")
      expect(page).to have_link("add an address")

      click_link "add an address"

      expect(current_path).to eq(new_user_address_path(@user))
    end
  end
end
