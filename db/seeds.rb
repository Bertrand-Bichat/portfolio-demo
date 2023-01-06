require 'faker'

puts 'Creating 10 fake users...'

10.times do
  user = User.new(
    email:    Faker::Company.name,
    password:    Faker::Company.name
  )
  user.save!
end

puts 'Finished!'
