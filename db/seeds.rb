# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  email: 'test@test.com',
  user_name: Faker::Name.unique.name,
  account_name: 'いけちゃん',
  user_introduction: "よろしくお願いします",
  is_reception: "true",
  complete_request_count: 0,
  password: "000000"
 )