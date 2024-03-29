Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'post_images#top'
  get '/about', to: 'post_images#about'
  get '/use', to: 'post_images#use'
  get '/errors', to: 'users#errors'

  resources :post_images, only: [:show, :index] do
    collection do
      get :main
      get '/hashtag/:name', to: "post_images#hashtag"
    end
  end

  resources :users, only: [:show, :index] do
    member do
      get :followed
      get :following
      get "requesting", to: 'requests#requesting'
      get "requested", to: 'requests#requested'
    end
    collection do
      post :new_guest
      get :withdrawal
    end
    resources :requests, only: [] do
      member do
        get :request_done
        get :request_complete
      end
      resource :chats, only: :show
    end
  end

  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :post_images, only: [:show, :index, :create, :update, :destroy] do
        resource :favorites, only: [:create, :destroy]
        resources :post_comments, only: [:create, :destroy]
        collection do
          get :main
          get '/hashtag/:name', to: "post_images#hashtag"
        end
      end

      resources :users, only: [:show, :update, :index, :destroy] do
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
          resource :chats, only: [:show, :create, :destroy]
        end
      end

      resources :notifications, only: [:index, :destroy] do
        collection do
          delete :all_destroy
        end
      end

      post 'follow/:id', to: 'relationships#follow', as: 'follow'
      delete 'follow/:id', to: 'relationships#unfollow', as: 'unfollow'
    end
  end

end
