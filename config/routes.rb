Rails.application.routes.draw do
  resources :categories

  root "events#index"

  get "events/filter/:filter" => "events#index", as: :filtered_events

  resources :users
  get "signup" => "users#new"

  resources :events do
    resources :registrations
    resources :likes
  end

  resource :session, only: [:new, :create, :destroy]
end
