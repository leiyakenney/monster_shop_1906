require 'rails_helper'

describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :status }
  end

  describe "relationships" do
    it {should have_many :item_orders}
    it {should have_many(:items).through(:item_orders)}
  end

  describe 'instance methods' do
    before :each do
      @user = create(:user)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 0)
        @item_order_1 = @user.item_orders.create!(order: @order_1, item: @tire, price: @tire.price, quantity: 2, fulfilled?: true)
        @item_order_2 = @user.item_orders.create!(order: @order_1, item: @pull_toy, price: @pull_toy.price, quantity: 3, fulfilled?: true)

      @order_2 = create(:order, name: "Jill", status: 1)
        @item_order_3 = @user.item_orders.create(order: @order_2, item: @tire, quantity: 100, price: @tire.price, fulfilled?: true)

      @order_3 = create(:order, name: "Sam", status: 3)
        @item_order_4 = @user.item_orders.create(order: @order_3, item: @pull_toy, quantity: 18, price: @pull_toy.price, fulfilled?: true)

      @order_4 = create(:order, name: "Jane", status: 2)
        @item_order_5 = @user.item_orders.create(order: @order_4, item: @tire, quantity: 15, price: @tire.price, fulfilled?: true)
    end

    it 'grandtotal' do
      expect(@order_1.grandtotal).to eq(230)
    end

    it 'total_items' do
      expect(@order_1.total_items).to eq(5)
    end

    it 'to_s' do
      expect(@order_1.to_s).to eq("Meg\n    123 Stang Ave\n    Hershey, PA\n    17033\n    ")
    end

    it 'update_status' do
      expect(@order_1.update_status).to eq(true)
    end

    it 'sort_by_status' do
      expected = [@order_1, @order_2, @order_4, @order_3,]

      expect(Order.sort_by_status).to eq(expected)
    end

    it 'cancels orders' do
      @order_1.cancel_order

      @order_1.item_orders.each do |item_order|
        expect(item_order.fulfilled?).to eq(false)
      end
    end
  end
end
