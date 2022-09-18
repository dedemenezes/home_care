Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get 'login', to: 'login/phone_messages#new', as: :login
  post 'login/phone_messages', to: 'login/phone_messages#create', as: :login_phone_messages
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
