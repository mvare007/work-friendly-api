# == Schema Information
#
# Table name: social_links
#
#  id          :bigint           not null, primary key
#  platform    :string           not null
#  url         :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :bigint           not null
#
# Indexes
#
#  index_social_links_on_business_id               (business_id)
#  index_social_links_on_business_id_and_platform  (business_id,platform) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#
class SocialLink < ApplicationRecord
  # Associations
  belongs_to :business

  # Validations
  validates :platform, :url, presence: true, length: { maximum: 255 }
  validates :platform, uniqueness: { scope: :business_id }

  # Enums
  # enum platform: { facebook: 0, instagram: 1, twitter: 2, linkedin: 3, youtube: 4, tiktok: 5, pinterest: 6, snapchat: 7,
  #                  whatsapp: 8, telegram: 9, viber: 10, skype: 11, zoom: 12, discord: 13, slack: 14, twitch: 15,
  #                  clubhouse: 16, reddit: 17, tumblr: 18, medium: 19, :business_website: 20, other: 21 }
end
