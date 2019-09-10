require 'rails_helper'

RSpec.describe "Admin Dashboard page" do
  before :each do
    @regular_user_1 = create(:user, name: "Regular User 1")
    @regular_user_2 = create(:user, name: "Regular User 2")

    @merchant_shop_1 = create(:merchant, name: "Merchant Shop 1")
      @item_1 = @merchant_shop_1.items.create!(attributes_for(:item, name: "Item 1", inventory: 10))
      @item_2 = @merchant_shop_1.items.create!(attributes_for(:item, name: "Item 2", inventory: 15))
      @item_5 = @merchant_shop_1.items.create!(attributes_for(:item, name: "Item 5", inventory: 0))

    @merchant_shop_2 = create(:merchant, name: "Merchant Shop 2")
      @item_3 = @merchant_shop_2.items.create!(attributes_for(:item, name: "Item 3", inventory: 20))
      @item_4 = @merchant_shop_2.items.create!(attributes_for(:item, name: "Item 4", inventory: 10))

    @order_1 = create(:order, name: "Matt", status: 1)
      @item_order_1 = @regular_user_1.item_orders.create!(order: @order_1, item: @item_1, quantity: 2, price: @item_1.price, user: @regular_user_1, fulfilled?: false)
      @item_order_2 = @regular_user_1.item_orders.create!(order: @order_1, item: @item_2, quantity: 8, price: @item_2.price, user: @regular_user_1, fulfilled?: false)
      @item_order_3 = @regular_user_1.item_orders.create!(order: @order_1, item: @item_3, quantity: 10, price: @item_3.price, user: @regular_user_1, fulfilled?: false)

    @order_2 = create(:order, name: "Amy", status: 0)
      @item_order_4 = @regular_user_2.item_orders.create(order: @order_2, item: @item_2, quantity: 100, price: @item_2.price, user: @regular_user_1, fulfilled?: true)

    @order_3 = create(:order, name: "Beth", status: 2)
      @item_order_5 = @regular_user_2.item_orders.create(order: @order_3, item: @item_4, quantity: 18, price: @item_4.price, user: @regular_user_1, fulfilled?: true)

    @order_4 = create(:order, name: "Adam", status: 3)
      @item_order_6 = @regular_user_1.item_orders.create(order: @order_4, item: @item_5, quantity: 15, price: @item_5.price, user: @regular_user_1, fulfilled?: true)

    @order_5 = create(:order, name: "Sam", status: 1)
      @item_order_7 = @regular_user_1.item_orders.create(order: @order_5, item: @item_1, quantity: 15, price: @item_1.price, user: @regular_user_1, fulfilled?: true)

    @order_6 = create(:order, name: "Jim", status: 0)
      @item_order_8 = @regular_user_2.item_orders.create(order: @order_6, item: @item_3, quantity: 10, price: @item_3.price, user: @regular_user_1, fulfilled?: true)

    @admin_1 = create(:user, name: "Admin 1", role: 3)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_1)
  end

  it 'can show all orders sorted by status' do

    visit admin_path

    # save_and_open_page

    within "#orders-#{@order_1.id}-3" do
      expect(page).to have_content(@regular_user_1.name)
      expect(page).to have_content(@order_1.id)
      expect(page).to have_content(@order_1.created_at)
      expect(page).to have_content("pending")
    end

    within "#orders-#{@order_5.id}-4" do
      expect(page).to have_content(@regular_user_1.name)
      expect(page).to have_content(@order_5.id)
      expect(page).to have_content(@order_5.created_at)
      expect(page).to have_content("pending")
    end

    within "#orders-#{@order_2.id}-1" do
      expect(page).to have_content(@regular_user_2.name)
      expect(page).to have_content(@order_2.id)
      expect(page).to have_content(@order_2.created_at)
      expect(page).to have_content("packaged")
    end

    within "#orders-#{@order_6.id}-2" do
      expect(page).to have_content(@regular_user_2.name)
      expect(page).to have_content(@order_6.id)
      expect(page).to have_content(@order_6.created_at)
      expect(page).to have_content("packaged")
    end

    within "#orders-#{@order_3.id}-5" do
      expect(page).to have_content(@regular_user_2.name)
      expect(page).to have_content(@order_3.id)
      expect(page).to have_content(@order_3.created_at)
      expect(page).to have_content("shipped")
    end

    within "#orders-#{@order_4.id}-6" do
      expect(page).to have_content(@regular_user_1.name)
      expect(page).to have_content(@order_4.id)
      expect(page).to have_content(@order_4.created_at)
      expect(page).to have_content("cancelled")
    end
  end

  it 'packaged orders have a button to ship' do

    visit admin_path

    within "#orders-#{@order_2.id}-1" do
      expect(page).to have_content("packaged")
      expect(page).to have_link("Ship Item")
    end

    within "#orders-#{@order_6.id}-2" do
      expect(page).to have_content("packaged")
      expect(page).to have_link("Ship Item")
    end

    within "#orders-#{@order_4.id}-6" do
      expect(page).to have_content("cancelled")
      expect(page).not_to have_link("Ship Item")
      expect(page).to have_content("No Action Available")
    end
  end
end
