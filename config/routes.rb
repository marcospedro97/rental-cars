Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :manufacturers, only: %i[index show new create edit update]
  resources :subsidiaries, only: %i[index show new create edit update destroy]
  resources :car_categories, only: %i[index show new create edit update destroy]
  resources :clients, only: %i[index show new create]
  resources :car_models, only: %i[index show new create]
  resources :cars, only: %i[index show new create]
  resources :rentals, only: %i[index show new create] do
    get 'search', on: :collection
    post 'actualize_post', on: :member
    get 'actualize', on: :member
  end
  
  namespace :api do
    namespace :v1 do
     resources :cars, only: [:show,:index, :create] do
      patch 'status', on: :member
     end
     resources :rentals, only: [:show,:index, :create, :create]
    end
  end
end
