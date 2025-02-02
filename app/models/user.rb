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
class User < ApplicationRecord
  extend Enumerize
  extend FriendlyId
  friendly_id :pseudo, use: [:slugged, :finders]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :async, :registerable,
         :recoverable, :rememberable, :validatable

  # Enums
  enumerize :role, in: [:customer, :admin], default: :customer, scope: true
  enumerize :welcome_email, in: [:not_sent, :processed, :delivered, :opened, :clicked, :bounced], default: :not_sent, scope: true

  # Associations
  has_many :houses, dependent: :destroy

  # Active Storage
  has_one_attached :avatar

  # Validations
  validates :first_name, :last_name, :pseudo, presence: true
  validates :pseudo, uniqueness: true
  validates :avatar,
            size: { less_than: 2.megabytes, message: 'image de 2 Mo ou moins' },
            content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'], message: 'Veuillez utiliser une image au format PNG, JPG ou JPEG' }

  # Scopes
  # default_scope -> { order(id: :asc) }
  scope :with_online_true, -> { where(online: true) }

  # Callbacks
  after_commit :shape_data, on: [:create, :update]
  after_commit :send_welcome_email, on: :create

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def shape_data
    return if first_name.nil? || last_name.nil?

    firstname = first_name.strip.downcase.capitalize
    lastname  = last_name.strip.downcase.capitalize
    update_columns(first_name: firstname, last_name: lastname)
  end

  def send_welcome_email
    UserMailer.with(user: self).notification_welcome.deliver_later
  end
end
