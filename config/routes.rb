Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'post_images#top'
  get '/about', to: 'post_images#about'
  get '/use', to: 'post_images#use'

  resources :post_images, only: [:index, :create, :update, :edit, :destroy] do
    collection do
      get '/main', to: 'post_images#main'
    end
  end

  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :post_images, only: [:create]
      get '/users/sign_in', to: 'users#sign_in?'
    end
  end

end
