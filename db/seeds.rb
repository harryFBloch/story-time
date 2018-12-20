# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(username: "HFB", email: "h@h.com", password: "123")
user.save
post = Post.new(title: "Christmans", image_url: "https://image.shutterstock.com/image-photo/this-decorated-outdoor-snow-covered-450w-163973654.jpg")
post.user = user
binding.pry
sentance = Sentance.new(content: "nice tree in the snow")
sentance.user = user
post.sentances << sentance
genre = Genre.new(name: "Holiday")
post.genre = genre
comment = Comment.new(content: "I love this story !!!!")
comment.user = user
post.comments << comment

post.save
