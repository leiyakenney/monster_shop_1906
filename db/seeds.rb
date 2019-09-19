# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ItemOrder.destroy_all
Order.destroy_all
User.destroy_all
Review.destroy_all
Item.destroy_all
Merchant.destroy_all

bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
dunder = Merchant.create(name: "Dunder Mifflin Paper Co", address: '1725 Slough Ave.', city: 'Scranton', state: 'PA', zip: 18501)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
bike = bike_shop.items.create(name: "Red Bike", description: "Oldie, but goodie", price: 200, image: "https://i.pinimg.com/originals/9d/5f/29/9d5f29749894957753a9edd9e2358d8b.png", inventory: 10)
watch = bike_shop.items.create(name: "Watch", description: "It's OK.", price: 40, image: "https://cdn.shopify.com/s/files/1/1666/5401/products/IMG-7040_1024x.JPG?v=1504456880", active?:true, inventory: 0)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

#dunder items
ream = dunder.items.create(name: "Ream of Paper", description: "So much paper!", price: 8, image: "https://mercari-images.global.ssl.fastly.net/photos/m66267444043_1.jpg?1567729247", inventory: 174)
dundie = dunder.items.create(name: "Dundie Award", description: "Everyone wants one!", price: 16, image: "https://images-na.ssl-images-amazon.com/images/I/712t-j2WvwL._UX679_.jpg", inventory: 12)

#tire_reviews
review_1 = tire.reviews.create(title: 'Title 1', content: "This is content for review 1", rating: 1)
review_2 = tire.reviews.create(title: 'Title 2', content: "This is content for review 2", rating: 2)
review_3 = tire.reviews.create(title: 'Title 3', content: "This is content for review 3", rating: 3)
review_4 = tire.reviews.create(title: 'Title 4', content: "This is content for review 4", rating: 1)
review_5 = tire.reviews.create(title: 'Title 5', content: "This is content for review 5", rating: 2)
review_6 = tire.reviews.create(title: 'Title 6', content: "This is content for review 6", rating: 3)

#bike_reviews
review_7 = bike.reviews.create(title: 'Title 1', content: "This is content for review 1", rating: 1)
review_8 = bike.reviews.create(title: 'Title 2', content: "This is content for review 2", rating: 4)
review_9 = bike.reviews.create(title: 'Title 3', content: "This is content for review 3", rating: 5)
review_10 = bike.reviews.create(title: 'Title 4', content: "This is content for review 4", rating: 1)
review_11 = bike.reviews.create(title: 'Title 5', content: "This is content for review 5", rating: 1)
review_12 = bike.reviews.create(title: 'Title 6', content: "This is content for review 6", rating: 1)

#pull_toy_reviews
review_13 = pull_toy.reviews.create(title: 'Title 1', content: "This is content for review 1", rating: 5)
review_14 = pull_toy.reviews.create(title: 'Title 2', content: "This is content for review 2", rating: 2)
review_15 = pull_toy.reviews.create(title: 'Title 3', content: "This is content for review 3", rating: 5)
review_16 = pull_toy.reviews.create(title: 'Title 4', content: "This is content for review 4", rating: 4)
review_17 = pull_toy.reviews.create(title: 'Title 5', content: "This is content for review 5", rating: 5)
review_18 = pull_toy.reviews.create(title: 'Title 6', content: "This is content for review 6", rating: 5)

#bone_reviews
review_19 = dog_bone.reviews.create(title: 'Title 1', content: "This is content for review 1", rating: 5)
review_20 = dog_bone.reviews.create(title: 'Title 2', content: "This is content for review 2", rating: 4)
review_21 = dog_bone.reviews.create(title: 'Title 3', content: "This is content for review 3", rating: 1)
review_22 = dog_bone.reviews.create(title: 'Title 4', content: "This is content for review 4", rating: 3)
review_23 = dog_bone.reviews.create(title: 'Title 5', content: "This is content for review 5", rating: 5)
review_24 = dog_bone.reviews.create(title: 'Title 6', content: "This is content for review 6", rating: 5)

#ream_reviews
review_25 = ream.reviews.create(title: 'Title 1', content: "This is content for review 1", rating: 3)
review_26 = ream.reviews.create(title: 'Title 2', content: "This is content for review 2", rating: 3)
review_27 = ream.reviews.create(title: 'Title 3', content: "This is content for review 3", rating: 3)
review_28 = ream.reviews.create(title: 'Title 4', content: "This is content for review 4", rating: 2)
review_29 = ream.reviews.create(title: 'Title 5', content: "This is content for review 5", rating: 2)
review_30 = ream.reviews.create(title: 'Title 6', content: "This is content for review 6", rating: 2)

#dundie_reviews
review_31 = dundie.reviews.create(title: 'Title 1', content: "This is content for review 1", rating: 3)
review_32 = dundie.reviews.create(title: 'Title 2', content: "This is content for review 2", rating: 3)
review_33 = dundie.reviews.create(title: 'Title 3', content: "This is content for review 3", rating: 4)
review_34 = dundie.reviews.create(title: 'Title 4', content: "This is content for review 4", rating: 5)
review_35 = dundie.reviews.create(title: 'Title 5', content: "This is content for review 5", rating: 6)

#users
regular_user_1 = User.create!(name: "George Jungle",
              email: "junglegeorge@email.com",
              password: "hi")
regular_user_1_address = regular_user_1.addresses.create!(name: regular_user_1.name, address: "1 Jungle Way",
              city: "Jungleopolis",
              state: "FL",
              zip: "77652",
              nickname: 'home')
merchant_employee = User.create!(name: "Dwight Schrute",
              email: "dwightkschrute@email.com",
              password: "hi",
              role: 1,
              merchant: dunder)
merchant_employee_address = merchant_employee.addresses.create!(name: merchant_employee.name, address: "175 Beet Rd",
              city: "Scranton",
              state: "PA",
              zip: "18501",
              nickname: 'home')
merchant_admin = User.create!(name: "Michael Scott",
              email: "michael.s@email.com",
              password: "hi",
              role: 2,
              merchant: dunder)
merchant_admin_address = merchant_admin.addresses.create!(name: merchant_admin.name, address: "1725 Slough Ave",
              city: "Scranton",
              state: "PA",
              zip: "18501",
              nickname: 'home')
admin_user = User.create!(name: "Leslie Knope",
              email: "recoffice@email.com",
              password: "hi",
              role: 3)
admin_user_address = admin_user.addresses.create!(name: admin_user.name, address: "14 Somewhere Ave",
              city: "Pawnee",
              state: "IN",
              zip: "18501",
              nickname: 'home')
