class Address < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  validates :nickname, presence: true, uniqueness: { scope: :user_id}

  belongs_to :user
  has_many :orders

  def shipped_orders
    orders.where(status: 'shipped')
  end

  def no_orders?
    orders.empty?
  end

end
