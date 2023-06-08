namespace :v1 do
  devise_for :users, controllers: {
    sessions: 'api/v1/users/sessions',
    registrations: 'api/v1/users/registrations',
    passwords: 'api/v1/users/passwords',
    confirmations: 'api/v1/users/confirmations',
    unlocks: 'api/v1/users/unlocks'#,
    # omniauth_callbacks: 'api/v1/users/omniauth_callbacks'
  }
  resources :users, concerns: :paginatable do
    collection do
      get :datatable
    end
  end

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
