namespace :v1 do
  resources :users, concerns: :paginatable

  resources :businesses, concerns: :paginatable
  resources :business_types
  resources :business_users
  resources :business_facility_amenity_categories
  resources :business_facility_amenities, concerns: :paginatable

  resources :work_spaces
  resources :work_space_amenities
  resources :work_space_amenity_categories, concerns: :paginatable

  resources :countries
  resources :cities

  resources :bookings, concerns: :paginatable
  resources :reviews, concerns: :paginatable
  resources :schedule_days, except: [:show]
end
