# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Movie.destroy_all
Reaction.destroy_all
user1 = User.create(username: 'Nikos Kalogeropoulos', password: '123456')
user2 = User.create(username: 'Petros Kalogeropoulos', password: '123456')
user3 = User.create(username: 'Nikos Papadopoulos', password: '123456')

movie1 = Movie.create(title: 'Lord of the Rings', description: 'One of the best movies of our time', user_id: user1.id)
movie2 = Movie.create(title: 'Lord of the Rings 2', description: 'One of the best movies of our time', user_id: user2.id)
movie3 = Movie.create(title: 'Lord of the Rings 3', description: 'One of the best movies of our time', user_id: user3.id)

reaction1 = Reaction.create(ttype: "LIKE", user_id: user1.id, movie_id: movie3.id)
reaction2 = Reaction.create(ttype: "HATE", user_id: user1.id, movie_id: movie2.id)
reaction3 = Reaction.create(ttype: "LIKE", user_id: user2.id, movie_id: movie3.id)
reaction4 = Reaction.create(ttype: "LIKE", user_id: user2.id, movie_id: movie1.id)
reaction5 = Reaction.create(ttype: "LIKE", user_id: user3.id, movie_id: movie1.id)
reaction6 = Reaction.create(ttype: "HATE", user_id: user3.id, movie_id: movie2.id)
