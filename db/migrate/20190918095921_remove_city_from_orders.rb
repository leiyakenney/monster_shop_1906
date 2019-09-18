class RemoveCityFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :city, :string
  end
end
