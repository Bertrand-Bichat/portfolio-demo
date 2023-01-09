# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  online                 :boolean
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  extend Enumerize

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :async, :registerable,
         :recoverable, :rememberable, :validatable

  # Callbacks
  after_commit :shape_data, on: [:create, :update]
  after_create_commit :send_welcome_email

  # Enums
  enumerize :role, in: [:customer, :admin], default: :customer, scope: true

  # Active Storage
  has_one_attached :avatar

  # Validations
  validates :first_name, :last_name, presence: true
  validates :avatar,
            size: { less_than: 2.megabytes, message: 'image de 2 Mo ou moins' },
            content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'], message: 'Veuillez utiliser une image au format PNG, JPG ou JPEG' }

  # Scopes
  default_scope -> { order(id: :asc) }
  scope :with_online_true, -> { where(online: true) }

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def shape_data
    firstname = first_name.strip.downcase.capitalize
    lastname  = last_name.strip.downcase.capitalize
    update_columns(first_name: firstname, last_name: lastname)
  end

  def send_welcome_email
    UserMailer.with(user: self).notification_welcome.deliver_later
  end
end
