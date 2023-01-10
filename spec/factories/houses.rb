# == Schema Information
#
# Table name: houses
#
#  id         :bigint           not null, primary key
#  address    :string
#  latitude   :float
#  longitude  :float
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_houses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :house do
    name { "MyString" }
    address { "MyString" }
    longitude { 1.5 }
    latitude { 1.5 }
    association :user
  end
end
