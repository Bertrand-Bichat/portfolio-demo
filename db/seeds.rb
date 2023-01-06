require "faker"
require "open-uri"

if Rails.env == "production"

  puts "It's forbidden !"

else

  puts "Delete all database instances..."
  User.destroy_all


  puts "Creating 10 fake customers..."
  10.times do
    user = User.new(
      email:         Faker::Internet.email,
      password:      Faker::Internet.password(min_length: 12),
      first_name:    Faker::Name.first_name,
      last_name:     Faker::Name.last_name
    )
    file = File.open(Rails.root.join('app', 'assets', 'images', 'avatar.jpg'))
    user.avatar.attach(io: file, filename: 'avatar.jpg', content_type: 'image/jpg')
    user.save!
  end

  puts "Creating 2 fake admins..."
  2.times do
    user = User.new(
      email:         Faker::Internet.email,
      password:      Faker::Internet.password(min_length: 12),
      first_name:    Faker::Name.first_name,
      last_name:     Faker::Name.last_name,
      role:          "admin"
    )
    user.save!
  end


  puts "Finished!"
end
