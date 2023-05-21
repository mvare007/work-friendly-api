Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  concern :paginatable do
    get '(page/:page/per_page/:per_page)', action: :index, on: :collection, as: ''
  end

  namespace :api, constraints: ApiConstraint.new, defaults: { format: :json } do
    draw(:'api/v1')
  end
end
