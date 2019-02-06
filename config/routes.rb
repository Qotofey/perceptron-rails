Rails.application.routes.draw do
  resources :perceptrons do
    collection do
      post 'asking'
    end
  end
  resources :layers
  resources :words
  resources :questions
  resources :answers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
