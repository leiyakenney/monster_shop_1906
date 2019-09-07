# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Item.destroy_all
Merchant.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
dunder = Merchant.create(name: "Dunder Mifflin Paper Co", address: '1725 Slough Ave.', city: 'Scranton', state: 'PA', zip: 18501)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

#dunder items
ream = dunder.items.create(name: "Ream of Paper", description: "So much paper!", price: 8, image: "https://dundermifflinpaper.com/wp-content/uploads/2013/06/20190824_185517.jpg", inventory: 174)
dundie = dunder.items.create(name: "Dundie Award", description: "Everyone wants one!", price: 16, image: "https://images-na.ssl-images-amazon.com/images/I/712t-j2WvwL._UX679_.jpg", inventory: 12)

#users
regular_user = User.create!(name: "George Jungle",
              address: "1 Jungle Way",
              city: "Jungleopolis",
              state: "FL",
              zipcode: "77652",
              email: "junglegeorge@email.com",
              password: "Tree123")
merchant_admin = bike_shop.users.create!(name: "Michael Scott",
              address: "1725 Slough Ave",
              city: "Scranton",
              state: "PA",
              zipcode: "18501",
              email: "michael.s@email.com",
              password: "WorldBestBoss",
              role: 2)
merchant_employee = bike_shop.users.create!(name: "Dwight Schrute",
              address: "175 Beet Rd",
              city: "Scranton",
              state: "PA",
              zipcode: "18501",
              email: "dwightkschrute@email.com",
              password: "IdentityTheftIsNotAJoke",
              role: 1)
admin_user = User.create!(name: "Leslie Knope",
              address: "14 Somewhere Ave",
              city: "Pawnee",
              state: "IN",
              zipcode: "18501",
              email: "recoffice@email.com",
              password: "Waffles",
              role: 3)
