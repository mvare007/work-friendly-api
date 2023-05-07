namespace :v1 do
  resources :users, concerns: :paginatable

  resources :businesses, concerns: :paginatable
  resources :business_types
  resources :business_users

  resources :business_facility_amenities
  resources :business_facility_amenity_categories
  resources :available_amenities

  resources :work_spaces

  resources :work_space_amenities
  resources :work_space_available_amenities
  resources :work_space_amenity_categories

  resources :countries
  resources :cities

  resources :bookings
  resources :reviews
  resources :schedule_days
end
