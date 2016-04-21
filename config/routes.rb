Rails.application.routes.draw do
 
  root "wikis#index"
  devise_for :users
  resources :wikis
  resources :topics
end
