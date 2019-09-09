class User < ApplicationRecord
  has_secure_password

  validates_presence_of :name, :address, :city, :state, :zipcode, :password_digest
  validates :email, presence: true,
  format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
  uniqueness: { case_sensitive: false }
  validates :password, confirmation: true

  has_many :item_orders
  has_many :orders, through: :item_orders
  belongs_to :merchant, optional: true

  enum role: [:regular_user, :merchant_employee, :merchant_admin, :admin_user]

end
