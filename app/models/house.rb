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
  # pg_search
  include PgSearch::Model
  pg_search_scope :search_by_name_and_address,
    against: {
      address: 'A',
      name: 'B'
    },
    using: {
      tsearch: { prefix: true }
    }

  # Geocoder
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # Associations
  belongs_to :user

  # Active Storage
  has_many_attached :photos

  # Action Text
  has_rich_text :description

  # Validations
  validates :name, :address, presence: true
  validates :photos,
            size: { less_than: 1.megabytes, message: 'images de 1 Mo chacune ou moins' },
            limit: { min: 0, max: 10, message: '10 images maximum' },
            content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'], message: 'Veuillez utiliser des images PNG, JPG ou JPEG' }

  # Scopes
  default_scope -> { order(name: :asc) }

  # Callbacks
  after_commit :broadcast_data

  def display_data
    "#{name} - #{address} [#{latitude}, #{longitude}]"
  end

  def user_full_name
    user.full_name
  end

  private

  def broadcast_data
    index_data = HousesController.renderer.render(partial: 'houses/index', locals: { houses: user.houses, user: user })
    house_data = { house: self, user: user, index_data: index_data }
    ActionCable.server.broadcast("houses_from_user_#{user.id}", house_data)
  end
end
