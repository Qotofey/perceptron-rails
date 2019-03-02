Rails.application.routes.draw do
  resources :perceptrons, except: [ :update, :destroy ] do
    collection do
      post :asking
      post :learning
    end
  end
  resources :layers, only: [ :index ]
  resources :words, only: [ :index ]
  resources :questions
  resources :answers
end
