# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  banned                 :boolean          default(FALSE), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  online                 :boolean
#  pseudo                 :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  slug                   :string
#  welcome_email          :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug) UNIQUE
#
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6, max_length: 128) }
    online { false }
    welcome_email { "not_sent" }
    pseudo { Faker::Internet.slug }
    banned { false }
    trait :with_customer_role do
      role { "customer" }
    end
    trait :with_admin_role do
      role { "admin" }
    end
  end
end
