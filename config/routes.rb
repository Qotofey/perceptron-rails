Rails.application.routes.draw do
  resources :perceptrons
  resources :layers
  resources :words
  resources :questions
  resources :answers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
