Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users

  get 'login', to: 'twilio_code_messages#new', as: :login
  post 'login', to: 'twilio_code_messages#create', as: :create_login
  get 'confirmation', to: 'twilio_code_confirmations#new', as: :new_sms
  post 'confirmation', to: 'twilio_code_confirmations#create', as: :confirm_sms
  get 'profile', to: 'profiles#show', as: :profile
  resources :doctors, only: %i[index show]
  resources :users, only: [] do
    resources :consultations, only: :create
  end
  resources :consultations, only: :index

  resources :games, only: :index do
    resources :rounds, only: :create
  end

  resources :rounds, only: :show do
    member do
      get :score
    end
    resources :answers, only: %i[create update]
  end
end
