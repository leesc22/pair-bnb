Rails.application.routes.draw do
  get 'braintree/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Set up root
  root 'listings#index'

  # Override clearance route - #create
  resources :users, except: [:new] 
  #, only: [:create, :show, :edit, :update]

  # Start of clearance default routes
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # End of clearance default routes

  # Redirect user from Facebook login
  get '/auth/:provider/callback' => 'sessions#create_from_omniauth'
  
  # Listing
  resources :listings
  # custom method to show one user's all listings
  get "/users/:id/listings" => "listings#user_listings", as: "user_listings"
  # custom method to verify listing
  post "/listings/:id" => "listings#verify", as: "verify_listing"

  # Redirect from tags
  get 'tags/:tag' => 'listings#index', as: "tag"

  # Reservation
  resources :reservations, except: [:edit, :update]
  # custom method to show current user reservations
  get "/users/:id/reservations" => "reservations#user_reservations", as: "user_reservations"

  # braintree
  get 'braintree/new'
  post 'braintree/checkout'

  # payment
  resources :payments, only: [:create]
end
