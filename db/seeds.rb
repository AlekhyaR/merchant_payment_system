# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'Faker'

# creates merchant users with status active
(1..5).each do |id|
  User.create!(
    id: id,
    name: Faker::Name.name,
    email: Faker::Internet.email,
    encrypted_password: "merchant_user123",
    role: 0,
    status: 0

  )
end
# creates merchant users with status inactive
(6..8).each do |id|
  User.create!(
    id: id,
    name: Faker::Name.name,
    email: Faker::Internet.email,
    encrypted_password: "merchant_user123",
    role: 0,
    status: 1
  )
end
# creates admin users with status active
(9..13).each do |id|
  User.create!(
    id: id,
    name: Faker::Name.name,
    email: Faker::Internet.email,
    encrypted_password: "admin_user123",
    role: 1,
    status: 0
  )
end
# creates admin users with status inactive
(14..16).each do |id|
  User.create!(
    id: id,
    name: Faker::Name.name,
    email: Faker::Internet.email,
    encrypted_password: "admin_user123",
    role: 1,
    status: 1
  )
end
