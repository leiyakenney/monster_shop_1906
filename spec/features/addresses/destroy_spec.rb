require 'rails_helper'

RSpec.describe "cannot destroy a shipped order address" do
  describe "doesn't destroy an address that's been shipped to" do
    before :each do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

      @user = User.create!(name: "George Jungle",
                    email: "junglegeorge@email.com",
                    password: "Tree123")

      @address = @user.addresses.create!(name: @user.name, address: '123 J St', city: 'Denver', state: 'CO', zip: 80210, nickname: 'home')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @order = Order.create(name: "John", address_id: @user.addresses.first.id, status: 'shipped')
        item_order_1 = ItemOrder.create(order: @order, item: @tire, quantity: 12, price: @tire.price, user: @user)
        item_order_2 = ItemOrder.create(order: @order, item: @paper, quantity: 3, price: @paper.price, user: @user)

    end

    it "shouldn't delete an address with a shipped order" do
      visit profile_path

      expect(page).to have_content(@address.address)

      click_on "Delete Address"
      expect(page).to have_content('Address cannot be deleted at this time.')
    end
  end
end
