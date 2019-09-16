class RemoveZipcodeFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :zipcode, :string
  end
end
