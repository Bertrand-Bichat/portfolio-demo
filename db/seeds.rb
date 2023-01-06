require 'faker'

puts 'Creating 10 fake users...'

10.times do
  user = User.new(
    email:       Faker::Internet.email,
    password:    Faker::Internet.password(min_length: 12)
  )
  user.save!
end

puts 'Finished!'
