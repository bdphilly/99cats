# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.create(:name => "Tabby", :age => 4, :color => "brown", :sex => "F", :birth_date => (Time.new))
Cat.create(:name => "Paws", :age => 3, :color => "black", :sex => "F", :birth_date => (Time.new))
Cat.create(:name => "Pink", :age => 2, :color => "blue", :sex => "M", :birth_date => (Time.new))
Cat.create(:name => "Snowball", :age => 1, :color => "white", :sex => "M", :birth_date => (Time.new))

CatRentalRequest.create(cat_id: 2, start_date: Time.new(2012, 12, 12), end_date: Time.new(2012, 12, 20), status: "APPROVED")
CatRentalRequest.create(cat_id: 2, start_date: Time.new(2012, 12, 19), end_date: Time.new(2012, 12, 23))
CatRentalRequest.create(cat_id: 3, start_date: Time.new(2012, 10, 12), end_date: Time.new(2010, 12, 20))



# t.integer  "cat_id",     null: false
# t.date     "start_date", null: false
# t.date     "end_date",   null: false
# t.string   "status",     null: false
