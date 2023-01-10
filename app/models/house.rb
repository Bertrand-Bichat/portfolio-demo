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
class House < ApplicationRecord
  # Geocoder
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # Associations
  belongs_to :user

  # Active Storage
  has_many_attached :photos

  # Validations
  validates :name, :address, presence: true
  validates :photos,
            size: { less_than: 1.megabytes, message: 'images de 1 Mo chacune ou moins' },
            limit: { min: 0, max: 10, message: '10 images maximum' },
            content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'], message: 'Veuillez utiliser des images PNG, JPG ou JPEG' }
end
