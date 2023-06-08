# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address                :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  last_name              :string           not null
#  phone_number           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  status                 :integer          default("0"), not null
#  zip_code               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  city_id                :bigint           not null
#
# Indexes
#
#  index_users_on_city_id               (city_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  # Enums
  enum status: { active: 0, inactive: 1, suspended: 2 }

  # Filters
  self.filter_attributes = %i[encrypted_password reset_password_token] unless Rails.env.development?

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
  validates :address, :zip_code, length: { maximum: 255 }

  def full_name = "#{first_name} #{last_name}"

  def self.authenticate(email, password)
    user = User.find_for_authentication(email:)
    user&.valid_password?(password) ? user : nil
  end

  ##
  # Revokes all access tokens for a specific client app and user using Doorkeeper.
  #
  # Args:
  # client_app<Doorkeeper::Application>: The parameter `client_app` is an object representing a client application that
  # has been authorized to access a user's resources through an access token. It is used to identify the
  # client application for which all access tokens should be revoked.
  def revoke_access_token!(client_app)
    Doorkeeper::AccessToken.revoke_all_for(client_app.id, self)
  end
end
