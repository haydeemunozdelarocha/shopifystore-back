# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
products = Product.create([
    {name: 'Wooden Stool', image:'http://bridge49.qodeinteractive.com/wp-content/uploads/2016/07/shop-single-wooden-chair-image-1.jpg',description:'Beautiful wooden stool.', price: 1},
])
