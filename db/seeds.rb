# Doorkeeper
if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create(name: 'Web Client', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create(name: 'Android Client', redirect_uri: '', scopes: '')
end

############### COUNTRIES & CITIES ######################
Countries::SyncService.call

############### BUSINESS TYPES ######################
%w[
  Cafe
  Restaurant
  Hotel
  Bar
  Other
].each do |name|
  BusinessType.find_or_create_by!(name:)
end

############### FACILITY AMENITY CATEGORIES ######################
%w[
  Productivity
  Service
  Space
  Community
  Storage
  Accessibility
  Payment
  Other
].each do |name|
  FacilityAmenityCategory.find_or_create_by!(name:)
end

############### FACILITY AMENITIES ######################
[
  'Quiet',
  'Long Stays',
  'Conference Facilities',
  'Meeting Facilities',
  'Whiteboards or Flipcharts'
].each do |name|
  facility_amenity_category = FacilityAmenityCategory.find_by!(name: 'Productivity')
  FacilityAmenity.find_or_create_by!(name:, facility_amenity_category:)
end

[
  'Coffee',
  'Tea',
  'Drinks',
  'Food',
  'Snacks',
  'Vegan Food',
  'Gluten Free Food',
  'Organic Food',
  'Cocktails',
  'Happy Hour',
  'Live Music',
  'Video Games',
  'Pool Table',
  'Ping Pong',
  'Darts',
  'Pinball',
  'Air Hockey'
].each do |name|
  facility_amenity_category = FacilityAmenityCategory.find_by!(name: 'Service')
  FacilityAmenity.find_or_create_by!(name:, facility_amenity_category:)
end

[
  'Air Conditioning',
  'Heating',
  'Natural Light',
  'Spacious',
  'Outdoor Seating',
  'Dog Friendly',
  'Family Friendly',
  'Smoking Area',
  'Outdoor Terrace'
].each do |name|
  facility_amenity_category = FacilityAmenityCategory.find_by!(name: 'Space')
  FacilityAmenity.find_or_create_by!(name:, facility_amenity_category:)
end

[
  'Group Tables',
  'Networking Events'
].each do |name|
  facility_amenity_category = FacilityAmenityCategory.find_by!(name: 'Community')
  FacilityAmenity.find_or_create_by!(name:, facility_amenity_category:)
end

[
  'Locker Storage',
  'Bike Storage'

].each do |name|
  facility_amenity_category = FacilityAmenityCategory.find_by!(name: 'Storage')
  FacilityAmenity.find_or_create_by!(name:, facility_amenity_category:)
end

[
  'Credit Card',
  'Apple Pay',
  'Google Pay',
  'PayPal',
  'Venmo',
  'Bitcoin',
  'Ethereum',
  'Dogecoin',
  'Litecoin',
  'Monero',
  'Multibanco',
  'MB Way'
].each do |name|
  facility_amenity_category = FacilityAmenityCategory.find_by!(name: 'Payment')
  FacilityAmenity.find_or_create_by!(name:, facility_amenity_category:)
end

[
  'Wheelchair Accessibility',
  'Accessible Restrooms',
  'Quiet Zones',
  'Relaxation Areas'
].each do |name|
  facility_amenity_category = FacilityAmenityCategory.find_by!(name: 'Accessibility')
  FacilityAmenity.find_or_create_by!(name:, facility_amenity_category:)
end

[
  'Free Parking'
].each do |name|
  facility_amenity_category = FacilityAmenityCategory.find_by!(name: 'Other')
  FacilityAmenity.find_or_create_by!(name:, facility_amenity_category:)
end

############### WORK SPACE AMENITY CATEGORIES ######################

%w[
  Ergonomy
  Power
  Privacy
  Setup
  Other
].each do |name|
  WorkSpaceAmenityCategory.find_or_create_by!(name:)
end

############### WORK SPACE AMENITIES ######################

[
  'Standing Desk',
  'Adjustable Desk',
  'Ergonomic Chair',
  'Monitor Arm',
  'Footrest',
  'Wrist Rest'
].each do |name|
  work_space_amenity_category = WorkSpaceAmenityCategory.find_by!(name: 'Ergonomy')
  WorkSpaceAmenity.find_or_create_by!(name:, work_space_amenity_category:)
end

[
  'Monitor',
  'Keyboard',
  'Dual Monitors',
  'Ultrawide Monitor',
  'Printer'
].each do |name|
  work_space_amenity_category = WorkSpaceAmenityCategory.find_by!(name: 'Setup')
  WorkSpaceAmenity.find_or_create_by!(name:, work_space_amenity_category:)
end

[
  'Power Outlet',
  'USB Port',
  'Wireless Charger',
  'Power Strip',
  'Extension Cord',
  'Surge Protector',
  'Ethernet Connection'
].each do |name|
  work_space_amenity_category = WorkSpaceAmenityCategory.find_by!(name: 'Power')
  WorkSpaceAmenity.find_or_create_by!(name:, work_space_amenity_category:)
end

[
  'Private Space',
  'Privacy Screen',
  'Privacy Policy',
  'Restricted Access Areas'
].each do |name|
  work_space_amenity_category = WorkSpaceAmenityCategory.find_by!(name: 'Privacy')
  WorkSpaceAmenity.find_or_create_by!(name:, work_space_amenity_category:)
end
