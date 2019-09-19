require 'rails_helper'

RSpec.describe Address do
  describe "relationships" do
    it {should belong_to :user}
    it {should have_many :orders}
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :nickname }
  end

  # describe 'instance methods' do
  #   it 'has shipped orders' do
  #     user = User.create!(name: 'Leiya', email: 'email@email.com', password: 'password')
  #     address = user.addresses.create!(name: user.name, address: '123 J St', city: 'Denver', state: 'CO', zip: 80210, nickname: 'home')
  #     # binding.pry
  #     order_1 = Order.create!(name: user.name, address: address, status: 'shipped')
  #       item_order_1 = ItemOrder.create!(order: order_1, item: tire, quantity: 2, price: tire.price, user: user, fulfilled?: 1, )
  #     order_2 = Order.create!(user: user, name: user.name, address: address)
  #       item_order_2 = ItemOrder.create!(order: order_1, item: bike, quantity: 5, price: bike.price, user: user, fulfilled?: 0)
  #
  #     expect(address.shipped_orders).to eq([order_1])
  #   end
  # end
end
