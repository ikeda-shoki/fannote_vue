Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'post_images#top'
  get '/about', to: 'post_images#about'
  get '/use', to: 'post_images#use'

  resources :post_images, only: [:show, :index] do
    collection do
      get '/main', to: 'post_images#main'
    end
  end

  resources :users, only: [:show] do
    member do
      get "requesting", to: 'requests#requesting'
      get "requested", to: 'requests#requested'
    end
    resources :requests, only: [] do
      member do
        get :request_done
        get :request_complete
      end
    end
  end

  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :post_images, only: [:show, :index, :create, :update, :destroy] do
        resource :favorites, only: [:create, :destroy]
        resources :post_comments, only: [:create, :destroy]
        collection do
          get :main
        end
      end

      resources :users, only: [:show, :update] do
        collection do
          get :sign_in
        end
        member do
          get :followed
          get :following
          get "requesting", to: 'requests#requesting'
          get "requested", to: 'requests#requested'
        end
        resources :requests, only: [:create, :update, :destroy] do
          member do
            get :requesting_show
            get :requesting_show
            patch :update_request_status
            patch :update_request_complete_image
            get :request_done
            get :request_complete
          end
        end
      end

      post 'follow/:id', to: 'relationships#follow', as: 'follow'
      delete 'follow/:id', to: 'relationships#unfollow', as: 'unfollow'
    end
  end

end
