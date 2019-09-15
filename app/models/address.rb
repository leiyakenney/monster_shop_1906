class Address < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :nickname

  belongs_to :user

end
