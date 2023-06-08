# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  address      :string
#  email        :string           not null
#  first_name   :string           not null
#  last_login   :datetime
#  last_name    :string           not null
#  phone_number :string
#  status       :integer          default("0"), not null
#  zip_code     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  city_id      :bigint           not null
#
# Indexes
#
#  index_users_on_city_id  (city_id)
#  index_users_on_email    (email) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enums
  enum status: { active: 0, inactive: 1, suspended: 2 }

  # Filters
  self.filter_attributes = %i[email payment_info] unless Rails.env.development?

  # Associations
  belongs_to :city
  has_many :reviews, dependent: :restrict_with_error
  has_many :bookings, dependent: :restrict_with_error
  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  # Validations
  validates :first_name, :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
  validates :password_digest, presence: true, length: { maximum: 255 }
  validates :address, :zip_code, :phone_number, length: { maximum: 255 }
  validates :payment_info, length: { maximum: 255 }

  def full_name = "#{first_name} #{last_name}"

  def self.authenticate(email, password)
    user = User.find_for_authentication(email:)
    user&.valid_password?(password) ? user : nil
  end

  ##
  # This Ruby function revokes all access tokens for a specific client app and user using Doorkeeper.
  #
  # Args:
  # client_app<Doorkeeper::Application>: The parameter `client_app` is an object representing a client application that
  # has been authorized to access a user's resources through an access token. It is used to identify the
  # client application for which all access tokens should be revoked.
  def revoke_access_token!(client_app)
    Doorkeeper::AccessToken.revoke_all_for(client_app.id, self)
  end
end
