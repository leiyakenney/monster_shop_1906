class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :CreateAddresses
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.string :nickname

      t.timestamps
    end
  end
end
