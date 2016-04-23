require 'faker'

#create users
10.times do  
  User.create!(
    username: Faker::Internet.user_name,
    email: Faker::Internet.email,
    password: "password"
  )
end
users = User.all

#create wikis
50.times do
  wiki = Wiki.create!(
    title: Faker::Lorem.sentence(4),
    body: Faker::Lorem.paragraph,
    user: users.sample,
    private: Faker::Boolean.boolean
  )
  wiki.update_attribute(:created_at, rand(10.minutes .. 10.days).ago)
end
wikis = Wiki.all


puts "Seeding finished!"
puts "#{users.count} users created."
puts "#{wikis.count} wikis created."
