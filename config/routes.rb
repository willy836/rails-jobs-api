Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/registrations/register', to: 'registrations#register'
      post '/sessions/login', to: 'sessions#login'
      resources :jobs
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
