Rails.application.routes.draw do
 
  root "wikis#index"
  devise_for :users
  resources :wikis do 
    resources :collaborators, only: [:create, :destroy, :index]
  end
  resources :topics
  resources :charges, only: [:new, :create]
  get 'downgrade' => 'charges#downgrade', :as => :downgrade
  
end
