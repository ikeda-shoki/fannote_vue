Rails.application.routes.draw do
  get 'post_images/top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'post_images#top'

  namespace :api do
  end

end
