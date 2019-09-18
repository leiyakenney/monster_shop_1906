class RemoveStateFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :state, :string
  end
end
