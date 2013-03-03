# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [
  { username: 'Foo',
    email: '1@example.com'},
  { username: 'Bar',
    email: '2@example.com'},
  { username: 'Foobar',
    email: '3@example.com'}]

users.each do |user|
  User.create!(user.merge(password: 'password', password_confirmation: 'password'))
end