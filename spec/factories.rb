FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.safe_email }
    password { Faker::Lorem.word }
  end

  factory :order do
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
  end

  factory :item do
    name { Faker::Name.name }
    description { Faker::Lorem.word }
    price { Faker::Number.decimal(l_digits: 2) }
    image { Faker::LoremFlickr.image(size: "50x60") }
    inventory { Faker::Number.between(from: 1, to: 100) }
  end

  factory :merchant do
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
  end

  factory :address do
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
  end
end
