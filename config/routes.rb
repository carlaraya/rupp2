Rails.application.routes.draw do
  get 'reviews/show'
  get 'reviews/new'
  get 'reviews/edit'
  resources :professors do
    resources :reviews
  end
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
