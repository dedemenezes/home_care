Rails.application.routes.draw do

  root to: "pages#home"
  devise_for :users

  get 'login', to: 'twilio_code_messages#new', as: :login
  post 'login', to: 'twilio_code_messages#create', as: :create_login
  get 'confirmation', to: 'twilio_code_confirmations#new', as: :new_sms
  post 'confirmation', to: 'twilio_code_confirmations#create', as: :confirm_sms
  get 'profile', to: 'users#profile', as: :profile
  # post 'login/phone_messages', to: 'login/phone_messages#create', as: :login_phone_messages
  # get '/confirmations/new', to: 'login/phone_confirmations#new', as: :new_login_phone_confirmation
  # post '/confirmations', to: 'login/phone_confirmations#create', as: :login_phone_confirmation
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
