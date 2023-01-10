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
      last_name:     Faker::Name.last_name,
      pseudo:        Faker::Internet.slug
    )
    file = File.open(Rails.root.join('app', 'assets', 'images', 'empty-avatar.png'))
    user.avatar.attach(io: file, filename: 'empty-avatar.png', content_type: 'image/png')
    user.save!
  end

  puts "Creating 2 fake admins..."
  2.times do
    user = User.new(
      email:         Faker::Internet.email,
      password:      Faker::Internet.password(min_length: 12),
      first_name:    Faker::Name.first_name,
      last_name:     Faker::Name.last_name,
      role:          "admin",
      pseudo:        Faker::Internet.slug
    )
    file = File.open(Rails.root.join('app', 'assets', 'images', 'empty-avatar.png'))
    user.avatar.attach(io: file, filename: 'empty-avatar.png', content_type: 'image/png')
    user.save!
  end

  puts "Creating 1 admin..."
  user = User.new(
    email:         "test@gmail.com",
    password:      "password",
    first_name:    "Bertrand",
    last_name:     "Bichat",
    role:          "admin",
    pseudo:        "BBichat"
  )
  file = File.open(Rails.root.join('app', 'assets', 'images', 'avatar.jpg'))
  user.avatar.attach(io: file, filename: 'avatar.jpg', content_type: 'image/jpg')
  user.save!


  puts "Finished!"
end
