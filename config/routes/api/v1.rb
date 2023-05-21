namespace :v1 do
  resources :users, concerns: :paginatable

  resources :businesses, concerns: :paginatable
  resources :business_types, concerns: :paginatable
  resources :business_facility_amenities, concerns: :paginatable
  resources :business_facility_amenity_categories

  resources :work_spaces, concerns: :paginatable
  resources :work_space_amenities, concerns: :paginatable
  resources :work_space_amenity_categories

  resources :countries, concerns: :paginatable
  resources :cities, concerns: :paginatable

  resources :bookings, concerns: :paginatable
  resources :reviews, concerns: :paginatable
end
