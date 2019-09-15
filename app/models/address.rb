class Address < ApplicationRecord
  validates_presence_of :name, :street, :city, :state, :zip, :nickname

  belongs_to :user

end
